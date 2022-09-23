abstract class EmailVerificationStates {}

class EmailVerificationInitialState extends EmailVerificationStates {}


// user send verification mail states
class SendVerificationLoadingState extends EmailVerificationStates {}
class SendVerificationSuccessState extends EmailVerificationStates {}
class SendVerificationErrorState extends EmailVerificationStates {
  final String? errorString ;
  SendVerificationErrorState(this.errorString);
}

// get user Reload states
class ReloadLoadingState extends EmailVerificationStates {}
class ReloadSuccessState extends EmailVerificationStates {}
class ReloadErrorState extends EmailVerificationStates {
  final String? errorString ;
  ReloadErrorState(this.errorString);
}