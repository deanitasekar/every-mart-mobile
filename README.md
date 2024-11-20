# Every Mart
### <b>🛒 Toko Online Serba Ada untuk Semua Kebutuhan Anda 🛒</b>
**Nama: Deanita Sekar Kinasih** <br>
**NPM: 2306229405**<br>
**Kelas: PBP-D**<br>
<hr>

<details>
<summary> <strong> Tugas 9: Integrasi Layanan Web Django dengan Aplikasi Flutter </strong> </summary>

### Jelaskan mengapa kita perlu membuat model untuk melakukan pengambilan ataupun pengiriman data JSON? Apakah akan terjadi error jika kita tidak membuat model terlebih dahulu?
Kita perlu membuat model untuk melakukan pengambilan ataupun pengiriman data JSON karena beberapa alasan, yaitu:
- Standardisasi data <br>
  Ketika kita menerima atau mengirim data JSON, model berfungsi untuk memastikan bahwa struktur data selalu konsisten dan sesuai dengan ketentuan. Tanpa model, data akan menjadi rentan terhadap kesalahan format dan sulit untuk divalidasi.
- Mempermudah konversi <br>
  JSON adalah format string yang memerlukan aprsing untuk dapat digunakan dalam aplikasi. Dengan adanya model, proses konversi antara JSON dan objek menjadi lebih mudah dan terstruktur. Hal ini tidak hanya meningkatkan efisiensi, tetapi juga mengurangi kesalahan manipulasi data. <br>
Jika kita tidak membuat model terlebih dahulu, terdapat kemungkinan terjadi error. Aplikasi menjadi lebih rentan terhadap runtime error seperti `NoSuchMethodError` atau `TypeError`. Selain itu, proses debugging menjadi lebih sulit karena IDE tidak dapat memberikan warning tentang ketidaksesuaian tipe data atau properti yang hilang. Ketika aplikasi berkembang, pengelolaan data tanpa model menjadi semakin kompleks. <br>
Meskipun ada situasi di mana kita tidak perlu membuat model terlebih dahulu, pengembangan tanpa model tidak direkomendasikan. Penggunaan model dapat meningkatkan maintainability, readability, dan reliability secara signifikan, serta membantu pengembangan aplikasi.
<hr>

### Jelaskan fungsi dari library http yang sudah kamu implementasikan pada tugas ini
Library HTTP berperan penting untuk menghubungkan antara aplikasi Flutter dan backend Django. Pada implementasi tugas ini, library http fugunakan untuk melakukan berbagai operasi HTTP yang penting dalam aplikasi. Secara spesifik, saya menggunakan library HTTP untuk mengirim request `GET` ke endpoint Django untuk mengambil data produk, melakukan request `POST` untuk proses autentikasi dan registrasi, serta mengirim data form ketika menambahkan produk baru. Library HTTP memiliki kemampuan untuk menangani proses asynchronous, sehingga aplikasi tetap responsif selama proses pertukaran data dengan server berlangsung.
<hr>

### Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
Beberapa fungsi dari CookieRequest, yaitu:
- Mengelola Cookie secara otomatis <br>
  `CookieRequest` menyimpan dan mengirimkan cookie yang diperlukan oleh Django untuk mengenali User yang sedang login
- Mendukung operasi HTTP <br>
  `CookieRequest` menyediakan beberapa metode yang memudahkan interaksi dengan server Django, seperti `login`, `logout`, dan `get`
- Mendukung CSRF token Django <br>
  `CookieRequest` menangani CSRF token secara otomatis untuk operasi `POST`, `PUT`, dan `DELETE`
Instance `CookieRequest` perlu dibagikan ke seluruh komponen di aplikasi Flutter melalui `Provider` karena beberapa alasan, yaitu:
- Menciptakan single source of truth untuk autentikasi, memastikan bahwa semua komponen aplikasi mengakses data sesi yang sama dan konsisten
- Menghindari pembuatan isntance baru di setiap komponen yang membutuhkan akses ke data sesi sehingga User tidak perlu melakukan autentikasi ulang ketika berpindah antar halaman atau menggunakan fitur yang berbeda
- Menyederhanakan pengelolaan state aplikasi secara keseluruhan akrena perubahan langsung tercermin di seluruh aplikasi, mengurangi terjadinya inkonsistensi dalam autentikasi pengguna
<hr>

### Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
- User melakukan input data melalui widget dan data form disimpan dalam variabel
- Data dikonversi ke format JSON dan request HTTP disiapkan dengan library `http/CookieRequest`
- Data JSON dikirim ke endpoint Django. Kemudian, server menerima dan memproses data lalu server mengirim response JSON
- Flutter menerima respons JSON. Lalu, data JSON di-decode menjadi objek Dart dan data dikonversi sesuai model yang dibuat
- FutureBuilder digunakan untuk mengelola data asynchronous dan data ditampilkan melalui widget UI
<hr>

### Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
**Register**
- User melakukan input data untuk register melalui widget Flutter
- Data dikirim ke Django untuk dilakukan validasi
- Django menyimpan data dari User
- Flutter menampilkan status setelah User melakukan input data

**Login**
- User melakukan input data untuk login melalui widget Flutter
- Data dikirim ke Django untuk dilakukan pemeriksaan data
- Django mengelola sesi dan Fluter menyimpan status login
- User diarahkan ke halaman menu

**Logout**
- User mengirimkan request logout melalui widget Flutter
- Django menghapus sesi dan Flutter menghapus status login
- User diarahkan ke halaman login
<hr>

### Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).

**Memastikan deployment proyek tugas Django telah berjalan dengan baik**
- Memastikan Django berjalan pada local host dan PWS
- Menambahkan konfigurasi `ALLOWED_HOSTS` di `settings.py` pada direktori `every_mart` untuk integrasi Django dari emulator Android
```py
ALLOWED_HOSTS = [..., ..., "10.0.2.2"]
```
- Menginstal library yang diperlukan dan menambahkan `django-cors-headers`
**Mengimplementasikan fitur registrasi akun pada proyek tugas Flutter**
- Membuat file `register.dart` pada `lib/screens/`, menambahkan TextField untuk `username`, `password`, dan `confirmPassword`, serta memanggil API Django dengan `CookieRequest`
```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:every_mart/screens/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () async {
                      String username = _usernameController.text;
                      String password1 = _passwordController.text;
                      String password2 = _confirmPasswordController.text;

                      // Cek kredensial
                      final response = await request.postJson(
                          "http://localhost:8000/auth/register/",
                          jsonEncode({
                            "username": username,
                            "password1": password1,
                            "password2": password2,
                          }));
                      if (context.mounted) {
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Successfully registered!'),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to register!'),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```
- Menambahkan endopoint `/auth/register/` di Django yang menerima data username dan password
- Jika berhasil, User akan masuk ke halaman login. Jika gagal, akan terdapat pesan error
**Membuat halaman login pada proyek tugas Flutter**
- Membuat file `login.dart` pada `lib/screens/`, menambahkan TextField untuk `username` dan `password`, dan memanggil endpoint `/auth/login/`
```dart
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:every_mart/screens/menu.dart';
import 'register.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.green,
        ).copyWith(primary: const Color(0xFF2E8B57), secondary: const Color(0xFFFF8C00)),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () async {
                      String username = _usernameController.text;
                      String password = _passwordController.text;

                      // Cek kredensial
                      final response = await request
                          .login("http://localhost:8000/auth/login/", {
                        'username': username,
                        'password': password,
                      });

                      if (request.loggedIn) {
                        String message = response['message'];
                        String uname = response['username'];
                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                  content:
                                      Text("$message Selamat datang, $uname.")),
                            );
                        }
                      } else {
                        if (context.mounted) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Login Gagal'),
                              content: Text(response['message']),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 36.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    child: Text(
                      'Don\'t have an account yet? Register now',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```
