import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class PaymentRepository {
  Future<bool> processPayment(int amount);
}

class PaymentRepositoryImpl implements PaymentRepository {
  @override
  Future<bool> processPayment(int amount) async {
    final response = await http.post(
      Uri.parse('https://api.cloudpayments.ru/payments/cards/charge'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "Amount": amount,
        "Currency": "KZT",
        "IpAddress": "192.168.1.1",
        "Name": "Courier",
        "CardCryptogramPacket": "test_cryptogram"
      }),
    );

    return response.statusCode == 200;
  }
}
