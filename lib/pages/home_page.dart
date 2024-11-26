import 'package:flutter/material.dart';
import 'package:stock_manager_flutter/utils/globals/colors.dart';
import 'package:stock_manager_flutter/widgets/product_dialog.dart';
import 'package:stock_manager_flutter/widgets/product_tile.dart';
import 'home_page_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController _controller = HomePageController();

  @override
  void initState() {
    super.initState();
    _controller.loadProducts(); // Carrega produtos salvos
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Estoque Geral'),
      ),
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: _controller.productsNotifier,
        builder: (context, products, _) {
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductTile(
                product: product,
                onDelete: () => _controller.removeProduct(index),
                onEdit: (updatedProduct) {
                  _controller.updateProduct(index, updatedProduct);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => ProductDialog(
            dialogTitle: 'Adicionar Produto',
            onSubmit: (name, value, quantity) {
              _controller.addProduct(name, value, quantity);
            },
          ),
        ),
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 68, 207, 124),
        elevation: 6.0,
        child: Icon(
          Icons.add,
          size: 30,
          color: textColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: textColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              color: Colors.white,
              onPressed: () {},
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: const Icon(Icons.school),
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
