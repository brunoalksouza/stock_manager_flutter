import 'package:flutter/material.dart';

class HomePageController {
  // Notificador para o índice selecionado
  final ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);

  // Lista de páginas
  final List<Widget> pages = [
    const Center(child: Text('Página 1', style: TextStyle(fontSize: 20))),
    const Center(child: Text('Página 2', style: TextStyle(fontSize: 20))),
    const Center(child: Text('Página 3', style: TextStyle(fontSize: 20))),
  ];

  // Getter para obter o índice selecionado
  int get selectedIndex => selectedIndexNotifier.value;

  // Setter para atualizar o índice selecionado
  void setSelectedIndex(int index) {
    selectedIndexNotifier.value = index;
  }

  // Dispose para liberar o notificador quando não for mais necessário
  void dispose() {
    selectedIndexNotifier.dispose();
  }
}
