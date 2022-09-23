import 'package:sociella/Pages/Login/Auth_phone/Auth_Phone.dart';
import 'package:sociella/Pages/password/forget_Password.dart';
import 'package:sociella/Pages/on-boarding/on-boarding%20screen.dart';
import 'package:sociella/shared/Cubit/loginCubit/cubit.dart';
import 'package:sociella/Pages/Register/register_screen.dart';
import 'package:sociella/shared/Cubit/loginCubit/state.dart';
import 'package:sociella/shared/components/components.dart';
import 'package:sociella/shared/network/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../layout/Home/home_layout.dart';
import '../../shared/Cubit/socialCubit/SocialCubit.dart';
import '../../shared/components/constants.dart';
import '../email_verification/email_verification_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(value: state.uid, key: 'uId').then((value) {
              uId = state.uid;
            });
          } else if (state is LoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            backgroundColor: cubit.isLight ? Colors.white : const Color(0xff4C5C68),
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness:
                    cubit.isLight ? Brightness.dark : Brightness.light,
                statusBarBrightness:
                    cubit.isLight ? Brightness.dark : Brightness.light,
              ),
              backgroundColor:
                  cubit.isLight ? Colors.white : const Color(0xff4C5C68),
              leading: IconButton(
                onPressed: () {
                  navigateTo(context, const OnBoard());
                },
                icon: Icon(
                  IconlyLight.arrowLeft2,
                  size: 30,
                  color: cubit.isLight ? Colors.black : Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        child: Text(
                          'Sign in Now',
                          style: GoogleFonts.amiri(
                            textStyle: TextStyle(
                              color: cubit.isLight ? Colors.black : Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      space(0, 10),
                      Text(
                        'Please enter your information',
                        style: GoogleFonts.amiri(
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'E-mail Address',
                        style: GoogleFonts.amiri(
                          textStyle: TextStyle(
                            color: cubit.isLight ? Colors.black : Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultTextFormField(
                        context: context,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your E-mail';
                          }
                          return null;
                        },
                        hint: 'E-mail',
                        prefix: Icons.alternate_email,
                      ),
                      space(0, 20),
                      Text(
                        'Password',
                        style: GoogleFonts.amiri(
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      space(0, 10),
                      defaultTextFormField(
                        context: context,
                        controller: passController,
                        keyboardType: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        hint: 'Password',
                        prefix: Icons.lock_outline_rounded,
                        suffix: LoginCubit.get(context).suffix,
                        isPassword: LoginCubit.get(context).isPassword,
                        suffixPressed: () {
                          LoginCubit.get(context).showPassword();
                        },
                      ),
                      space(0, 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              navigateTo(context, RestPasswordScreen());
                            },
                            child: Text(
                              'Forget Password ?',
                              style: GoogleFonts.amiri(
                                textStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      space(0, 30),
                      state is! LoginLoadingState
                          ? Center(
                              child: defaultMaterialButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context)
                                        .userLogin(
                                          email: emailController.text,
                                          password: passController.text,
                                        )
                                        .then((value) => {
                                              LoginCubit.get(context)
                                                  .loginReloadUser()
                                                  .then((value) {
                                                if (LoginCubit.get(context)
                                                    .isEmailVerified) {
                                                  SocialCubit.get(context)..getPosts()
                                                  ..getUserData()
                                                  ..getAllUsers();
                                                  navigateAndFinish(context,
                                                       const HomeLayout());
                                                } else {
                                                  navigateTo(context,
                                                      const EmailVerificationScreen());
                                                }
                                              })
                                            });
                                  }
                                },
                                text: 'Login',
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                      space(0, 20),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 95.0,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: GoogleFonts.amiri(
                                textStyle: TextStyle(
                                  color:
                                      cubit.isLight ? Colors.black : Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            cubit.isLight == true
                                ? TextButton(
                                    onPressed: () {
                                      navigateTo(context, const RegisterScreen());
                                    },
                                    child: Text(
                                      'Register Now!',
                                      style: GoogleFonts.amiri(
                                        textStyle: TextStyle(
                                          color: cubit.isLight
                                              ? Colors.blue
                                              : Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    margin:
                                        const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40)),
                                    child: TextButton(
                                      onPressed: () {
                                        navigateTo(
                                            context, const RegisterScreen());
                                      },
                                      child: Text(
                                        'Register Now!',
                                        style: GoogleFonts.amiri(
                                          textStyle: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: ()  {
                                LoginCubit.get(context).signINWithGoogle();
                              },
                              child: CircleAvatar(
                                backgroundImage: const AssetImage(
                                  'assets/images/Google_Logo.png',
                                ),
                                radius: 25,
                                backgroundColor:
                                    cubit.isLight ? Colors.black : Colors.white,
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                navigateTo(context, const AuthPhone());
                              },
                              child: CircleAvatar(
                                backgroundImage: const AssetImage(
                                  'assets/images/phone.png',
                                ),
                                radius: 25,
                                backgroundColor:
                                    cubit.isLight ? Colors.black : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