- Menggunakan `CookieReguest` untuk login. Jika berhasil, User akan masuk ke halaman utama aplikasi. Jika gagal, akan terdapat pesan error
- Menyimpan status login menggunakan `Provider`
```
flutter pub add provider
flutter pub add pbp_django_auth
```
```dart
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Every Mart',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: Colors.green,
          ).copyWith(primary: const Color(0xFF2E8B57), secondary: const Color(0xFFFF8C00)),
        ),
        home: const LoginPage(),
      ),
    );
  }
```
**Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter**
- Menambahkan package `pbp_django_auth` untuk mengelola session dan mengatur `Provider` pada root aplikasi di `main.dart`
- Menggunakan `/auth/login/` untuk login dan `/auth/logout/` untuk logout
- Melakukan konfigurasi middleware CORS dan CSRF di Django
```py
CORS_ALLOW_ALL_ORIGINS = True
CORS_ALLOW_CREDENTIALS = True
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SAMESITE = 'None'
SESSION_COOKIE_SAMESITE = 'None'
```
**Membuat model kustom sesuai dengan proyek aplikasi Django**
- Menyimpan model yang sesuai dengan aplikasi Django di `lib/models/` dengan file `product_entry.dart`
```dart
import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(
    json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
  String model;
  String pk;
  Fields fields;

  ProductEntry({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  String user;
  String name;
  int price;
  String description;
  int stock;

  Fields({
    required this.user,
    required this.name,
    required this.price,
    required this.description,
    required this.stock,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"].toString(),
        name: json["name"],
        price: json["price"],
        description: json["description"],
        stock: json["stock"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "price": price,
        "description": description,
        "stock": stock,
      };
}
```
**Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django**
- Menambahkan dependensi HTTP dan melakukan modifikasi `android/app/src/main/AndroidManifest.xml`
```
flutter pub add http
```
```xml
...
    <application>
    ...
    </application>
    <!-- Required to fetch data from the Internet. -->
    <uses-permission android:name="android.permission.INTERNET" />
...
```
- Melakukan fetch data dari Django
- Menggunakan `FutureBuilder` untuk menampilkan daftar item dengan melakukan membuat `list_productentry.dart` pada `lib/screens/`, mengatur tampilan daftar dengan widget `ListView.builder`, serta menampilkan atribut `name`, `price`, `description`, dan `stock`
```dart
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:every_mart/models/product_entry.dart';
import 'package:every_mart/widgets/left_drawer.dart';

class ProductEntryPage extends StatefulWidget {
  const ProductEntryPage({super.key});

  @override
  State<ProductEntryPage> createState() => _ProductEntryPageState();
}

class _ProductEntryPageState extends State<ProductEntryPage> {
  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    final response = await request.get('http://localhost:8000/json/');
    
    // Melakukan decode response menjadi bentuk json
    var data = response;
    
    // Melakukan konversi data json menjadi object ProductEntry
    List<ProductEntry> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(ProductEntry.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Produk'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    'Belum ada data produk',
                    style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snapshot.data![index].fields.name}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                        const SizedBox(height: 10),
                        Text("Price: Rp${snapshot.data![index].fields.price}"),
                        const SizedBox(height: 10),
                        Text("Stock: ${snapshot.data![index].fields.stock}"),
                        const SizedBox(height: 10),
                        Text("Description: ${snapshot.data![index].fields.description}"),
                    ],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
```
**Membuat halaman detail untuk setiap item**
- Menambahkan gesture pada item di daftar untuk membuka halaman detail dan menggunakan `Navigator.push()` untuk halaman baru
- Menampilkan detail atribut dari item dengan widget `Text` atau `Card`
**Melakukan filter item berdasarkan pengguna yang login**
- Melakukan modifikasi endpoint Django untuk mengembailkan item sesuai Useryang login dan menggunakan `request.user` pada `views.py` di Django untuk mendapatkan data sesuai User
```py
@csrf_exempt
def create_product_flutter(request):
    if request.method == 'POST':

        data = json.loads(request.body)
        new_product = Product.objects.create(
            user=request.user,
            name = data["name"],
            price = int(data["price"]),
            description = data["description"],
            stock = int(data["stock"]),
        )

        new_product.save()

        return JsonResponse({"status": "success"}, status=200)
    else:
        return JsonResponse({"status": "error"}, status=401)
```    
**Github dan PWS**
- Menggungah perubahan pada respositori `every-mart-mobile`
```
git add .
git commit -m "..."
git push -u origin main
```
- Menggungah perubahan pada respositori `every-mart` dan melakukan redeploy pada PWS
```
git add .
git commit -m "..."
git push origin main

git branch -M main
git push pws main:master
```
</details>

<details>
<summary> <strong> Tugas 8: Flutter Navigation, Layouts, Forms, and Input Elements </strong> </summary>

### Apa kegunaan const di Flutter? Jelaskan apa keuntungan ketika menggunakan const pada kode Flutter. Kapan sebaiknya kita menggunakan const, dan kapan sebaiknya tidak digunakan?
`const` digunakan untuk membuat objek yang nilainya tidak berubah selama aplikasi berjalan, diinisialisasi saat compile-time, serta hanya dibuat sekali dan disimpan dalam memori.<br>
Keuntungan menggunakan `const` adalah optimasi performa dengan mengurangi beban memori karena objek hanya dibuat sekali dan meningkatkan kecepatan rendering aplikasi. Selain itu, penggunaan `const` menjamin nilai tidak berubah secara tidak sengaja sehingga memudahkan debugging.<br>
`const` sebaiknya digunakan pada elemen yang bersifat statis dan nilainya sudah diketahui sebelum di-compile. Penggunaan `const` pada elemen ini akan meningkatkan performa karena widget hanya perlu dibuat sekali dan disimpan dalam memori. <br>
Contoh penggunaan:
```dart
const Text('Welcome')
const SizedBox(height: 10)
const EdgeInsets.all(16.0)
const Color primaryColor = Colors.blue
```
`const` sebaiknya tidak digunakan pada widget yang nilainya berubah saat runtime. Penggunaan `const` pada data dinamis akan menyebabkan error karena bertentangan dengan sifat `const` yang immutable. <br>
Contoh penggunaan:
```dart
Text(userInput)
Text(DateTime.now().toString())
TextField(controller: controller)
```
<hr>

