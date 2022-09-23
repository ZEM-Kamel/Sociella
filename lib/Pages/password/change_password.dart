import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:sociella/shared/components/components.dart';
import 'package:sociella/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/Cubit/socialCubit/SocialCubit.dart';
import '../../shared/Cubit/socialCubit/SocialState.dart';

class EditPasswordScreen extends StatelessWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var newPasswordController = TextEditingController();
    var newPasswordController2 = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var userModel = SocialCubit.get(context).userModel;
        var formKey = GlobalKey<FormState>();
        return ConditionalBuilder(
          condition: userModel != null,
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor:
                  cubit.isLight ? Colors.white : const Color(0xff4C5C68),
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor:
                      cubit.isLight ? Colors.white : const Color(0xff4C5C68),
                  statusBarIconBrightness:
                      cubit.isLight ? Brightness.dark : Brightness.light,
                  statusBarBrightness:
                      cubit.isLight ? Brightness.dark : Brightness.light,
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
                titleSpacing: 1,
                title: Text(
                  'Change Password',
                  style: GoogleFonts.amiri(
                    color: cubit.isLight ? Colors.blue : Colors.white,
                    fontSize: 20,
                  ),
                ),
                elevation: 2,
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You Should Re-login Before\n Change Password',
                          style: GoogleFonts.amiri(
                            color: cubit.isLight ? Colors.black : Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          context: context,
                          isPassword: cubit.isPassword,
                          controller: newPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          hint: 'New Password',
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'password must be not empty';
                            }
                            if (value != newPasswordController2.text) {
                              return ' Password is not the same';
                            }
                            return null;
                          },
                          prefix: IconlyBroken.unlock,
                          suffix: cubit.suffix,
                          suffixPressed: () {
                            cubit.showPassword();
                          },
                        ),
                        space(0, 20),
                        defaultTextFormField(
                          context: context,
                          isPassword: cubit.isPassword,
                          controller: newPasswordController2,
                          keyboardType: TextInputType.visiblePassword,
                          hint: 'Confirm New Password',
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'password must be not empty';
                            }
                            if (value != newPasswordController.text) {
                              return ' Password is not the same';
                            }
                            return null;
                          },
                          prefix: IconlyBroken.unlock,
                          suffix: cubit.suffix,
                          suffixPressed: () {
                            cubit.showPassword();
                          },
                        ),
                        space(0, 55),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    cubit.isLight
                                        ? Colors.white
                                        : const Color(0xff4C5C68),
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.changeUserPassword(
                                      password: newPasswordController.text,
                                    );
                                  }
                                },
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                label: Text(
                                  'Update'.toUpperCase(),
                                  style: GoogleFonts.amiri(
                                      fontSize: 20,
                                      color: cubit.isLight
                                          ? Colors.blue
                                          : Colors.white),
                                ),
                                icon: Icon(
                                  IconlyLight.upload,
                                  color: cubit.isLight
                                      ? Colors.blue
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
