import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sociella/model/user_model.dart';
import 'package:sociella/shared/Cubit/registerCubit/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

void userRegister({
  required String email,
  required String password,
  required String phone,
  required String name,
})async {
  debugPrint('Done');
  emit(RegisterLoadingState());
FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: email,
  password: password,
).then((value) 
{
  userCreate(
      email: email,
      phone: phone,
      name: name,
      uId: value.user!.uid
  );
}).catchError((error)
{
  emit(RegisterErrorState(error.toString()));
});
}

void userCreate({
  required String email,
  required String phone,
  required String name,
  required String uId,
})
 async{
  UserModel model = UserModel(
    email: email,
    phone: phone,
    name: name,
    uId: uId,
    image: 'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1663939893~exp=1663940493~hmac=dfa846a0cee7e48e13611f3ad7075e24cf7b1bdfb4ec916282f3d6db7621b40e',
    cover: 'https://img.freepik.com/free-photo/abstract-luxury-gradient-blue-background-smooth-dark-blue-with-black-vignette-studio-banner_1258-82801.jpg?w=1380&t=st=1663939978~exp=1663940578~hmac=db6c0fb90eabea6c77005505bfb96b9f85c01b364aa4c43f3b9dbced2684085c',
    bio: 'Write a bio...',
    isEmailVerified : false,
  );
  FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .set(model.toMap())
      .then((value) {
emit(UserCreateSuccessState(uId));
  }).catchError((error)
  {
    emit(UserCreateErrorState(error));
  });
}

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordRegisterState());
  }
}
