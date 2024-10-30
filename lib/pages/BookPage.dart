import 'dart:async';
import 'package:flutter/material.dart';
import 'package:library_perpus/controller/bookController.dart';
import 'package:library_perpus/models/book.dart';
import 'package:library_perpus/pages/BookDetail.dart';
import 'package:library_perpus/widget/add.dart';
import 'package:library_perpus/widget/update.dart';

class Bookpage extends StatefulWidget {
  const Bookpage({super.key});

  @override
  State<Bookpage> createState() => _BookpageState();
}

class _BookpageState extends State<Bookpage> {
  Bookcontroller bookController = Bookcontroller();
  List<BookModel>? books;

  List<List<Color>> gradients = [
    [Colors.red, Colors.orange],
    [Colors.blue, Colors.purple],
    [Colors.green, Colors.teal],
    [Colors.yellow, Colors.redAccent],
  ];

  int currentGradientIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void getBooks() {
    setState(() {
      books = bookController.book;
    });
  }


  void _addBook(BookModel newBook) {
    setState(() {
      books!.add(newBook);
    });
  }

  void _showAddBookDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddBookDialog(onAdd: _addBook, books: books);
      },
    );
  }

  void _showUpdateBookDialog(BookModel book, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return UpdateBookDialog(
          book: book,
          onUpdate: (updatedBook) {
            setState(() {
              books![index] = updatedBook;
            });
          },
        );
      },
    );
  }

  void _deleteBook(int index) {
    setState(() {
      books!.removeAt(index);
    });
  }

  void _navigateToBookDetail(BookModel book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Text(
            "BOOKS",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.blue),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.blue,
        toolbarHeight: 60,
      ),
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      body: Column(
        children: [
          const Opacity(
            opacity: 0,
            child: SizedBox(height: 8.0),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: books!.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 580,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  margin:
                      const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      children: [
                        Image.network(
                          books![index].imagePath,
                          height: 1000,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 80,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black54],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 16,
                          right: 16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  books![index].title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _navigateToBookDetail(books![index]);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  "Learn More",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    _showUpdateBookDialog(books![index], index);
                                  },
                                  icon: const Icon(Icons.edit),
                                  color: Colors.green,
                                  tooltip: 'Update Book',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    _deleteBook(index);
                                  },
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  tooltip: 'Delete Book',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedContainer(
        duration: const Duration(seconds: 1),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradients[currentGradientIndex],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: _showAddBookDialog,
          backgroundColor: Colors.blue,
          elevation: 0,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
