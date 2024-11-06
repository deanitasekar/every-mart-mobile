# Every Mart
### <b>🛒 Toko Online Serba Ada untuk Semua Kebutuhan Anda 🛒</b>
**Nama: Deanita Sekar Kinasih** <br>
**NPM: 2306229405**<br>
**Kelas: PBP-D**<br>
<hr>

<details>
<summary> <strong> Tugas 7: Elemen Dasar Flutter </strong> </summary>

### Jelaskan apa yang dimaksud dengan stateless widget dan stateful widget, dan jelaskan perbedaan dari keduanya.
Stateless Widget adalah widget yang tidak memiliki perubahan internal state selama aplikasi berjalan. Widget ini hanya bersifat statis dan tidak dapat diubah setelah page dibuat. <br>
Stateful Widget adalah widget yang memiliki perubahan internal state selama aplikasi berjalan. Widget ini dapat memberikan respon terhadap perubahan data dan melakukan refresh page untuk memperbarui konten yang ditampilkan pada page tersebut.<br>
Secara garis besar, Stateless Widget tidak memiliki state yang dapat berubah, sedangkan Stateful Widget memiliki state yang dapat berubah selama aplikasi berjalan. Stateless Widget cocok digunakan untuk page yang static (tidak terjadi refresh page), seperti gambar dan teks, sedangkan Stateful Widget cocok digunakan untuk page yang perlu memberikan respon terhadap request yang dapat menyebabkan perubahan, seperti form. Dalam pengembangan aplikasi Flutter, diperlukan pemilihan widget yang tepat agar aplikasi dapat berjalan dengan efisien karena setiap widget memiliki karakteristik yang berbeda.
<hr>

### Sebutkan widget apa saja yang kamu gunakan pada proyek ini dan jelaskan fungsinya.
- `MyApp - StatelessWidget`: StatelessWidget yang berfungsi sebagai aplikasi utama
- `MaterialApp`: Widget untuk kustomisasi dasar aplikasi dengan design Material (title, theme, dan lain-lain)
- `ThemeData`: Widget untuk mengatur theme aplikasi (font, colorScheme, dan lain-lain)
- `MyHomePage - StatelessWidget`: StatelessWidget yang berfungsi sebagai home page aplikasi
- `Scaffold`: Widget untuk kustomisasi struktur dasar page aplikasi (AppBar, body, dan lain-lain)
- `AppBar`: Widget untuk menampilkan bagian atas page
- `Text`: Widget untuk menampilkan teks pada page
- `TextStyle`: Widget kustomisasi tampilan teks (size, color, dan lain-lain)
- `SingleChildScrollView`: Widget wrapper untuk membuat page dapat di-scroll jika ukurannya melebihi layar
- `Padding`: Widget untuk mengatur padding/jarak di sekitar widget child
- `Column`: Widget untuk mengatur widget child dalam kolom vertikal
- `GridView.count`: Widget untuk mengatur widget child dalam bentuk grid sesuai jumlah baris dan kolom
- `ItemCard - StatelessWidget`: StatelessWidget untuk menampilkan ItemHomepage
- `Material`: Widget untuk kustomisasi desain Material pada widget (elevation, color, dan lain-lain)
- `InkWell`: Widget untuk memberikan respons ketika widget dipencet
- `SnackBar`: Widget untuk menampilkan pesan sementara kepada User
- `Container`: Widget ini digunakan untuk mengatur tata letak widget
- `Center`: Widget untuk mengatur posisi widget child ke tengah
- `Icon`: Widget untuk menampilkan ikon yang dapat dikustomisasi (size, color, dan lain-lain)
<hr>

### Apa fungsi dari setState()? Jelaskan variabel apa saja yang dapat terdampak dengan fungsi tersebut.
Fungsi dari `setState()` adalah memberitahu framework Flutter mengenai perubahan pada state dari suatu widget. Ketika `setState()` dipanggil, framework Flutter akan melakukan pemanggilan ulang `build()` sehingga tampilan UI akan diperbarui sesuai dengan perubahan yang terjadi. Variabel yang terdampak dari fungsi `setState()` adalah variabel yang berada di dalam State dari `StatefulWidget`. Contoh variabel yang terdampak adalah teks dinamis, kondisi interaktif, dan data dari database.
<hr>

### Jelaskan perbedaan antara const dengan final.
`const` digunakan untuk mendefinisikan variabel yang diatur pada saat kompilasi dan tidak bisa diubah. Nilai pada variabel `const` harus ditentukan saat compile, tidak dapat ditentukan saat runtime. Variabel ini biasanya digunakan untuk variabel yang tidak berubah, seperti warna dan konstanta matematika.<br>
Contoh:
```dart
ItemHomepage("Lihat Daftar Produk", Icons.list, const Color(0xFF2E8B57)),
```
`final` digunakan untuk mendefinisikan variabel yang hanya dapat diinisialisasi sekali dan tidak dapat diubah setelahnya. Nilai pada variabel `final` dapat ditentukan saat compile maupun saat runtime. Variabel ini biasanya digunakan untuk variabel yang nilainya tidak berubah saat runtime, tetapi nilainya belum dapat diketahui saat compile, seperti input pengguna atau hasil perhitungan.<br>
Contoh:
```dart
class ItemHomepage {
    final String name;
    final IconData icon;
    final Color color;

    ItemHomepage(this.name, this.icon, this.color);
}
```
Secara keseluruhan, variabel `const` harus diinisialisasi saat compile dan tidak dapat diubah nilainya, sedangkan variabel `final` dapat diinisialiasasi saat compile atau runtime dan hanya dapat diinisialisasi sekali (tidak dapat diubah lagi setelahnya). Penggunaan variabel `const` dan `final` bergantung dengan nilai dari variabel tersebut.
<hr>

### Jelaskan bagaimana cara kamu mengimplementasikan checklist-checklist di atas.

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
        ItemHomepage("Tambah Produk", Icons.add, const Color(0xFFFF8C00)),
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
<hr>
</details>
