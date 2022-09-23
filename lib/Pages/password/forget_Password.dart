import 'package:sociella/Pages/Login/login_screen.dart';
import 'package:sociella/shared/Cubit/restPasswordCubit/rest_password_cubit.dart';
import 'package:sociella/shared/Cubit/restPasswordCubit/rest_password_state.dart';
import 'package:sociella/shared/components/components.dart';
import 'package:sociella/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/Cubit/socialCubit/SocialCubit.dart';

class RestPasswordScreen extends StatelessWidget {
  var loginFormKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  RestPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            navigateAndFinish(context, const LoginScreen());
          }
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor:
                cubit.isLight ? Colors.white : const Color(0xff4C5C68),

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
              elevation: 1,
              leading: IconButton(
                onPressed: () {
                  emailController.clear();
                  pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: cubit.isLight ? Colors.black : Colors.white,
                ),
              ),
              titleSpacing: 1,
              title: Text(
                'Forget Password',
                style: GoogleFonts.amiri(
                  textStyle: TextStyle(
                    color: cubit.isLight ? Colors.black : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            body: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Resetpassword.png'),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter the E-mail address associated with your account',
                              style: GoogleFonts.b612(
                                fontSize: 27,
                                fontWeight: FontWeight.w900,
                                color:
                                    cubit.isLight ? Colors.black : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          20,
                          25,
                          20,
                          0,
                        ),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurStyle: BlurStyle.outer,
                                  color: cubit.isLight
                                      ? const Color(0xff4C5C68)
                                      : Colors.white,
                                  blurRadius: 9,
                                  spreadRadius: 10,
                                  offset: const Offset(0, 1))
                            ],
                            border: Border.all(
                              color: cubit.isLight
                                  ? const Color(0xff4C5C68)
                                  : Colors.white,
                            ),
                            color: cubit.isLight
                                ? Colors.white
                                : const Color(0xff4C5C68),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(50.0),
                              topLeft: Radius.circular(50.0),
                            )),
                        child: Form(
                          key: loginFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             space(0, 10),
                              defaultTextFormField(
                                context: context,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                prefix: Icons.email,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Your E-mail';
                                  }
                                  return null;
                                },
                                hint: 'E-mail Address',
                              ),
                             const Spacer(),
                              state is ResetPasswordLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Container(
                                color:
                                     Colors.blue,

                                    child: defaultTextButton(
                                           context: context,
                                        text: 'RESET PASSWORD',
                                        function: () {
                                          if (loginFormKey.currentState!
                                              .validate()) {
                                            ResetPasswordCubit.get(context)
                                                .resetPassword(
                                              email: emailController.text,
                                            );
                                          }
                                        },
                                      ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
