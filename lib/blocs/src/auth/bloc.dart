// Copyright 2020 Jonathan Bayless
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:autodo/repositories/repositories.dart';

import 'event.dart';
import 'state.dart';

/// A [Bloc] used for determining if there is an active, authenticated user.
/// 
/// This is intended to be at the highest level of the Bloc hierarchy, as the 
/// behavior of most of the other Blocs in the system rely on the assumption 
/// that there is a user logged in.
/// 
/// The AuthenticationBloc is intended to perform the action of logging out 
/// and deleting users, but not logging in or signing in. The intent behind this
/// distinction is to provide the logout/deletion actions to the home screen 
/// presentation layers as they do not warrant their own Blocs. The signup and 
/// login actions are provided by the [SignupBloc] and [LoginBloc] respectively.
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _userRepository;

  /// Creates an AuthenticationBloc. 
  /// 
  /// The [userRepository] parameter must be non-null. The [userRepository] 
  /// is responsible for providing a stream of changes to the authentication
  /// database that will be translated into [AuthenticationEvent]s and then
  /// [AuthenticationState]s.
  AuthenticationBloc({@required AuthRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository {
    _userRepository.stream?.listen((user) {
      if (user != null &&
          (!(state is Authenticated) ||
              (state as Authenticated).uuid != user.uid)) {
        // sign in or sign up
        if (user.metadata.creationTime == user.metadata.lastSignInTime) {
          add(SignedUp());
        } else {
          add(LoggedIn());
        }
      }
    });
  }

  @override
  AuthenticationState get initialState => Uninitialized();

  /// Transforms an input of type [AuthenticationEvent] into an output of type 
  /// [AuthenticationState].
  /// 
  /// The behavior of the Bloc varies based on the child class of 
  /// [AuthenticationEvent] that is given.
  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LogOut) {
      yield* _mapLogOutToState();
    } else if (event is DeletedUser) {
      yield* _mapDeletedUserToState();
    } else if (event is SignedUp) {
      yield* _mapSignedUpToState();
    }
  }

  /// Transforms an [AppStarted] event into an [AuthenticationState].
  /// 
  /// Under normal conditions, this checks the user repository for a logged in
  /// user and collects the necesary information for the user. In an integration
  /// test, however, this is responsible for creating a dummy user.
  Stream<AuthenticationState> _mapAppStartedToState(event) async* {
    try {
      final repo = FirebaseAuthRepository();
      if ((event as AppStarted).integrationTest ?? false) {
        await repo.signOut();
        await repo.signInWithCredentials(
            'integration-test@autodo.app', '123456');
        await repo.deleteCurrentUser();
      }
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final name = await _userRepository.getUserEmail();
        String uuid = await _userRepository.getUserId();
        yield Authenticated(name, uuid, false);
      } else {
        yield Unauthenticated();
      }
    } catch (e) {
      print(e);
      yield Unauthenticated();
    }
  }

  /// Responds to a [LoggedIn] event with an [Authenticated] state.
  /// 
  /// Always yields [Authenticated]. This differs from the [SignedUp] event 
  /// handler simply by passing a corresponding flag to the yielded state.
  Stream<AuthenticationState> _mapLoggedInToState() async* {
    var _email = await _userRepository.getUserEmail();
    var _uuid = await _userRepository.getUserId();
    yield Authenticated(_email, _uuid, false);
  }

  /// Responds to a [SignedUp] event with an [Authenticated] state.
  /// 
  /// Always yields [Authenticated]. This differs from the [LoggedIn] event 
  /// handler simply by passing a corresponding flag to the yielded state.
  Stream<AuthenticationState> _mapSignedUpToState() async* {
    var _email = await _userRepository.getUserEmail();
    var _uuid = await _userRepository.getUserId();
    yield Authenticated(_email, _uuid, true);
  }

  /// Signs out the currently logged in user and yields [Unauthenticated].
  /// 
  /// This is responsible for the business logic of signing out, unlike the 
  /// [LoggedIn] and [SignedUp] events to make the action more easily accessible
  /// to the home screen presentation layer.
  Stream<AuthenticationState> _mapLogOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }

  /// Deletes all data associated with the currently logged in user and yields 
  /// [Unauthenticated].
  /// 
  /// This is responsible for the business logic of signing out, unlike the 
  /// [LoggedIn] and [SignedUp] events to make the action more easily accessible
  /// to the home screen presentation layer.
  Stream<AuthenticationState> _mapDeletedUserToState() async* {
    yield Unauthenticated();
    await _userRepository.deleteCurrentUser();
  }
}
