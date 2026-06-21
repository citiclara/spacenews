import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8BBD0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                // Gambar ilustrasi e-commerce dari Freepik (lokal)
                child: Image.asset(
                  'assets/images/logo.jpg',
                  height: 260,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 260,
                    color: const Color(0xFFEC407A),
                    child: const Icon(Icons.image_not_supported,
                        color: Colors.white, size: 60),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Welcome to SpaceNews Core Application',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Berita dan informasi terkini seputar dunia antariksa, langsung dari sumber terpercaya.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFEC407A),
                  ),
                  child: const Text('Mulai'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
