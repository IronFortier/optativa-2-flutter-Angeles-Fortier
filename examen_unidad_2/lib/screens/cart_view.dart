import 'package:examen_unidad_2/Widgets/general/custom_appbar.dart';
import 'package:examen_unidad_2/Widgets/general/custom_button.dart';
import 'package:examen_unidad_2/modules/cart/domain/dto/cart_dto.dart';
import 'package:examen_unidad_2/modules/cart/useCase/cart_usecase.dart';
import 'package:flutter/material.dart';
import 'package:examen_unidad_2/router/routers.dart';

class CartView extends StatelessWidget {
  final CartUsecase cartUsecase;

  CartView({Key? key, required this.cartUsecase}) : super(key: key);

  double _calculateTotal(List<CartDto> cartItems) {
    return cartItems.fold(
        0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Carrito"),
      body: FutureBuilder(
        future: cartUsecase.getCart(),
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
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
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
                                icon: Icon(Icons.remove_red_eye,
                                    color: Colors.blue),
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
                                  await cartUsecase
                                      .removeProduct(item.product.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Producto eliminado del carrito")),
                                  );
                                  (context as Element).reassemble();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Divider(),
                CustomButton(
                  label: 'Comprar',
                  icon: Icons.shopping_bag,
                  Action: () async {
                    try {
                      await cartUsecase.guardarCarrito();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Compra realizada con éxito")),
                      );
                      // Navegar a la pantalla de "Compras realizadas"
                      Navigator.pushNamed(context, Routers.finalpurchase);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  },
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
