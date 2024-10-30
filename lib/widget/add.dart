import 'package:flutter/material.dart';
import 'package:library_perpus/models/book.dart';

class AddBookDialog extends StatefulWidget {
  final List<BookModel>? books;
  final Function(BookModel) onAdd;

  const AddBookDialog({super.key, required this.onAdd, required this.books});

  @override
  _AddBookDialogState createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController publisherController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController imagePathController = TextEditingController();

  String? imageUrlError;
  String? titleError;
  String? descriptionError;
  String? authorError;
  String? publisherError; 
  String? stockError;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    authorController.dispose();
    publisherController.dispose();
    stockController.dispose();
    imagePathController.dispose();
    super.dispose();
  }

  bool _isValidUrl(String url) {
    const urlPattern = r'^(http|https)://.*$';
    final regExp = RegExp(urlPattern);
    return regExp.hasMatch(url);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 70),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Add New Book", style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: titleController,
                    label: "Title",
                    errorText: titleError,
                    onChanged: (value) {
                      setState(() {
                        titleError = null;
                      });
                    },
                  ),
                  _buildTextField(
                    controller: descriptionController,
                    label: "Description",
                    errorText: descriptionError,
                    onChanged: (value) {
                      setState(() {
                        descriptionError = null;
                      });
                    },
                  ),
                  _buildTextField(
                    controller: authorController,
                    label: "Author",
                    errorText: authorError,
                    onChanged: (value) {
                      setState(() {
                        authorError = null;
                      });
                    },
                  ),
                  _buildTextField(
                    controller: publisherController,
                    label: "Publisher",
                    errorText: publisherError,
                    onChanged: (value) {
                      setState(() {
                        publisherError = null;
                      });
                    },
                  ),
                  _buildTextField(
                    controller: stockController,
                    label: "Stock",
                    keyboardType: TextInputType.number,
                    errorText: stockError,
                    onChanged: (value) {
                      setState(() {
                        stockError = null;
                      });
                    },
                  ),
                  _buildTextField(
                    controller: imagePathController,
                    label: "Image URL",
                    errorText: imageUrlError,
                    onChanged: (value) {
                      setState(() {
                        imageUrlError = null;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          titleError = titleController.text.isEmpty
                              ? 'Please enter a title.'
                              : null;
                          descriptionError = descriptionController.text.isEmpty
                              ? 'Please enter a description.'
                              : null;
                          authorError = authorController.text.isEmpty
                              ? 'Please enter an author.'
                              : null;
                          publisherError = publisherController.text.isEmpty
                              ? 'Please enter a publisher.'
                              : null;
                          stockError = stockController.text.isEmpty
                              ? 'Please enter stock.'
                              : null;
                          imageUrlError = imagePathController.text.isEmpty ||
                                  !_isValidUrl(imagePathController.text)
                              ? 'Please enter a valid image URL.'
                              : null;
                        });

                        if (titleError == null &&
                            descriptionError == null &&
                            authorError == null &&
                            publisherError == null &&
                            stockError == null &&
                            imageUrlError == null) {
                          widget.onAdd(
                            BookModel(
                              id: widget.books!.length + 1,
                              title: titleController.text,
                              description: descriptionController.text,
                              author: authorController.text,
                              publisher: publisherController.text,
                              stock: int.parse(stockController.text),
                              imagePath: imagePathController.text,
                            ),
                          );
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? errorText,
    TextInputType? keyboardType,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        labelStyle: const TextStyle(color: Colors.grey),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
