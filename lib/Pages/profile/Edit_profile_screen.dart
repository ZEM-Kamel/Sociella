import 'dart:io';
import 'package:sociella/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:sociella/shared/Cubit/socialCubit/SocialState.dart';
import 'package:sociella/shared/components/components.dart';
import 'package:sociella/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        File? profileImage = SocialCubit.get(context).profileImage;
        File? coverImage = SocialCubit.get(context).coverImage;
        var cubit = SocialCubit.get(context);
        emailController.text = userModel!.email!;
        bioController.text = userModel.bio!;
        nameController.text = userModel.name!;
        phoneController.text = userModel.phone!;

        return SocialCubit.get(context).userModel == null ? Scaffold(
            backgroundColor:
             cubit.isLight ? Colors.white : const Color(0xff4C5C68),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    IconlyLight.infoSquare,
                    size: 100,
                    color: Colors.grey,
                  ),
                  Text(
                    'No Posts yet',
                    style: GoogleFonts.b612(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ))
            : SafeArea(
          child: Scaffold(
            backgroundColor:
                cubit.isLight ? Colors.white : const Color(0xff4C5C68),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 240,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: coverImage == null
                                              ? NetworkImage(userModel.cover!)
                                              : FileImage(coverImage) as ImageProvider,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0),
                                        ),
                                      ),
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: cubit.isLight
                                            ? Colors.grey.shade50
                                            : const Color(0xff4C5C68),
                                        child: IconButton(
                                          splashRadius: 1,
                                          onPressed: () {
                                            cubit.getCoverImage();
                                          },
                                          icon: Icon(
                                            IconlyLight.camera,
                                            color: cubit.isLight
                                                ? Colors.black
                                                : Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 65,
                                    child: CircleAvatar(
                                      backgroundImage: profileImage == null
                                          ? NetworkImage(userModel.image!)
                                          : FileImage(profileImage) as ImageProvider,
                                      radius: 60,
                                    ),
                                  ),
                                  Positioned(
                                    top: 90,
                                    left: 90,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: cubit.isLight
                                          ? Colors.grey.shade50
                                          : const Color(0xff4C5C68),
                                      child: IconButton(
                                        splashRadius: 1,
                                        onPressed: () {
                                          cubit.getProfileImage();
                                        },
                                        icon: Icon(
                                          IconlyLight.camera,
                                          color: cubit.isLight
                                              ? Colors.black
                                              : Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 60,
                                left: 5,
                                child: IconButton(
                                  onPressed: () {
                                    pop(context);
                                  },
                                  icon: const CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      IconlyLight.arrowLeft2,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        space(0, 15),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              defaultTextFormField(
                                  context: context,
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  hint: 'Name',
                                  prefix: IconlyLight.user3),
                              space(0, 15),
                              defaultTextFormField(
                                context: context,
                                controller: bioController,
                                keyboardType: TextInputType.text,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your bio';
                                  }
                                  return null;
                                },
                                hint: 'Bio ...',
                                prefix: IconlyLight.infoSquare,
                              ),
                              space(0, 15),
                              defaultTextFormField(
                                context: context,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                                hint: 'E-mail Address',
                                prefix: IconlyLight.message,
                              ),
                              space(0, 15),
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
                                prefix: IconlyLight.calling,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty
                                  .all(
                               cubit.isLight? Colors.blue : Colors.white,
                              ),
                            ),
                            onPressed: ()
                            {
                              if(cubit.coverImage !=null && cubit.profileImage == null)
                              {
                                cubit.uploadCoverImage(
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                  bio: bioController.text,
                                );
                              }else if (cubit.profileImage != null && cubit.coverImage ==null)
                              {
                                cubit.uploadProfileImage(
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                  bio: bioController.text,);
                              }else if(cubit.profileImage == null && cubit.coverImage == null)
                              {
                                cubit.updateUserData(
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                  bio: bioController.text,
                                );
                              }else if (cubit.coverImage !=null && cubit.profileImage != null)
                              {
                                cubit.uploadProfileAndCoverImage(
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                  bio: bioController.text,
                                );
                              }

                            },
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Text(
                              'Update'.toUpperCase(),
                              style: GoogleFonts.amiri(
                                  fontSize: 20,
                                  color: cubit.isLight ? Colors.white: Colors.blue ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
                if (state is UpdateUserLoadingState)
                const LinearProgressIndicator(),
                space(0, 5),
              ],
            ),
          ),
        );
      },
    );
  }
}
