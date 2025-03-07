import 'package:get_it/get_it.dart';
import '../../data/repositories/payment_repository.dart';
import '../../domain/usecases/process_payment.dart';
import '../../presentation/blocs/payment/payment_bloc.dart';

final sl = GetIt.instance;

void init() {

  sl.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImpl());


  sl.registerLazySingleton(() => ProcessPayment(sl()));

 
  sl.registerFactory(() => PaymentBloc(sl()));
}
