// import 'package:books/models/stat_model.dart';
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  Category? _selectedCategory;
  bool _isLoading = false;
  String? _errorMessage;

  List<Category> get categories => _categories;
  Category? get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // final List<StatDaily> _stats = [];
  // List<StatDaily> get stats => _stats;

  // Fetch all categories
  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await CategoryService.getCategories();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Get category by ID
  Future<void> getCategoryById(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedCategory = await CategoryService.getCategoryById(id);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Add new category
  Future<void> addCategory({
    required String name,
    required String description,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final newCategory = await CategoryService.createCategory(
        name: name,
        description: description,
      );
      _categories.add(newCategory);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Update existing category
  Future<void> updateCategory({
    required int id,
    required String name,
    required String description,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final updated = await CategoryService.updateCategory(
        id: id,
        name: name,
        description: description,
      );
      final index = _categories.indexWhere((cat) => cat.id == id);
      if (index != -1) {
        _categories[index] = updated;
      }
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Delete category
  Future<void> deleteCategory(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await CategoryService.deleteCategory(id);
      _categories.removeWhere((cat) => cat.id == id);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Future<void> fetchCategoryStats() async {
  //   try {
  //     _stats = await CategoryService.getStats();
  //     notifyListeners();
  //   } catch (e) {
  //     print('Error fetching category stats: $e');
  //   }
  // }
}
