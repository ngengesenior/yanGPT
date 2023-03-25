import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:yangpt/contollers/networking.dart';
import 'package:yangpt/service/api_provider.dart';
final getIt = GetIt.instance;
void registerSingletons() {
  getIt.registerLazySingleton<Client>(()=> Client());
  getIt.registerLazySingleton<ApiProvider>(() => ApiProvider(client: getIt()));
  getIt.registerLazySingleton<Networking>(() => Networking(apiProvider: getIt()));

}