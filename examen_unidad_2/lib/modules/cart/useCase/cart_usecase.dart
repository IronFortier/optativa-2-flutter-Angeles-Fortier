import 'package:examen_unidad_2/modules/cart/domain/dto/cart_dto.dart';
import 'package:examen_unidad_2/modules/cart/domain/repository/cart_repository.dart';

class CartUsecase {
  final CartRepository repository;

  CartUsecase(this.repository);

  Future<List<CartDto>> getCart() async {
    return await repository.getCart();
  }

   Future<void> removeProduct(int productId) async {
    List<CartDto> cart = await repository.getCart();
    cart.removeWhere((item) => item.product.id == productId);
    await repository.saveCart(cart);
  }
}
