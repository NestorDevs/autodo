import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String displayName, uuid;

  const Authenticated(this.displayName, this.uuid);

  @override
  List<Object> get props => [displayName, uuid];

  @override
  String toString() => 'Authenticated { displayName: $displayName, uuid: $uuid }';
}

class Unauthenticated extends AuthenticationState {
  final String errorCode;

  const Unauthenticated({this.errorCode});

  @override
  List<Object> get props => [errorCode];

  @override
  String toString() => 'Unauthenticated { errorCode: $errorCode }';
}