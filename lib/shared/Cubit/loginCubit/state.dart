abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates
{
  final String uid;
  LoginSuccessState(this.uid);
}

class LoginErrorState extends LoginStates{

  final String error;

  LoginErrorState(this.error);
}

class ShowPasswordState extends LoginStates{}

// get user Reload states
class LoginReloadLoadingState extends LoginStates {}
class LoginReloadSuccessState extends LoginStates {}
class LoginReloadErrorState extends LoginStates {
  final String? errorString ;
  LoginReloadErrorState(this.errorString);
}

class UserExistSuccessState extends LoginStates{
  final String uId;
  UserExistSuccessState(this.uId);
  }
///CreateGoogleUSer State
class CreateGoogleUserLoadingState extends LoginStates{}
class CreateGoogleUserSuccessState extends LoginStates{
  final  String uId;
  CreateGoogleUserSuccessState(this.uId);
}
class CreateGoogleUserErrorState extends LoginStates{}
///End of CreateUser State
///LoginGoogleUSer State
class LoginGoogleUserLoadingState extends LoginStates{}
class LoginGoogleUserSuccessState extends LoginStates{
  final  String uId;
  LoginGoogleUserSuccessState(this.uId);
}
class LoginGoogleUserErrorState extends LoginStates{}
///End of LoginUser State