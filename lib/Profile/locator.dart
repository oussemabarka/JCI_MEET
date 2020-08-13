import 'package:jci_meet/Profile/auth_repo.dart';
import 'package:jci_meet/Profile/user_controller.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupServices() {
  locator.registerSingleton<AuthRepo>(AuthRepo());
  locator.registerSingleton<UserController>(UserController());
}
