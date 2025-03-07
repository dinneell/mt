import '../repositories/payment_repository.dart';

class ProcessPayment {
  final PaymentRepository repository;

  ProcessPayment(this.repository);

  Future<bool> call(int amount) {
    return repository.processPayment(amount);
  }
}
