import 'dart:convert';

class GoldResponse {
  final int? timestamp;
  final double? price;
  final String? currency;
  GoldResponse({this.timestamp, this.price, this.currency});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timestamp': timestamp,
      'price': price,
      'currency': currency,
    };
  }

  factory GoldResponse.fromMap(Map<String, dynamic> map) {
    return GoldResponse(
      timestamp: map['timestamp'],
      price: map['price'],
      currency: map['currency'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GoldResponse.fromJson(String source) =>
      GoldResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
