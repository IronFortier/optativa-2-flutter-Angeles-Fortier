import 'package:examen_unidad_2/modules/products/domain/dto/product_dto.dart';
import 'package:examen_unidad_2/modules/lastseen/domain/dto/seen_dto.dart';
import 'package:examen_unidad_2/modules/products/domain/repository/product_reppsitory.dart';
import 'package:localstorage/localstorage.dart';

class LastseenUsecase {
  final ProductRepository products;
  final LocalStorage storage = LocalStorage('localstorage_app');
  LastseenUsecase(this.products);

  Future<List<ProductDto>> GetRepository(String category) async {
    return await products.getProducts(category);
  }

  Future<List<ProductDto>> getSeen() async {
    List<dynamic>? seens = await storage.getItem('seen'); // Recupera los datos

    if (seens == null || seens.isEmpty) {
      print('No hay productos vistos guardados.');
      return [];
    }

    print('Datos recuperados de LocalStorage: $seens');

    try {
      return seens
          .where((seen) => seen != null) // Filtra elementos nulos
          .map((seen) =>
              ProductDto.fromJson(seen as Map<String, dynamic>)) // Mapea los datos
          .toList();
    } catch (e) {
      print('Error al mapear los productos vistos: $e');
      return [];
    }
  }
Future<void> saveSeen(ProductDto product) async {
  // Recupera los productos vistos o inicializa una lista vacía si no hay datos
  List<dynamic> seens = (await storage.getItem('seen')) ?? [];

  // Verifica si el producto ya fue visto
  bool alreadySeen = seens.any((seen) {
    try {
      final seenProduct = SeenDto.fromJson(seen as Map<String, dynamic>);
      return seenProduct.product.id == product.id;
    } catch (e) {
      print('Error al verificar duplicados: $e');
      return false;
    }
  });

  if (!alreadySeen) {
    // Guarda el producto en el formato esperado
    seens.add({'product': product.toJson()});
    await storage.setItem('seen', seens);
    print('Producto guardado correctamente: ${product.title}');
  } else {
    print('El producto ya estaba en la lista de vistos.');
  }
}

}