import 'package:sociella/Pages/password/forget_Password.dart';
import 'package:sociella/Pages/profile/Edit_profile_screen.dart';
import 'package:sociella/Pages/profile/My_profile_screen.dart';
import 'package:sociella/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:sociella/shared/components/components.dart';
import 'package:sociella/shared/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../shared/Cubit/socialCubit/SocialState.dart';
import '../password/change_password.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel!;
        var cubit = SocialCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Setting ',
                  style: GoogleFonts.amiri(
                    color: cubit.isLight ? Colors.blue : Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  height: 4.0,
                  color: Colors.grey.shade200,
                ),
                Card(
                  color:
                      cubit.isLight ? Colors.grey[300] : const Color(0xff4C5C68),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        navigateTo(context, const MyProfileScreen());
                      },
                      child: Row(
                        children: [
                           CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              userModel.image!,
                            ),
                          ),
                          space(10, 0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userModel.name!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.amiri(
                                    color: cubit.isLight
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'see your profile',
                                  style: GoogleFonts.amiri(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          color: cubit.isLight
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                         
                          Icon(
                            IconlyLight.arrowRight2,
                            color: cubit.isLight ? Colors.blue : Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                space(0, 10),
                Text(
                  'Account',
                  style: GoogleFonts.amiri(
                    color: cubit.isLight ? Colors.blue : Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  height: 4.0,
                  color: Colors.grey.shade200,
                ),
                Card(
                  color:
                      cubit.isLight ? Colors.grey[300] : const Color(0xff4C5C68),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                            navigateTo(context,  EditProfileScreen());
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              IconlyBroken.profile,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          space(10, 0),
                          Text(
                            'Your Personal info',
                            style: GoogleFonts.amiri(
                              color: cubit.isLight ? Colors.black : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            IconlyLight.arrowRight2,
                            color: cubit.isLight ? Colors.blue : Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Card(
                  color:
                      cubit.isLight ? Colors.grey[300] : const Color(0xff4C5C68),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        navigateTo(context, RestPasswordScreen());
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              IconlyBroken.lock,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          space(10, 0),
                          Text(
                            'Reset Password',
                            style: GoogleFonts.amiri(
                              color: cubit.isLight ? Colors.black : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            IconlyLight.arrowRight2,
                            color: cubit.isLight ? Colors.blue : Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color:
                      cubit.isLight ? Colors.grey[300] : const Color(0xff4C5C68),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        navigateTo(context, const EditPasswordScreen());
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              IconlyBroken.unlock,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          space(10, 0),
                          Text(
                            'Change Password',
                            style: GoogleFonts.amiri(
                              color: cubit.isLight ? Colors.black : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            IconlyLight.arrowRight2,
                            color: cubit.isLight ? Colors.blue : Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color:
                      cubit.isLight ? Colors.grey[300] : const Color(0xff4C5C68),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Alert(
                          style: AlertStyle(
                            animationType: AnimationType.shrink,
                            animationDuration:
                                const Duration(milliseconds: 2000),
                            backgroundColor: cubit.isLight
                                ? const Color(0xff4C5C68)
                                : Colors.white,
                            isCloseButton: false,
                            titleStyle: GoogleFonts.amiri(
                              color: cubit.isLight ? Colors.white : Colors.black,
                            ),
                            descStyle: GoogleFonts.amiri(
                              color: cubit.isLight ? Colors.white : Colors.black,
                            ),
                          ),
                          padding: EdgeInsets.zero,
                          image: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Image(
                                height: 200,
                                width: 500,
                                fit: BoxFit.cover,
                                image: cubit.isLight
                                    ? const NetworkImage(
                                        'https://img.freepik.com/premium-photo/sunny-sky-with-clouds_87394-1064.jpg?size=626&ext=jpg&ga=GA1.2.1171791867.1661092769')
                                    : const NetworkImage(
                                        'https://img.freepik.com/free-photo/moon_181624-19708.jpg?size=626&ext=jpg&ga=GA1.2.1171791867.1661092769'),
                              ),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(
                                  IconlyBold.closeSquare,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          context: context,
                          title: "Theme Mode",
                          desc: "Do you want change mode.",
                          buttons: [
                            DialogButton(
                              onPressed: () => Navigator.pop(context),
                              color: Colors.red,
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.amiri(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            DialogButton(
                              onPressed: () {
                                cubit.changeMode();
                                Navigator.pop(context);
                              },
                              color: Colors.blue,
                              child: Text(
                                "Done",
                                style: GoogleFonts.amiri(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ).show();
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              cubit.isLight
                                  ? Icons.nightlight_outlined
                                  : Icons.wb_sunny,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          space(10, 0),
                          Text(
                            'Theme Mode',
                            style: GoogleFonts.amiri(
                              color: cubit.isLight ? Colors.black : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            IconlyLight.arrowRight2,
                            color: cubit.isLight ? Colors.blue : Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color:
                      cubit.isLight ? Colors.grey[300] : const Color(0xff4C5C68),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: ()
                      {
                        Alert(
                          style: AlertStyle(
                            animationType: AnimationType.shrink,
                            animationDuration:
                            const Duration(milliseconds: 2000),
                            backgroundColor: cubit.isLight
                                ? const Color(0xff4C5C68)
                                : Colors.white,
                            isCloseButton: false,
                            titleStyle: GoogleFonts.amiri(
                              color: cubit.isLight ? Colors.white : Colors.black,
                            ),
                            descStyle: GoogleFonts.amiri(
                              color: cubit.isLight ? Colors.white : Colors.black,
                            ),
                          ),
                          padding: EdgeInsets.zero,
                          image: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Image(
                                height: 200,
                                width: 500,
                                fit: BoxFit.cover,
                                image: cubit.isLight
                                    ? const NetworkImage(
                                    'https://img.freepik.com/premium-vector/blocked-account-conceptual-design-premium-vector_199064-108.jpg?w=740')
                                    : const NetworkImage(
                                    'https://img.freepik.com/premium-vector/blocked-account-conceptual-design-premium-vector_199064-109.jpg?w=740'),
                              ),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(
                                  IconlyBold.closeSquare,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          context: context,
                          desc: "Do you want Delete Account.",
                          buttons: [
                            DialogButton(
                              onPressed: () => Navigator.pop(context),
                              color: Colors.red,
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.amiri(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            DialogButton(
                              onPressed: () {
                                cubit.deleteAccount(context);
                                Navigator.pop(context);
                              },
                              color: Colors.blue,
                              child: Text(
                                "Done",
                                style: GoogleFonts.amiri(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ).show();

                      },
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              IconlyBroken.delete,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          space(10, 0),
                          Text(
                            'Delete your Account',
                            style: GoogleFonts.amiri(
                              color: cubit.isLight ? Colors.black : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            IconlyLight.arrowRight2,
                            color: cubit.isLight ? Colors.blue : Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color:
                      cubit.isLight ? Colors.grey[300] : const Color(0xff4C5C68),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        logOut(context);
                        FirebaseAuth.instance.signOut();
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.power_settings_new_rounded,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          space(10, 0),
                          Text(
                            'LogOut',
                            style: GoogleFonts.amiri(
                              color: cubit.isLight ? Colors.black : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            IconlyLight.arrowRight2,
                            color: cubit.isLight ? Colors.blue : Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
