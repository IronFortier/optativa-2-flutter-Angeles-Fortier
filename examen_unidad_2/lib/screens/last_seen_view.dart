import 'package:examen_unidad_2/modules/lastseen/domain/dto/seen_dto.dart';
import 'package:examen_unidad_2/modules/lastseen/usecase/lastseen_usecase.dart';
import 'package:examen_unidad_2/modules/products/domain/dto/product_dto.dart';
import 'package:examen_unidad_2/router/routers.dart';
import 'package:flutter/material.dart';

class LastSeenView extends StatelessWidget {
  final LastseenUsecase UClastseen;

  LastSeenView({Key? key, required this.UClastseen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Last Seen Products'),
      ),
      body: FutureBuilder<List<ProductDto>>(
        future: UClastseen.getSeen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los productos vistos.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No has visto productos aún.'));
          }

          final seenProducts = snapshot.data!;

          return ListView.builder(
            itemCount: seenProducts.length,
            itemBuilder: (context, index) {
              final product = seenProducts[index]; // Acceso al ProductDto
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: Image.network(
                    product.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.title),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routers
                          .productDetail, // Asegúrate de usar `Routers.productDetail`
                      arguments: {
                        'product':
                            product, // Incluye el objeto como parte del mapa
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
