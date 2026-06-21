import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  User? get currentUser => _auth.currentUser;

  // ----------- DAFTAR -----------
  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;

      // Simpan profil dasar ke Realtime Database
      await _db.child('users').child(uid).set({
        'name': name,
        'email': email,
        'instagram': '',
        'photoUrl': '',
      });

      await _saveSession(uid);
      return null; // null artinya sukses, tidak ada error
    } on FirebaseAuthException catch (e) {
      return _mapAuthError(e);
    }
  }

  // ----------- LOGIN -----------
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _saveSession(credential.user!.uid);
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapAuthError(e);
    }
  }

  // ----------- FORGOT PASSWORD -----------
  Future<String?> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapAuthError(e);
    }
  }

  // ----------- LOGOUT -----------
  Future<void> logout() async {
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // ----------- SESSION (SharedPreferences) -----------
  Future<void> _saveSession(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('uid', uid);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedInFlag = prefs.getBool('isLoggedIn') ?? false;
    // Validasi juga ke Firebase Auth, bukan cuma percaya local storage
    return loggedInFlag && _auth.currentUser != null;
  }

  // ----------- AMBIL PROFIL DARI REALTIME DATABASE -----------
  Future<Map<String, dynamic>?> getUserProfile() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    final snapshot = await _db.child('users').child(uid).get();
    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    }
    return null;
  }

  // ----------- PESAN ERROR DALAM BAHASA INDONESIA -----------
  String _mapAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Email sudah terdaftar, silakan login.';
      case 'invalid-email':
        return 'Format email tidak valid.';
      case 'weak-password':
        return 'Password terlalu lemah, minimal 6 karakter.';
      case 'user-not-found':
        return 'Akun dengan email ini tidak ditemukan.';
      case 'wrong-password':
        return 'Password yang dimasukkan salah.';
      case 'invalid-credential':
        return 'Email atau password salah.';
      default:
        return 'Terjadi kesalahan: ${e.message}';
    }
  }
}
