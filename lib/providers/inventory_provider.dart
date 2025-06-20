import 'package:books/models/inventory_model.dart';
import 'package:flutter/material.dart';

import '../services/inventory_service.dart';

class InventoryProvider with ChangeNotifier {
  List<Inventory> _inventories = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Inventory> get Inventories => _inventories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchInventories() async {
    _isLoading = true;
    notifyListeners();
    try {
      _inventories = await InventoryService.getInventories();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addInventory({
    required String name,
    required int quantity,
    required int price,
    required int year,
    required int categoryId,
  }) async {
    try {
      final newBook = await InventoryService.createInventory(
        name: name,
        quantity: quantity,
        price: price,
        year: year,
        categoryId: categoryId,
      );
      _inventories.add(newBook);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateInventory({
    required int id,
    required String name,
    required int quantity,
    required int price,
    required int year,
    required int categoryId,
  }) async {
    try {
      final updatedBook = await InventoryService.updateInventory(
        id: id,
        name: name,
        quantity: quantity,
        price: price,
        year: year,
        categoryId: categoryId,
      );
      final index = _inventories.indexWhere((Inventory) => Inventory.id == id);
      if (index != -1) {
        _inventories[index] = updatedBook;
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteBook(int id) async {
    try {
      await InventoryService.deleteInventery(id);
      _inventories.removeWhere((Inventory) => Inventory.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<Inventory?> getBookById(int id) async {
    try {
      return await InventoryService.getInventoryById(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }
}
