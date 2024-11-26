import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController {
  // Lista de produtos (armazenada como uma lista de mapas)
  final ValueNotifier<List<Map<String, dynamic>>> productsNotifier =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  // Carregar produtos salvos
  Future<void> loadProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedProducts = prefs.getString('products');
    if (savedProducts != null) {
      productsNotifier.value =
          List<Map<String, dynamic>>.from(json.decode(savedProducts));
    }
  }

  // Adicionar produto
  Future<void> addProduct(String name, double value, int quantity) async {
    Map<String, dynamic> newProduct = {
      'name': name,
      'value': value,
      'quantity': quantity,
    };
    productsNotifier.value = [...productsNotifier.value, newProduct];

    // Salvar no SharedPreferences
    await _saveProducts();
  }

  // Atualizar produto
  Future<void> updateProduct(
      int index, Map<String, dynamic> updatedProduct) async {
    productsNotifier.value = List.from(productsNotifier.value)
      ..[index] = updatedProduct;

    // Salvar no SharedPreferences
    await _saveProducts();
  }

  // Salvar produtos no SharedPreferences
  Future<void> _saveProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedProducts = json.encode(productsNotifier.value);
    await prefs.setString('products', encodedProducts);
  }

  // Remover produto
  Future<void> removeProduct(int index) async {
    productsNotifier.value = List.from(productsNotifier.value)..removeAt(index);
    await _saveProducts();
  }

  // Dispose (limpa o notificador quando não for mais usado)
  void dispose() {
    productsNotifier.dispose();
  }
}
