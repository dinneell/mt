import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/process_payment.dart';

part 'payment_state.dart';
part 'payment_event.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final ProcessPayment processPayment;

  PaymentBloc(this.processPayment) : super(PaymentInitial()) {
    on<MakePayment>((event, emit) async {
      emit(PaymentLoading());
      final success = await processPayment(event.amount);
      if (success) {
        emit(PaymentSuccess());
      } else {
        emit(PaymentFailure());
      }
    });
  }
}
