import 'package:examen_unidad_2/modules/login/domain/dto/product_dto.dart';
import 'package:examen_unidad_2/modules/login/domain/repository/product_rep.dart';
import 'package:examen_unidad_2/screens/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'product_detail_view.dart';

class ProductsView extends StatefulWidget {
  final String categorySlug;
  final ProductRepository productRepository;

  ProductsView({required this.categorySlug, required this.productRepository});

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late Future<List<ProductDto>> productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = widget.productRepository.getProductsByCategory(widget.categorySlug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Productos"),
      body: FutureBuilder<List<ProductDto>>(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available'));
          } else {
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
                        builder: (context) => ProductDetailView(product: product),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 200, // Altura fija de 200 para cada tarjeta
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 150, // Imagen ocupa 3/4 de la tarjeta
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
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
                              textAlign: TextAlign.center, // Centra el nombre del producto
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
        },
      ),
    );
  }
}
