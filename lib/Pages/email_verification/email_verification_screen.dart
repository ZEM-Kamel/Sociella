import 'package:sociella/layout/Home/home_layout.dart';
import 'package:sociella/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:sociella/shared/components/components.dart';
import 'package:sociella/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/Cubit/EmailVerification/email_verification_cubit.dart';
import '../../shared/Cubit/EmailVerification/email_verification_state.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => EmailVerificationCubit(),
      child: BlocConsumer<EmailVerificationCubit, EmailVerificationStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = EmailVerificationCubit.get(context);
          var mode = SocialCubit.get(context);
          return Scaffold(
            backgroundColor:
                mode.isLight ? Colors.white : const Color(0xff4C5C68),
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor:
                    mode.isLight ? Colors.white : const Color(0xff4C5C68),
                statusBarIconBrightness:
                    mode.isLight ? Brightness.dark : Brightness.light,
                statusBarBrightness:
                    mode.isLight ? Brightness.dark : Brightness.light,
              ),
              backgroundColor:
                  mode.isLight ? Colors.white : const Color(0xff4C5C68),
              leading: IconButton(
                onPressed: () {
                  pop(context);
                },
                icon: Icon(
                  IconlyLight.arrowLeft2,
                  size: 30,
                  color: mode.isLight ? Colors.black : Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    space(0, 35),
                    Container(
                      decoration: BoxDecoration(
                          color: mode.isLight ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(75.0)),
                      child: const CircleAvatar(
                        radius: 80.0,
                        backgroundImage: AssetImage('assets/images/email.png'),
                      ),
                    ),
                    space(0, 15),
                    Text('Email Confirmation',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: mode.isLight ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w800,
                        )),
                    space(0, 10),
                    Center(
                      child: Text(
                        'we\'re happy you signed up for Sociella.'
                            ' To start exploring the \nSociella,please confirm your\nE-mail Address.',
                        style: GoogleFonts.b612(
                          textStyle: TextStyle(
                            color: mode.isLight ? Colors.black : Colors.white,
                            fontSize: 20,
                            overflow: TextOverflow.visible,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    space(0, 45),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: state is SendVerificationLoadingState
                          ? const CircularProgressIndicator()
                          : cubit.isEmailSent
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      color: mode.isLight
                                          ? Colors.green
                                          : Colors.white,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline,
                                            color: mode.isLight
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          Text(
                                            'Email Verification Sent',
                                            style: GoogleFonts.b612(
                                              textStyle: TextStyle(
                                                color: mode.isLight
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    space(10, 0),
                                    TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            mode.isLight
                                                ? Colors.red
                                                : Colors.white,
                                          ),
                                        ),
                                        onPressed: () {
                                          cubit.sendEmailVerification();
                                        },
                                        child: Text(
                                          'Send again',
                                          style: GoogleFonts.b612(
                                            textStyle: TextStyle(
                                              color: mode.isLight
                                                  ? Colors.white
                                                  : Colors.black,
                                              overflow: TextOverflow.visible,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ))
                                  ],
                                )
                              : Card(
                                  color:
                                      mode.isLight ? Colors.blue : Colors.grey,
                                  child: defaultTextButton(
                                    context: context,
                                    function: () {
                                      cubit.sendEmailVerification();
                                    },
                                    text: 'Send Email',
                                  ),
                                ),
                    ),
                    space(0, 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: cubit.isEmailSent
                          ? Card(
                              color: mode.isLight ? Colors.green : Colors.grey,
                              child: defaultTextButton(
                                context: context,
                                  function: () {
                                    cubit.reloadUser().then((value) {
                                      if (cubit.isEmailVerified) {
                                        SocialCubit.get(context)..getPosts()
                                          ..getUserData()
                                          ..getAllUsers();
                                        navigateAndFinish(
                                            context,  HomeLayout());
                                      } else {}
                                    });
                                  },
                                  text: 'Verified, Go Home'),
                            )
                          : Card(
                              color: mode.isLight ? Colors.blue : Colors.grey,
                              child: defaultTextButton(
                                context: context,
                                function: () {},
                                text: 'Verified, Go Home',
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
