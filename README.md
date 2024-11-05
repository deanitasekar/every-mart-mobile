# Every Mart
### <b>🛒 Toko Online Serba Ada untuk Semua Kebutuhan Anda 🛒</b>
**Nama: Deanita Sekar Kinasih** <br>
**NPM: 2306229405**<br>
**Kelas: PBP-D**<br>
<hr>

<details>
<summary> <strong> Tugas 7: Elemen Dasar Flutter </strong> </summary>

### Jelaskan apa yang dimaksud dengan stateless widget dan stateful widget, dan jelaskan perbedaan dari keduanya.

### Sebutkan widget apa saja yang kamu gunakan pada proyek ini dan jelaskan fungsinya.

### Apa fungsi dari setState()? Jelaskan variabel apa saja yang dapat terdampak dengan fungsi tersebut.

### Jelaskan perbedaan antara const dengan final.

### Jelaskan bagaimana cara kamu mengimplementasikan checklist-checklist di atas.
<br>

**Membuat sebuah program Flutter baru dengan tema E-Commerce**
- Masuk ke direktori lokal dan generate proyek baru pada terminal
```
flutter create <APP_NAME>
cd <APP_NAME>
```
- Menjalankan proyek melalui terminal
```
flutter run
```
- Melakukan modifikasi `main.dart` agar home page berada di `menu.dart`
```dart
import 'package:flutter/material.dart';
import 'package:every_mart/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.green,
        ).copyWith(primary: const Color(0xFF2E8B57), secondary: const Color(0xFFFF8C00), ),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
```
- Melakukan modifikasi class `MyHomePage` pada `menu.dart` menjadi Stateless Widget, membuat Card berisi Nama, NPM, dan Kelas, serta menambahkan class InfoCard pada `menu.dart` untuk menampilkan Card
```dart
class MyHomePage extends StatelessWidget {
    MyHomePage({super.key});

    final String npm = '2306229405';
    final String name = 'Deanita Sekar Kinasih';
    final String className = 'PBP D';

    @override
    Widget build(BuildContext context) {
    ...
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: name),
                InfoCard(title: 'Class', content: className),
              ],
            ), ], }, }
    ...
class InfoCard extends StatelessWidget {
    final String title;
    final String content;

    const InfoCard({super.key, required this.title, required this.content});

    @override
    Widget build(BuildContext context) {
        return Card(
        elevation: 2.0,
        child: Container(
            width: MediaQuery.of(context).size.width / 3.5,
            padding: const EdgeInsets.all(16.0),
            child: Column(
            children: [
                Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(content),
            ],
            ),
        ),
        );
    }
}
...
```
**Membuat tiga tombol sederhana dengan ikon dan teks**
- Menambahkan class `ItemHomePage` pada `menu.dart`
```dart
class ItemHomepage {
    final String name;
    final IconData icon;
    final Color color;

    ItemHomepage(this.name, this.icon, this.color);
}
```
- Melakukan modifikasi class `MyHomePage` pada `menu.dart` dengan menambahkan `final List<ItemHomepage> items` dan menerapkan warna yang berbeda untuk setiap tombol
```dart
    final List<ItemHomepage> items = [
        ItemHomepage("Lihat Daftar Produk", Icons.list, const Color(0xFF2E8B57)),
        ItemHomepage("Tambah Product", Icons.add, const Color(0xFFFF8C00)),
        ItemHomepage("Logout", Icons.logout, const Color(0xFFFF6347)),
    ];
```
**Memunculkan Snackbar**
- Membuat class `ItemCard` untuk menampilkan snackbar yang berisi pesan "Kamu telah menekan tombol [nama button]"
```dart
class ItemCard extends StatelessWidget {

  final ItemHomepage item; 
  const ItemCard(this.item, {super.key}); 

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
            );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```
**Integrasi InfoCard dan ItemCard**
- Melakukan modifikasi class `MyHomePage` pada `menu.dart` untuk menampilkan `InfoCard` dan `ItemCard` di `MyHomePage`
```dart
class MyHomePage extends StatelessWidget {
    ...
    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            title: const Text(
            'Every Mart',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
            ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    InfoCard(title: 'NPM', content: npm),
                    InfoCard(title: 'Name', content: name),
                    InfoCard(title: 'Class', content: className),
                ],
                ),

                const SizedBox(height: 16.0),

                Center(
                child: Column(
                    children: [
                    const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Text(
                        'Welcome to Every Mart',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                        ),
                        ),
                    ),

                    GridView.count(
                        primary: true,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        shrinkWrap: true,

                        children: items.map((ItemHomepage item) {
                        return ItemCard(item);
                        }).toList(),
                    ),
                    ],
                ),
                ),
            ],
            ),
        ),
        );
    }
}
```
**Github**
- Membuat repositori baru dengan nama `every-mart-mobile`
- Menghubungkan direktori lokal dengan GitHub dan mengunggah perubahan
```
git init
git add .
git commit -m "..."
git branch -M main
git remote add origin https://github.com/deanitasekar/every-mart-mobile.git
git push -u origin main
```
</details>
