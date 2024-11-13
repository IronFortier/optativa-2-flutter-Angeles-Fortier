import 'package:examen_unidad_2/modules/cart/domain/dto/cart_dto.dart';
import 'package:localstorage/localstorage.dart';

class CartRepository {
  final LocalStorage storage = LocalStorage('localstorage_app');

  Future<List<CartDto>> getCart() async {
    final response = await storage.getItem('cart');
    if (response == null) {
      // Si no hay carrito almacenado, retorna una lista vacía
      return [];
    }
    return (response as List)
        .map((json) => CartDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveCart(List<CartDto> cart) async {
    // Guarda el carrito actualizado en Local Storage
    await storage.setItem('cart', cart.map((item) => item.toJson()).toList());
  }
}