### Jelaskan dan bandingkan penggunaan Column dan Row pada Flutter. Berikan contoh implementasi dari masing-masing layout widget ini!
![Column](/column.jpg) <br>
`Column` berfungsi untuk menyusun widget-widget child secara vertikal dari atas ke bawah, dengan main axis yang berjalan vertikal dan cross axis horizontal. Contoh implementasi `Column`:
```dart
Column(
  children: <Widget>[
    Text('Item 1'),
    Text('Item 2'),
    Text('Item 3'),
  ],
)
```
![Row](/row.jpg) <br>
`Row` digunakan untuk menyusun widget-widget child secara horizontal dari kiri ke kanan, dengan main axis yang berjalan horizontal dan cross axis vertikal. Contoh implementasi `Row`:
```dart
Row(
  children: [
    Expanded(child: Text('Item 1')),
    Expanded(child: Text('Item 2')),
    Expanded(child: Text('Item 3')),
  ],
)
```
Kedua widget ini dapat dikombinasikan untuk membuat layout yang lebih kompleks. Penggunaan `Column` dan `Row` serta kombinasinya dapat menciptakan layout UI yang fleksibel dan responsif serta kebutuhan aplikasi Flutter. <br>
Referensi: [Compelling Layout With Flutter Row And Column](https://www.dhiwise.com/post/how-to-create-compelling-layout-with-flutter-row-and-column)
<hr>

### Sebutkan apa saja elemen input yang kamu gunakan pada halaman form yang kamu buat pada tugas kali ini. Apakah terdapat elemen input Flutter lain yang tidak kamu gunakan pada tugas ini? Jelaskan!
Pada halaman form yang saya buat, elemen input yang saya gunakan, yaitu:
- `TextFromField` untuk input dengan 4 field, yaitu nama produk, harga produk, deskripsi produk, dan stock produk

Terdapat beberapa elemen Flutter yang tidak saya gunakan, di antaranya:
- `Radio` untuk memilih satu opsi dari beberapa pilihan
- `Checkbox` untuk input boolean
- `Switch` untuk alternatif dari checkbox dengan tampilan yang berbeda
- `Slider` untuk memilih nilai dalam rentang tertentu
- `FileUploadField` untuk mengunggah file
<hr>

### Bagaimana cara kamu mengatur tema (theme) dalam aplikasi Flutter agar aplikasi yang dibuat konsisten? Apakah kamu mengimplementasikan tema pada aplikasi yang kamu buat?
Dalam mengembangkan aplikasi Flutter, saya mengimplementasikan tema menggunakan `ThemeData` pada `MaterialApp` yang didefinisikan di `main.dart`. Saya menggunakan `ColorScheme` dengan detail sebagai berikut:
```dart
MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.green,
        ).copyWith(primary: const Color(0xFF2E8B57), secondary: const Color(0xFFFF8C00)),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
```
<hr>

### Bagaimana cara kamu menangani navigasi dalam aplikasi dengan banyak halaman pada Flutter?
Saya mengelola navigasi banyak halaman pada Flutter menggunakan sistem Navigator dengan 3 metode utama, yaitu:
1. **Navigator.push()**<br>
  Navigator.push() berfungsi untuk menambahkan halaman baru ke dalam stack dan memungkinkan kembali ke halaman sebelumnya.
  ```dart
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => const ProductEntryFormPage()),
  );
  ```
2. **Navigator.pushReplacement()**<br>
  Navigator.pushReplacement() berfungsi untuk mengganti halaman saat ini dengan halaman baru dan menghapus halaman sebelumnya dari stack.
  ```dart
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => MyHomePage(),
    ));
  ```
3. **Navigator.pop()**<br>
  Navigator.pop() berfungsi untuk menghapus halaman teratas dari stack dan kembali ke halaman sebelumnya.
  ```dart
  Navigator.pop(context);
  ```
<hr>
</details>

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
Dapat disimpulkan, variabel `const` harus diinisialisasi saat compile dan tidak dapat diubah nilainya, sedangkan variabel `final` dapat diinisialiasasi saat compile atau runtime dan hanya dapat diinisialisasi sekali (tidak dapat diubah lagi setelahnya). Penggunaan variabel `const` dan `final` bergantung dengan nilai dari variabel tersebut.
<hr>

### Jelaskan bagaimana cara kamu mengimplementasikan checklist-checklist di atas.

**Membuat sebuah program Flutter baru dengan tema E-Commerce**
- Masuk ke direktori lokal dan generate proyek baru pada terminal
```
flutter create every_mart_mobile
cd every_mart_mobile
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
