import 'package:examen_unidad_2/Widgets/general/custom_button.dart';
import 'package:examen_unidad_2/modules/FinalPurchase/domain/dto/order_dto.dart';
import 'package:examen_unidad_2/modules/FinalPurchase/useCase/purchase_usecase.dart';
import 'package:examen_unidad_2/router/routers.dart';
import 'package:flutter/material.dart';

class PurchasesView extends StatelessWidget {
  final PurchaseUsecase purchaseUsecase = PurchaseUsecase();

  PurchasesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Compras Realizadas")),
      body: FutureBuilder<List<OrderDto>>(
        future: purchaseUsecase.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final orders = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return Card(
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          title: Text("Total de compra: \$${order.total.toStringAsFixed(2)}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Productos: ${order.items.length}"),
                              Text("Fecha: ${order.purchaseDate.toLocal()}"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomButton(
                    label: 'Volver a Categorías',
                    icon: Icons.category,
                    Action: () {
                      Navigator.pushNamed(context, Routers.categories);
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text("No hay compras realizadas"));
          }
        },
      ),
    );
  }
}
