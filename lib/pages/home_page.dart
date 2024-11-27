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
              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.blue,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 16.0),
                  child: const Icon(Icons.edit, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16.0),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    // Arrastou da esquerda para a direita (editar)
                    showDialog(
                      context: context,
                      builder: (context) => ProductDialog(
                        dialogTitle: 'Editar Produto',
                        product: product,
                        onSubmit: (name, value, quantity) {
                          final updatedProduct = {
                            'name': name,
                            'value': value,
                            'quantity': quantity,
                          };
                          _controller.updateProduct(index, updatedProduct);
                        },
                      ),
                    );
                    return false; // Não descarta o item
                  } else if (direction == DismissDirection.endToStart) {
                    // Arrastou da direita para a esquerda (excluir)
                    bool confirmDeletion = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirmar exclusão'),
                        content: Text(
                            'Você tem certeza que deseja excluir o produto "${product['name']}"?'),
                        actions: [
                          TextButton(
                            child: const Text('Cancelar'),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          TextButton(
                            child: const Text('Excluir'),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                        ],
                      ),
                    );
                    return confirmDeletion;
                  }
                  return false;
                },
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    // Remove o item da lista
                    _controller.removeProduct(index);
                    // Exibe uma snackbar informando que o item foi removido
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product['name']} foi excluído'),
                      ),
                    );
                  }
                },
                child: ProductTile(
                  product: product,
                  onDelete: () => _controller.removeProduct(index),
                  onEdit: (updatedProduct) {
                    _controller.updateProduct(index, updatedProduct);
                  },
                ),
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
