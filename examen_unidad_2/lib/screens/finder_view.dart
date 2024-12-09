import 'package:examen_unidad_2/modules/products/domain/dto/product_dto.dart';
import 'package:examen_unidad_2/modules/search/usecase/search_usecase.dart';
import 'package:examen_unidad_2/router/routers.dart';
import 'package:flutter/material.dart';

class FinderView extends StatefulWidget {
  final SearchUseCase searchUseCase;

  const FinderView({Key? key, required this.searchUseCase}) : super(key: key);

  @override
  State<FinderView> createState() => _FinderViewState();
}

class _FinderViewState extends State<FinderView> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductDto> _products = [];
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _searchProducts(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final products = await widget.searchUseCase.searchProducts(query);
      setState(() {
        _products = products;
      });
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
                      FocusScope.of(context).unfocus(); // Cierra el teclado
                      _searchProducts(query);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_errorMessage.isNotEmpty)
              Center(
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              )
            else if (_products.isEmpty)
              const Center(child: Text('No se encontraron productos.'))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return Card(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        leading: Image.network(
                          product.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                        title: Text(product.title),
                        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routers.productDetail,
                            arguments: {
                              'product': product,
                            },
                          );
                          widget.searchUseCase.saveSeen(product);
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
