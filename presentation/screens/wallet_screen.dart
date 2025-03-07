import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/payment/payment_bloc.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Кошелек")),
      body: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Оплата успешна!")),
            );
          } else if (state is PaymentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Ошибка оплаты!")),
            );
          }
        },
        builder: (context, state) {
          if (state is PaymentLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<PaymentBloc>().add(MakePayment(1000));
              },
              child: Text("Оплатить 10000₸"),
            ),
          );
        },
      ),
    );
  }
}


