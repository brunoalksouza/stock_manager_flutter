import 'package:flutter/material.dart';
import 'package:stock_manager_flutter/widgets/product_dialog.dart';

class ProductTile extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onDelete;
  final void Function(Map<String, dynamic> updatedProduct) onEdit;

  ProductTile({
    required this.product,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Abrir o diálogo de edição ao clicar no card
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
                  onEdit(updatedProduct);
                },
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                // Ícone à esquerda
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.green.withOpacity(0.1),
                  child: const Icon(
                    Icons.icecream,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(
                    width: 16), // Espaçamento entre o ícone e o texto
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nome do produto
                      Text(
                        product['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Valor do produto
                      Text(
                        'Valor: R\$${product['value'].toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Quantidade: ${product['quantity']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    int currentQuantity = product['quantity'];
                    if (currentQuantity > 0) {
                      int newQuantity = currentQuantity - 1;
                      Map<String, dynamic> updatedProduct = Map.from(product);
                      updatedProduct['quantity'] = newQuantity;
                      onEdit(updatedProduct);
                    }
                  },
                ),
                // Botão de aumentar quantidade
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    int currentQuantity = product['quantity'];
                    int newQuantity = currentQuantity + 1;
                    Map<String, dynamic> updatedProduct = Map.from(product);
                    updatedProduct['quantity'] = newQuantity;
                    onEdit(updatedProduct);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
