import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:books/models/category_model.dart';
import 'package:books/providers/category_provider.dart';

class CategoryForm extends StatefulWidget {
  final Category? category;

  const CategoryForm({super.key, this.category, required bool addCategory});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category?.name ?? "");
    _descriptionController = TextEditingController(
      text: widget.category?.description ?? "",
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<CategoryProvider>(context, listen: false);

      if (widget.category == null) {
        await provider.addCategory(
          name: _nameController.text,
          description: _descriptionController.text,
        );
      } else {
        await provider.updateCategory(
          id: widget.category!.id,
          name: _nameController.text,
          description: _descriptionController.text,
        );
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category == null ? 'Tambah Kategori' : 'Edit Kategori',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Nama tidak boleh kosong'
                            : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Deskripsi tidak boleh kosong'
                            : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: const Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }
}
