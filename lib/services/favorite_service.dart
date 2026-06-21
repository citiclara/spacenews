import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FavoriteService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  // Reference ke node favorites milik user yang sedang login
  DatabaseReference? get _favRef {
    if (_uid == null) return null;
    return _db.child('favorites').child(_uid!);
  }

  // Simpan artikel ke favorite
  Future<void> addFavorite({
    required int articleId,
    required String title,
  }) async {
    final ref = _favRef;
    if (ref == null) return;
    await ref.child(articleId.toString()).set({
      'id': articleId,
      'title': title,
    });
  }

  // Hapus artikel dari favorite
  Future<void> removeFavorite(int articleId) async {
    final ref = _favRef;
    if (ref == null) return;
    await ref.child(articleId.toString()).remove();
  }

  // Cek apakah artikel tertentu sudah jadi favorite
  Future<bool> isFavorite(int articleId) async {
    final ref = _favRef;
    if (ref == null) return false;
    final snapshot = await ref.child(articleId.toString()).get();
    return snapshot.exists;
  }

  // Stream realtime untuk halaman Favorite (update otomatis kalau ada perubahan)
  Stream<List<Map<String, dynamic>>> watchFavorites() {
    final ref = _favRef;
    if (ref == null) return const Stream.empty();

    return ref.onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return <Map<String, dynamic>>[];

      final map = Map<String, dynamic>.from(data as Map);
      return map.values
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    });
  }
}
