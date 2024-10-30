import 'package:flutter/material.dart';
import 'package:library_perpus/models/book.dart';

class UpdateBookDialog extends StatefulWidget {
  final BookModel book;
  final Function(BookModel) onUpdate;

  const UpdateBookDialog({super.key, required this.book, required this.onUpdate});

  @override
  _UpdateBookDialogState createState() => _UpdateBookDialogState();
}

class _UpdateBookDialogState extends State<UpdateBookDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController authorController;
  late TextEditingController publisherController;
  late TextEditingController stockController;
  late TextEditingController imagePathController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.book.title);
    descriptionController = TextEditingController(text: widget.book.description);
    authorController = TextEditingController(text: widget.book.author);
    publisherController = TextEditingController(text: widget.book.publisher);
    stockController = TextEditingController(text: widget.book.stock.toString());
    imagePathController = TextEditingController(text: widget.book.imagePath);
  }

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 70),
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Update Book", style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 16),
                  _buildTextField(titleController, "Title"),
                  _buildTextField(descriptionController, "Description"),
                  _buildTextField(authorController, "Author"),
                  _buildTextField(publisherController, "Publisher"),
                  _buildTextField(stockController, "Stock", keyboardType: TextInputType.number),
                  _buildTextField(imagePathController, "Image URL"),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Update logic
                      widget.onUpdate(
                        BookModel(
                          id: widget.book.id,
                          title: titleController.text,
                          description: descriptionController.text,
                          author: authorController.text,
                          publisher: publisherController.text,
                          stock: int.parse(stockController.text),
                          imagePath: imagePathController.text,
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text("Update"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
