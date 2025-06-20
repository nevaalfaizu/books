import 'package:books/models/books_model.dart';
import 'package:books/models/category_model.dart';
import 'package:books/services/book_service.dart';

import 'package:books/services/category_service.dart';
import 'package:flutter/material.dart';

class BookForm extends StatefulWidget {
  final bool addBook;
  final Book? book;

  const BookForm({Key? key, required this.addBook, this.book})
    : super(key: key);

  @override
  State<BookForm> createState() => _BookFormPageState();
}

class _BookFormPageState extends State<BookForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _yearController;

  List<Category> _categories = [];
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.book?.title ?? '');
    _authorController = TextEditingController(text: widget.book?.author ?? '');
    _yearController = TextEditingController(
      text: widget.book?.year.toString() ?? '',
    );

    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final categories = await CategoryService.getCategories();
    setState(() {
      _categories = categories;

      // Set selected category for edit form
      if (widget.book != null) {
        _selectedCategory = _categories.firstWhere(
          (c) => c.id == widget.book!.category.id,
          orElse: () => _categories.first,
        );
      } else {
        _selectedCategory = _categories.isNotEmpty ? _categories.first : null;
      }
    });
  }

  Future<void> _submitForm() async {
    try {
      if (widget.book == null) {
        // Tambah buku
        await BookService.createBook(
          title: _titleController.text,
          author: _authorController.text,
          year: int.parse(_yearController.text),
          categoryId: _selectedCategory!.id,
        );
      } else {
        // Update buku
        await BookService.updateBook(
          id: widget.book!.id,
          title: _titleController.text,
          author: _authorController.text,
          year: int.parse(_yearController.text),
          categoryId: _selectedCategory!.id,
        );
      }

      // ⬅️ Kembali ke halaman sebelumnya dan beri tanda sukses
      Navigator.pop(context, true);
    } catch (e) {
      // Tampilkan error atau dialog jika perlu
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Gagal menyimpan data')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Tambah Buku' : 'Edit Buku'),
      ),
      body:
          _categories.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'Judul'),
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? 'Judul tidak boleh kosong'
                                    : null,
                      ),
                      TextFormField(
                        controller: _authorController,
                        decoration: const InputDecoration(labelText: 'Penulis'),
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? 'Penulis tidak boleh kosong'
                                    : null,
                      ),
                      TextFormField(
                        controller: _yearController,
                        decoration: const InputDecoration(labelText: 'Tahun'),
                        keyboardType: TextInputType.number,
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? 'Tahun tidak boleh kosong'
                                    : null,
                      ),
                      DropdownButtonFormField<Category>(
                        value: _selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Kategori',
                        ),
                        items:
                            _categories
                                .map(
                                  (cat) => DropdownMenuItem(
                                    value: cat,
                                    child: Text(cat.name),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(widget.book == null ? 'Tambah' : 'Simpan'),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
