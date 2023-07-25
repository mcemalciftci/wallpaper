import "package:get_it/get_it.dart";
import "package:wallpaper/firebase/auth_service.dart";

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AuthService>(AuthService());
}