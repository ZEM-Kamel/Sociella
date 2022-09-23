abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{}

class RegisterErrorState extends RegisterStates{

  final String error;

  RegisterErrorState(this.error);
}

class UserCreateSuccessState extends RegisterStates
{
 late final String uid;
  UserCreateSuccessState(this.uid);
}

class UserCreateErrorState extends RegisterStates{

  final String error;

  UserCreateErrorState(this.error);
}

class ChangePasswordRegisterState extends RegisterStates{}