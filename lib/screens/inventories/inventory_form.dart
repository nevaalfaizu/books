import 'package:books/models/inventory_model.dart';
import 'package:books/models/category_model.dart';
import 'package:books/services/inventory_service.dart';
import 'package:books/services/category_service.dart';
import 'package:flutter/material.dart';

class InventoryForm extends StatefulWidget {
  final bool addInventory;
  final Inventory? inventory;

  const InventoryForm({Key? key, required this.addInventory, this.inventory})
    : super(key: key);

  @override
  State<InventoryForm> createState() => _InventoryFormPageState();
}

class _InventoryFormPageState extends State<InventoryForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _priceController;
  late TextEditingController _yearController;

  List<Category> _categories = [];
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.inventory?.name ?? '');
    _quantityController = TextEditingController(
      text: widget.inventory?.quantity.toString() ?? '',
    );
    _priceController = TextEditingController(
      text: widget.inventory?.price.toString() ?? '',
    );

    _yearController = TextEditingController(
      text: widget.inventory?.year.toString() ?? '',
    );

    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final categories = await CategoryService.getCategories();
    setState(() {
      _categories = categories;

      // Set selected category for edit form
      if (widget.inventory != null) {
        _selectedCategory = _categories.firstWhere(
          (c) => c.id == widget.inventory!.category.id,
          orElse: () => _categories.first,
        );
      } else {
        _selectedCategory = _categories.isNotEmpty ? _categories.first : null;
      }
    });
  }

  Future<void> _submitForm() async {
    try {
      if (widget.inventory == null) {
        // Tambah buku
        await InventoryService.createInventory(
          name: _nameController.text,
          quantity: int.parse(_yearController.text),
          price: int.parse(_quantityController.text),
          year: int.parse(_priceController.text),
          categoryId: _selectedCategory!.id,
        );
      } else {
        // Update buku
        await InventoryService.updateInventory(
          id: widget.inventory!.id,
          name: _nameController.text,
          quantity: int.parse(_quantityController.text),
          price: int.parse(_priceController.text),
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
        title: Text(
          widget.inventory == null ? 'Tambah Inventory' : 'Edit Inventory',
        ),
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
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Nama'),
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? 'Nama tidak boleh kosong'
                                    : null,
                      ),
                      TextFormField(
                        controller: _quantityController,
                        decoration: const InputDecoration(
                          labelText: 'Kuantitas',
                        ),
                        keyboardType: TextInputType.number,
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? 'quantity tidak boleh kosong'
                                    : null,
                      ),
                      TextFormField(
                        controller: _priceController,
                        decoration: const InputDecoration(labelText: 'Harga'),
                        keyboardType: TextInputType.number,
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? 'Harga tidak boleh kosong'
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
                        child: Text(
                          widget.inventory == null ? 'Tambah' : 'Simpan',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
