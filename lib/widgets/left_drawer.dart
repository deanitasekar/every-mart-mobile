import 'package:every_mart/screens/productentry_form.dart';
import 'package:flutter/material.dart';
import 'package:every_mart/screens/menu.dart';
import 'package:every_mart/screens/list_productentry.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Column(
              children: [
                Text(
                  'Every Mart',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(8)),
                Text(
                  "Toko Online Serba Ada untuk Semua Kebutuhan Anda",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  )
                ),
              ],
            ),
          ),
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Halaman Utama'),
                // Bagian redirection ke MyHomePage
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                      ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_shopping_cart),
                title: const Text('Tambah Produk'),
                // Bagian redirection ke MoodEntryFormPage
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductEntryFormPage()),
                  );
                },
              ),
              // Kode ListTile Menu
              ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text('Lihat Daftar Produk'),
                  onTap: () {
                      // Route menu ke halaman mood
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProductEntryPage()),
                      );
                  },
              ),
        ],
      ),
    );
  }
}