import 'package:examen_unidad_2/Widgets/general/custom_appbar.dart';
import 'package:examen_unidad_2/modules/cart/domain/dto/cart_dto.dart';
import 'package:examen_unidad_2/modules/cart/useCase/cart_usecase.dart';
import 'package:flutter/material.dart';

class CartView extends StatefulWidget {
  final CartUsecase cartUsecase;

  CartView({Key? key, required this.cartUsecase}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late Future<List<CartDto>> _cartItemsFuture;

  @override
  void initState() {
    super.initState();
    _loadCart();  // Cargar el carrito cuando se inicia el estado
  }

  // Método para cargar el carrito
  void _loadCart() {
    _cartItemsFuture = widget.cartUsecase.getCart();
  }

  // Método para calcular el total
  double _calculateTotal(List<CartDto> cartItems) {
    return cartItems.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Carrito"),
      body: FutureBuilder<List<CartDto>>(
        future: _cartItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            final List<CartDto> cartItems = snapshot.data!;
            final total = _calculateTotal(cartItems);

            return Column(
              children: [
                // Mostrar el total en la AppBar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total: \$${total.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: Image.network(
                            item.product.imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.product.title),
                          subtitle: Text("Cantidad: ${item.quantity}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove_red_eye, color: Colors.blue),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/productDetail',
                                    arguments: {'product': item.product},
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  await widget.cartUsecase.removeProduct(item.product.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Producto eliminado del carrito")),
                                  );
                                  // Refrescar la vista
                                  _loadCart(); // Volver a cargar los datos
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return Center(child: Text("El carrito está vacío"));
        },
      ),
    );
  }
}
