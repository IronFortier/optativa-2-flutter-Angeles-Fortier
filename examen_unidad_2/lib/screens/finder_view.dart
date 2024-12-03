import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FinderView extends StatefulWidget {
  const FinderView({Key? key}) : super(key: key);

  @override
  State<FinderView> createState() => _FinderViewState();
}

class _FinderViewState extends State<FinderView> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _products = [];
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _searchProducts(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await http
          .get(Uri.parse('https://dummyjson.com/products/search?q=$query'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _products = data['products'];
        });
      } else {
        setState(() {
          _errorMessage = 'Error: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Productos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar producto',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final query = _searchController.text.trim();
                    if (query.isNotEmpty) {
                      _searchProducts(query);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator()),
            if (_errorMessage.isNotEmpty)
              Center(
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (!_isLoading && _errorMessage.isEmpty && _products.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Image.network(
                          product['thumbnail'] ?? '',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                        title: Text(product['title'] ?? 'Sin título'),
                        subtitle: Text(
                          product['description'] ?? 'Sin descripción',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text('\$${product['price']}'),
                        onTap: () {
                          // Aquí puedes navegar a la vista de detalles si es necesario
                        },
                      ),
                    );
                  },
                ),
              ),
            if (!_isLoading && _products.isEmpty && _errorMessage.isEmpty)
              const Center(child: Text('No se encontraron productos')),
          ],
        ),
      ),
    );
  }
}
