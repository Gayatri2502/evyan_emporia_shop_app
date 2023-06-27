
import '../providers/cart_provider.dart';

class Order {
  String id;
  List<Cart> allItems;
  DateTime orderedAt;

  Order({
    required this.id,
    required this.allItems,
    required this.orderedAt,
  });

//from Json
  factory Order.fromJson(Map<String, dynamic> json) =>
      Order(
        id: json["id"],
        allItems: List<Cart>.from(
            json["allItems"].map((x) => Cart.fromJson(x))),
        orderedAt: DateTime.parse(json["orderedAt"]),
      );

  //to Json
  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "allItems": List<dynamic>.from(allItems.map((x) => x.toJson())),
        "orderedAt": orderedAt.toIso8601String(),
      };
}