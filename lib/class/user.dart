import 'package:project_uts/data/userData.dart';

class User {
  String nama;
  String nrp;
  String program;
  String biografi;
  String picture;
  String email;
  String password;

  User(
    this.nama,
    this.nrp,
    this.program,
    this.biografi,
    this.picture,
    this.email,
    this.password,
  );

  bool login(String inputEmail, String inputPassword) {
    return email == inputEmail && password == inputPassword;
  }

  static User empty() {
    return User('', '', '', '', '', '', '');
  }

  static User getUserDataByEmail(String email) {
    List<User> userData = getUserData().cast<User>();
    for (var user in userData) {
      if (user.email == email) {
        return user;
      }
    }
    return User.empty();
  }

  static bool saveChanges(User updatedUser) {
    List<User> userData = getUserData().cast<User>();
    for (int i = 0; i < userData.length; i++) {
      if (userData[i].email == updatedUser.email) {
        userData[i] = updatedUser;
        return true;
      }
    }
    return false;
  }

  get getName => nama;
  get getNrp => nrp;
  get getProgram => program;
  get getBiografi => biografi;
  get getPicture => picture;
  get getEmail => email;
}
