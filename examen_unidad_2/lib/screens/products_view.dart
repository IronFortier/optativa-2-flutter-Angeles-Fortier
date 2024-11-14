import 'package:examen_unidad_2/Widgets/general/custom_appbar.dart';
import 'package:examen_unidad_2/modules/products/useCase/products_usecase.dart';
import 'package:flutter/material.dart';
import 'product_detail_view.dart';

class ProductsView extends StatelessWidget {
  final ProductsUsecase UCproducts;
  final String category;

  ProductsView({Key? key, required this.UCproducts, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppbar(title: "Productos $category"),
      body: FutureBuilder(
        future: UCproducts.GetRepository(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
          
            if (snapshot.error
                .toString()
                .contains("No se encontró el token de autenticación")) {
              // Si no está autenticado, redirigimos a la pantalla de login
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, '/login');
              });
              return const Center(child: Text("Redirigiendo al login"));
            }

            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            return GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailView(product: product),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 200,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 150, 
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(5)),
                              child: Image.network(
                                product.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.title,
                              textAlign: TextAlign
                                  .center, 
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Detalles',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return Center(child: Text("No hay productos disponibles"));
        },
      ),
    );
  }
}
