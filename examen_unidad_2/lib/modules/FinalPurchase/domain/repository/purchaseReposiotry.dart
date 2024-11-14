import 'package:examen_unidad_2/modules/FinalPurchase/domain/dto/order_dto.dart';
import 'package:localstorage/localstorage.dart';

class PurchaseRepository {
  final LocalStorage storage = LocalStorage('orders_storage');

  // Método para guardar una nueva compra
  Future<void> saveOrder(OrderDto order) async {
    List<dynamic> orders = await storage.getItem('orders') ?? [];
    
    orders.add(order.toJson());

    await storage.setItem('orders', orders);
  }

  Future<List<OrderDto>> getOrders() async {
    List<dynamic> orders = await storage.getItem('orders') ?? [];
    
    return orders.map((order) => OrderDto.fromJson(order)).toList();
  }
}
