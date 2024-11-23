import 'dart:async';

import 'package:crud_perpustakaan/insert.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'insert.dart';
// import 'update.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  // Buat variabel untuk menyimpan daftar buku
  List<Map<String, dynamic>> books = []; //books = nama tabel

  @override
  void initState() {
    super.initState();
    fetchBooks(); // Panggil fungsi untuk fetch data buku / mengambil data
  }

  // Fungsi untuk mengambil data buku dari Supabase
  Future<void> fetchBooks() async {
    final response = await Supabase.instance.client
      .from('books')
      .select();

      setState(() {
        books = List<Map<String, dynamic>>.from(response);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book List'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchBooks, // Tombol untuk refresh, aksi untuk mengambil data 
          ),
        ],
      ),
      body: books.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Untuk menampilkan loading indikator
          : ListView.builder( // Untuk membuat tampilan list secara urut
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile( 
                  title: Text(book['title'] ?? 'No Title', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book['author'] ?? 'No Author', style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 14)),
                      Text(book['description'] ?? 'No Description', style: const TextStyle(fontSize: 12))
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tombol edit
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Arahkan ke halaman EditBookPage dengan mengirim
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //    builder: (context) => EditBookPage(book: book),
                          //    ),
                          //   ).then((_) {
                          //     fetchBooks(); // Refresh data setelah kembali dari
                          //   });
                        },
                      ),
                      // Tombol delete
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Konfirmasi sebelum menghapus buku
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete Book'),
                                content: const Text('Are you sure you want to delete this book?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      // await deleteBook(book['id']);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman insert buku
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBookPage()),
          ).then((_) {
            fetchBooks(); // Refresh data setelah kembali
          });
        },
        child: const Icon(Icons.add),
      )
    );
  }
}