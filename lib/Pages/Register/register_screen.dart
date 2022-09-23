import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:sociella/Pages/Login/login_screen.dart';
import 'package:sociella/shared/Cubit/registerCubit/cubit.dart';
import 'package:sociella/shared/Cubit/registerCubit/state.dart';
import 'package:sociella/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/Cubit/socialCubit/SocialCubit.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/cache_helper.dart';
import '../email_verification/email_verification_screen.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is UserCreateSuccessState)
          {
            CacheHelper.saveData(
                  value: state.uid,
                  key: 'uId')
                  .then((value) {
              uId =  state.uid;
                navigateTo(context, const EmailVerificationScreen());
              }
              );
          }
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            backgroundColor:
            cubit.isLight ? Colors.white : const Color(0xff4C5C68),
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: cubit.isLight ?  Colors.white : const Color(0xff4C5C68),
                statusBarIconBrightness:cubit.isLight ? Brightness.dark : Brightness.light,
                statusBarBrightness: cubit.isLight ? Brightness.dark : Brightness.light,
              ),
              backgroundColor:
              cubit.isLight ? Colors.white : const Color(0xff4C5C68),
              leading: IconButton(
                onPressed: () {
                  pop(context);
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
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        child: Text(
                          'Sign up Now',
                          style: GoogleFonts.amiri(
                            textStyle: TextStyle(
                              color: cubit.isLight ? Colors.black : Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      space(0, 1),
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
                      space(0, 10),
                      Text(
                        'Full Name',
                        style: GoogleFonts.amiri(
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      space(0, 5),
                      defaultTextFormField(
                        context: context,
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone';
                          }
                          return null;
                        },
                        hint: 'Name',
                        prefix: Icons.person_outline_rounded,
                      ),
                      space(0, 1),
                      Text(
                        'Phone',
                        style: GoogleFonts.amiri(
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      space(0, 5),
                      defaultTextFormField(
                        context: context,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone';
                          }
                          return null;
                        },
                        hint: 'Phone',
                        prefix: Icons.phone,
                      ),
                      space(0, 1),
                      Text(
                        'E-mail Address',
                        style: GoogleFonts.amiri(
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      space(0, 5),
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
                      space(0, 1),
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
                      space(0, 5),
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
                        suffix: RegisterCubit
                            .get(context)
                            .suffix,
                        isPassword: RegisterCubit
                            .get(context)
                            .isPassword,
                        suffixPressed: () {
                          RegisterCubit.get(context).changePassword();
                        },
                      ),
                      space(0, 10),
                      Center(
                        child: ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) =>
                              defaultMaterialButton(
                                function: ()
                                {
                                  if (formKey.currentState!.validate())
                                  {
                                    RegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passController.text,
                                        phone: phoneController.text,
                                        name: nameController.text,
                                    );
                                  }

                                },
                                text: 'Register',
                              ), fallback: (BuildContext context) =>
                            const Center(child:  CircularProgressIndicator()),
                        ),
                      ),
                      space(0, 10),
                      Padding(
                        padding: const EdgeInsets.only(
                            left:75.0,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Already have an account?',
                              style: GoogleFonts.amiri(
                                textStyle:  TextStyle(
                                  color:
                                  cubit.isLight ? Colors.black : Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            cubit.isLight == true ?
                            TextButton(
                              onPressed: () {
                             navigateTo(context, const LoginScreen());
                              },
                              child: Text(
                                'Login',
                                style: GoogleFonts.amiri(
                                  textStyle: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                                : Container(
                              height: 50,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40)),
                                  child: TextButton(
                              onPressed: () {
                                  navigateTo(context, const LoginScreen());
                              },
                              child: Text(
                                  'Login',
                                  style: GoogleFonts.amiri(
                                    textStyle: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ),
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
