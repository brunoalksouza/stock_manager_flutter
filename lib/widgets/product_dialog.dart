import 'package:flutter/material.dart';

class ProductDialog extends StatelessWidget {
  final void Function(String name, double value, int quantity) onSubmit;
  final String dialogTitle;
  final Map<String, dynamic>? product;

  ProductDialog({
    required this.onSubmit,
    required this.dialogTitle,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: product?['name'] ?? '');
    final TextEditingController valueController =
        TextEditingController(text: product?['value']?.toString() ?? '');
    final TextEditingController quantityController =
        TextEditingController(text: product?['quantity']?.toString() ?? '');

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            // Adicionado para evitar overflow em telas menores
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título do Diálogo
                Text(
                  dialogTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                // Campo Nome
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'O nome é obrigatório.';
                    }
                    return null;
                  },
                  autofocus: true,
                ),
                const SizedBox(height: 12),
                // Campo Valor
                TextFormField(
                  controller: valueController,
                  decoration: InputDecoration(
                    labelText: 'Valor',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O valor é obrigatório.';
                    }
                    if (double.tryParse(value.replaceAll(',', '.')) == null) {
                      return 'Digite um valor numérico válido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                // Campo Quantidade
                TextFormField(
                  controller: quantityController,
                  decoration: InputDecoration(
                    labelText: 'Quantidade',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A quantidade é obrigatória.';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Digite um número inteiro válido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Botões de ação
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final name = nameController.text;
                          final value = double.parse(
                              valueController.text.replaceAll(',', '.'));
                          final quantity = int.parse(quantityController.text);

                          onSubmit(name, value, quantity);
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Cor do botão
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Salvar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
