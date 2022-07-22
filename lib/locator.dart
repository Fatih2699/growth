import 'package:get_it/get_it.dart';
import 'package:growth/view_models/call_list_view_model.dart';

import 'view_models/user_view_model.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => UserModel());
  locator.registerLazySingleton(() => CallModel());
}
