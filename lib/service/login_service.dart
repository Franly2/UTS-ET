import 'package:project_uts/class/user.dart';
import 'package:project_uts/data/userData.dart';

bool loginService(String email, String password) {
  List<User> userData = getUserData();

  User? foundUser;
  for (var user in userData) {
    if (user.login(email, password)) {
      foundUser = user;
      break;
    }
  }

  if (foundUser == null) {
    return false;
  } else {
    return true;
  }
}
