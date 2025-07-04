import 'dart:typed_data';
import 'package:books/models/books_model.dart';
import 'package:books/models/category_model.dart';
import 'package:books/services/book_service.dart';
import 'package:books/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BookForm extends StatefulWidget {
  final bool addBook;
  final Book? book;

  const BookForm({super.key, required this.addBook, this.book});

  @override
  State<BookForm> createState() => _BookFormPageState();
}

class _BookFormPageState extends State<BookForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _yearController;
  late TextEditingController _descriptionController;

  List<Category> _categories = [];
  Category? _selectedCategory;

  XFile? _selectedImage;
  Uint8List? _selectedImageBytes; // Gambar lokal
  String? _coverImageUrl; // Untuk edit buku (URL dari server)
  Future<String> uploadImageToServer(XFile image) async {
    // 🚀 Implementasikan logika upload ke server di sini
    // Misalnya, gunakan http package untuk mengirim file ke server
    // Kembalikan URL gambar yang diupload
    return image.path; // Simulasi: kembalikan path lokal
  }

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.book?.title ?? '');
    _authorController = TextEditingController(text: widget.book?.author ?? '');
    _yearController = TextEditingController(
      text: widget.book?.year.toString() ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.book?.description ?? '',
    );

    _coverImageUrl = widget.book?.coverImageUrl;

    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final categories = await CategoryService.getCategories();
    setState(() {
      _categories = categories;

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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      setState(() {
        _selectedImage = pickedFile;
        _selectedImageBytes = bytes;
        _coverImageUrl = null; // Hapus URL lama kalau ada
      });
    }
  }

  Future<void> _submitForm() async {
    try {
      if (!_formKey.currentState!.validate()) return;

      String coverUrl = _coverImageUrl ?? '';
      if (_selectedImage != null) {
        // 🚀 Di sini kamu seharusnya upload file ke server dan dapat URL
        // Simulasi: kita gunakan path lokal (sebaiknya diganti upload ke server)
        coverUrl = _selectedImage!.path;
      }
      String uploadedUrl = await uploadImageToServer(_selectedImage!);
      if (uploadedUrl.isNotEmpty) {
        coverUrl = uploadedUrl;
      }
      if (widget.book == null) {
        await BookService.createBook(
          title: _titleController.text,
          author: _authorController.text,
          year: int.parse(_yearController.text),
          description: _descriptionController.text,
          coverImageUrl: coverUrl,
          categoryId: _selectedCategory!.id,
        );
      } else {
        await BookService.updateBook(
          id: widget.book!.id,
          title: _titleController.text,
          author: _authorController.text,
          year: int.parse(_yearController.text),
          description: _descriptionController.text,
          coverImageUrl: coverUrl,
          categoryId: _selectedCategory!.id,
        );
      }

      Navigator.pop(context, true);
    } catch (e) {
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
                padding: const EdgeInsets.all(50),
                child: Card(
                  color: Colors.blue[50],
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          TextFormField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                              labelText: 'Judul',
                            ),
                            validator:
                                (value) =>
                                    value!.isEmpty
                                        ? 'Judul tidak boleh kosong'
                                        : null,
                          ),
                          TextFormField(
                            controller: _authorController,
                            decoration: const InputDecoration(
                              labelText: 'Penulis',
                            ),
                            validator:
                                (value) =>
                                    value!.isEmpty
                                        ? 'Penulis tidak boleh kosong'
                                        : null,
                          ),
                          TextFormField(
                            controller: _yearController,
                            decoration: const InputDecoration(
                              labelText: 'Tahun',
                            ),
                            keyboardType: TextInputType.number,
                            validator:
                                (value) =>
                                    value!.isEmpty
                                        ? 'Tahun tidak boleh kosong'
                                        : null,
                          ),
                          TextFormField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Deskripsi',
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            validator:
                                (value) =>
                                    value!.isEmpty
                                        ? 'Deskripsi tidak boleh kosong'
                                        : null,
                          ),

                          // Upload button + preview
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: _pickImage,
                                child: const Text('Upload Gambar Sampul'),
                              ),
                              if (_selectedImageBytes != null)
                                Image.memory(
                                  _selectedImageBytes!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              else if (_coverImageUrl != null)
                                Image.network(
                                  _coverImageUrl!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              else
                                const Text('Belum ada gambar'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _submitForm,
                            child: Text(
                              widget.book == null ? 'Tambah' : 'Simpan',
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
