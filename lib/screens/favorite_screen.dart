import 'package:flutter/material.dart';
import '../services/favorite_service.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteService = FavoriteService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
        backgroundColor: const Color(0xFFF8BBD0),
        foregroundColor: const Color(0xFF880E4F),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: favoriteService.watchFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }

          final favorites = snapshot.data ?? [];

          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 12),
                  Text(
                    'Belum ada artikel favorit',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final item = favorites[index];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFEC407A),
                  child: Icon(Icons.favorite, color: Colors.white, size: 18),
                ),
                title: Text(
                  item['title'] ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () async {
                  await favoriteService.removeFavorite(item['id']);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Dihapus dari Favorite')),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
