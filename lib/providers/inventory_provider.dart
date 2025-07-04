import 'package:books/models/inventory_model.dart';
import 'package:flutter/material.dart';

import '../services/inventory_service.dart';

class InventoryProvider with ChangeNotifier {
  List<Inventory> _inventories = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Inventory> get inventories => _inventories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // final List<StatDaily> _stats = [];
  // List<StatDaily> get stats => _stats;

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
      final newInventory = await InventoryService.createInventory(
        name: name,
        quantity: quantity,
        price: price,
        year: year,
        categoryId: categoryId,
      );
      _inventories.add(newInventory);
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
      final index = _inventories.indexWhere(
        (Inventory inventory) => inventory.id == id,
      );
      if (index != -1) {
        _inventories[index] = updatedBook;
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteInventory(int id) async {
    try {
      await InventoryService.deleteInventory(id);
      _inventories.removeWhere((inventory) => inventory.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<Inventory?> getInventoryById(int id) async {
    try {
      return await InventoryService.getInventoryById(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  // Future<void> fetchInventoryStats() async {
  //   try {
  //     _stats = await CategoryService.getStats();
  //     notifyListeners();
  //   } catch (e) {
  //     print('Error fetching category stats: $e');
  //   }
  // }
}
