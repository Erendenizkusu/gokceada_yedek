import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  //Google Sign In
  signInWithGoogle() async {
    //begin interactive sign in progress
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtaiin auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //finally, lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Apple Sign In (iOS). Apple requires an equivalent login option when a
  // third-party sign-in (Google) is offered — App Store Guideline 4.8.
  Future<UserCredential> signInWithApple() async {
    // Apple requires a nonce; we send the SHA-256 hash and verify with the raw.
    final String rawNonce = _generateNonce();
    final String hashedNonce = _sha256(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);

    // Apple only returns the full name on the FIRST sign-in; capture it once.
    final String? givenName = appleCredential.givenName;
    final String? familyName = appleCredential.familyName;
    if ((userCredential.user?.displayName == null ||
            userCredential.user!.displayName!.isEmpty) &&
        (givenName != null || familyName != null)) {
      final fullName = [givenName, familyName]
          .where((p) => p != null && p.isNotEmpty)
          .join(' ')
          .trim();
      if (fullName.isNotEmpty) {
        await userCredential.user?.updateDisplayName(fullName);
      }
    }

    return userCredential;
  }

  // Cryptographically secure random string for the Apple nonce.
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
        length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  String _sha256(String input) {
    final bytes = utf8.encode(input);
    return sha256.convert(bytes).toString();
  }
}
