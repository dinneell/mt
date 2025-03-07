import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  static Future<bool> processPayment(int amount, String cardCryptogram) async {
    final response = await http.post(
      Uri.parse('https://api.cloudpayments.ru/payments/cards/charge'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic YOUR_CLOUDPAYMENTS_AUTH_TOKEN'
      },
      body: jsonEncode({
        "Amount": amount,
        "Currency": "KZT",
        "IpAddress": "192.168.1.1",
        "Name": "Courier",
        "CardCryptogramPacket": cardCryptogram,
      }),
    );

    if (response.statusCode == 200) {
      print("Оплата успешна");
      return true;
    } else {
      print("Ошибка оплаты: ${response.body}");
      return false;
    }
  }
}
