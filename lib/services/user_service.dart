import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';

String? _year;
String? _username;
String? _userCourse;
bool _isAdmin = false;

getIsAdmin() {
  return _isAdmin;
} // end getIsAdmin()

getUserYear() {
  return _year;
} // end getUserYear()

getUserUsername() {
  return _username;
} // end getUserUsername()

getUserCourse() {
  return _userCourse;
} // end getUserCourse()

class UserService with ChangeNotifier {
  BackendlessUser? _currentUser;
  BackendlessUser? get currentUser => _currentUser;

  void setCurrentUserNull() {
    _currentUser = null;
  } // end setCurrentUserNull()

  bool _userExists = false;
  bool get userExists => _userExists;

  set userExists(bool value) {
    _userExists = value;
    notifyListeners();
  } // end userExists()

  bool _showUserProgress = false;
  bool get showUserProgress => _showUserProgress;

  String _userProgressText = '';
  String get userProgressText => _userProgressText;

  Future<String> resetPassword(String username) async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = 'Busy sending reset instructions...please wait...';
    notifyListeners();
    await Backendless.userService.restorePassword(username).onError(
      (error, stackTrace) {
        result = getHumanReadableError(error.toString());
      },
    );
    _showUserProgress = false;
    notifyListeners();
    return result;
  } // end resetPassword()

  Future<String> loginUser(String email, String password) async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = 'Busy logging you in...please wait...';
    notifyListeners();
    BackendlessUser? user =
        await Backendless.userService.login(email, password, true).onError(
      (error, stackTrace) {
        result = getHumanReadableError(error.toString());
      },
    );
    if (user != null) {
      _currentUser = user;
    } // end if
    _showUserProgress = false;
    notifyListeners();

    if (result == "OK") {
      if (_currentUser!.getProperty('studentNumber').toString().length == 6) {
        _isAdmin = true;
      } // end if
      else
        _isAdmin = false;
      _year = _currentUser!.getProperty('year');
      _userCourse = _currentUser!.getProperty('course');
      _username = _currentUser!.getProperty('name');
    } // end if

    return result;
  } // end loginUser()

  Future<String> logoutUser() async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = 'Busy signing you out...please wait...';
    notifyListeners();
    await Backendless.userService.logout().onError(
      (error, stackTrace) {
        result = error.toString();
      },
    );
    _showUserProgress = false;
    notifyListeners();
    return result;
  } // end logoutUser()

  Future<String> checkIfUserLoggedIn() async {
    String result = 'OK';

    bool? validLogin = await Backendless.userService.isValidLogin().onError(
      (error, stackTrace) {
        result = error.toString();
      },
    );

    if (validLogin != null && validLogin) {
      String? currentUserObjectId =
          await Backendless.userService.loggedInUser().onError(
        (error, stackTrace) {
          result = error.toString();
        },
      );
      if (currentUserObjectId != null) {
        Map<dynamic, dynamic>? mapOfCurrentUser = await Backendless.data
            .of("Users")
            .findById(currentUserObjectId)
            .onError(
          (error, stackTrace) {
            result = error.toString();
          },
        );
        if (mapOfCurrentUser != null) {
          _currentUser = BackendlessUser.fromJson(mapOfCurrentUser);
          notifyListeners();

          if (result == "OK") {
            if (_currentUser!.getProperty('studentNumber').toString().length ==
                6) {
              _isAdmin = true;
            } // end if
            else
              _isAdmin = false;
            _year = _currentUser!.getProperty('year');
            _userCourse = _currentUser!.getProperty('course');
            _username = _currentUser!.getProperty('name');
          } // end if
        } // end if
        else {
          result = 'NOT OK';
        } // end else
      } // end if
      else {
        result = 'NOT OK';
      } // end else
    } // end if
    else {
      result = 'NOT OK';
    } // end else

    return result;
  } // end checkIfUserLoggedIn()

  void checkIfUserExists(String username) async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "email = '$username'";

    await Backendless.data.withClass<BackendlessUser>().find(queryBuilder).then(
      (value) {
        if (value == null || value.length == 0) {
          _userExists = false;
          notifyListeners();
        } // end if
        else {
          _userExists = true;
          notifyListeners();
        } // end else
      },
    ).onError(
      (error, stackTrace) {
        print(error.toString());
      },
    );
  } // end checkIfUserExists()

  Future<String> createUser(BackendlessUser user) async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = 'Creating a new user...please wait...';
    notifyListeners();
    try {
      await Backendless.userService.register(user);
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    _showUserProgress = false;
    notifyListeners();
    return result;
  } // end createUser()
} // end UserService class

String getHumanReadableError(String message) {
  if (message.contains('email address must be confirmed first')) {
    return 'Please check your inbox and confirm your email address and try to login again.';
  }
  if (message.contains('User already exists')) {
    return 'This user already exists in our database. Please create a new user.';
  }
  if (message.contains('Invalid login or password')) {
    return 'Please check your username or password. The combination do not match any entry in our database.';
  }
  if (message
      .contains('User account is locked out due to too many failed logins')) {
    return 'Your account is locked due to too many failed login attempts. Please wait 30 minutes and try again.';
  }
  if (message.contains('Unable to find a user with the specified identity')) {
    return 'Your email address does not exist in our database. Please check for spelling mistakes.';
  }
  if (message.contains(
      'Unable to resolve host "api.backendless.com": No address associated with hostname')) {
    return 'It seems as if you do not have an internet connection. Please connect and try again.';
  }
  return message;
} // end getHumanReadableError()
