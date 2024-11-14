import 'package:examen_unidad_2/modules/FinalPurchase/domain/dto/order_dto.dart';
import 'package:examen_unidad_2/modules/FinalPurchase/domain/repository/purchaseReposiotry.dart';
import 'package:examen_unidad_2/modules/cart/domain/dto/cart_dto.dart';

class PurchaseUsecase {
  final PurchaseRepository repository = PurchaseRepository();

  PurchaseUsecase();

  // Método para guardar una nueva compra
  Future<void> saveOrder(double total, List<CartDto> cartItems) async {
    final order = OrderDto(
      total: total,
      totalProducts: cartItems.length,
      items: cartItems,
      purchaseDate: DateTime.now(),
    );

    await repository.saveOrder(order);
  }

  // Método para obtener todas las compras realizadas
  Future<List<OrderDto>> getOrders() async {
    return await repository.getOrders();
  }
}
