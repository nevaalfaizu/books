import 'package:flutter/material.dart';

class BookForm extends StatefulWidget {
  const BookForm({super.key});

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _yearController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Judul'),
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Judul tidak boleh kosong' : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _authorController,
                  decoration: const InputDecoration(labelText: 'Penulis'),
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Penulis tidak boleh kosong' : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _yearController,
                  decoration: const InputDecoration(labelText: 'Tahun'),
                  keyboardType: TextInputType.number,
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Tahun tidak boleh kosong' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: Tambahkan aksi simpan
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Form valid. Simpan data...")),
                  );
                }
              },
              child: const Text("Simpan"),
            ),
          ),
        ],
      ),
    );
  }
}
