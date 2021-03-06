import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_repository.dart';

typedef GetGoogleCredentialsFn = AuthCredential Function(
    {String accessToken, String idToken});

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final GetGoogleCredentialsFn _getGoogleCredential;
  FirebaseUser _cachedCurrentUser;

  FirebaseAuthRepository({
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignin,
    GetGoogleCredentialsFn getGoogleCredential,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn(),
        _getGoogleCredential =
            getGoogleCredential ?? GoogleAuthProvider.getCredential;

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = _getGoogleCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    AuthResult res = await _firebaseAuth.signInWithCredential(credential);
    _cachedCurrentUser = res.user;
    return res.user;
  }

  Future<FirebaseUser> signInWithCredentials(
      String email, String password) async {
    AuthResult res = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    _cachedCurrentUser = res.user;
    return res.user;
  }

  Future<FirebaseUser> signUp(String email, String password) async {
    var res = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    _cachedCurrentUser = res.user;
    return res.user;
  }

  Future<FirebaseUser> signUpWithVerification(
      String email, String password) async {
    var user = await signUp(email, password);
    await user.sendEmailVerification();
    return user;
  }

  Future<void> signOut() async {
    _cachedCurrentUser = null;
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<void> deleteCurrentUser() async {
    try {
      var user = _cachedCurrentUser ?? await _firebaseAuth.currentUser();
      print(user);
      print('cache $_cachedCurrentUser');
      _cachedCurrentUser = null;
      return user.delete();
    } on PlatformException catch (e) {
      // if exception is thrown because user doesn't exist, ignore it for now
      print(e);
    }
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getCurrentUser() {
    return _firebaseAuth.currentUser();
  }

  Future<String> getUserEmail() async {
    return (await _firebaseAuth.currentUser()).email;
  }

  Future<String> getUserId() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<void> sendPasswordReset(String email) async {
    return (await _firebaseAuth.sendPasswordResetEmail(email: email));
  }

  @override
  Stream<FirebaseUser> get stream => _firebaseAuth.onAuthStateChanged;
}
