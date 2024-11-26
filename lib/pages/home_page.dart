import 'package:flutter/material.dart';
import 'package:stock_manager_flutter/utils/globals/colors.dart';
import 'home_page_controller.dart'; // Importa o controlador

class HomePage extends StatelessWidget {
  final HomePageController _controller =
      HomePageController(); // Instância do controlador

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, // Cor de fundo
      appBar: AppBar(
        backgroundColor: backgroundColor, // Cor do AppBar
        title: const Text('Estoque Geral'),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable:
            _controller.selectedIndexNotifier, // Observa mudanças no índice
        builder: (context, selectedIndex, _) {
          return _controller
              .pages[selectedIndex]; // Renderiza a página correspondente
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _controller.setSelectedIndex(2), // Define o índice para a página 3
        shape: const CircleBorder(),
        backgroundColor:
            const Color.fromARGB(255, 68, 207, 124), // Cor pastel para o botão
        elevation: 6.0, // Sombra para destacar o botão
        child: const Icon(
          Icons.add,
          size: 30, // Tamanho do ícone
        ), // Ícone do botão central
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: textColor, // Cor da barra de navegação
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Botão da esquerda
            IconButton(
              icon: const Icon(Icons.home),
              color: _controller.selectedIndex == 0
                  ? Colors.white
                  : const Color.fromARGB(190, 241, 237, 231),
              onPressed: () => _controller.setSelectedIndex(0),
            ),
            // Espaço para o botão central
            const SizedBox(width: 48),
            // Botão da direita
            IconButton(
              icon: const Icon(Icons.school),
              color: _controller.selectedIndex == 1
                  ? Colors.white
                  : const Color.fromARGB(190, 241, 237, 231),
              onPressed: () => _controller.setSelectedIndex(1),
            ),
          ],
        ),
      ),
    );
  }
}
