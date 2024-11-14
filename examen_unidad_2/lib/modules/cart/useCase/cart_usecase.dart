import 'package:examen_unidad_2/modules/FinalPurchase/domain/dto/order_dto.dart';
import 'package:examen_unidad_2/modules/FinalPurchase/domain/repository/purchaseReposiotry.dart';
import 'package:examen_unidad_2/modules/cart/domain/dto/cart_dto.dart';
import 'package:examen_unidad_2/modules/cart/domain/repository/cart_repository.dart';

class CartUsecase {
  final CartRepository repository;
  final PurchaseRepository orderRepository = PurchaseRepository();

  CartUsecase(this.repository);

  Future<List<CartDto>> getCart() async {
    return await repository.getCart();
  }

  Future<void> removeProduct(int productId) async {
    List<CartDto> cart = await repository.getCart();
    cart.removeWhere((item) => item.product.id == productId);
    await repository.saveCart(cart);
  }

  Future<void> guardarCarrito() async {
    List<CartDto> cart = await repository.getCart();

    if (cart.isEmpty) {
      throw Exception("El carrito está vacío");
    }

    // Calcular el total y la cantidad total de productos
    double total = cart.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
    int totalProductos = cart.fold(0, (sum, item) => sum + item.quantity);

    // Crear una nueva orden
    OrderDto nuevaOrden = OrderDto(
      total: total,
      totalProducts: totalProductos,
      items: cart,
      purchaseDate: DateTime.now(),
    );

    // Guardar la orden en el historial de compras
    await orderRepository.saveOrder(nuevaOrden);

    // Vaciar el carrito después de guardar la compra
    await repository.saveCart([]);
  }
}
