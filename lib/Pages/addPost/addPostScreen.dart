import 'package:sociella/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:sociella/shared/Cubit/socialCubit/SocialState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/post_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key}) : super(key: key);
  var textController = TextEditingController();
  PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    var userModel = SocialCubit.get(context).userModel!;
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                cubit.removePostImage();
              },
              icon: Icon(
                IconlyLight.arrowLeft2,
                size: 30,
                color: cubit.isLight ? Colors.black : Colors.white,
              ),
            ),
            titleSpacing: 1,
            title: Text(
              'Create Post',
              style: GoogleFonts.amiri(
                color: cubit.isLight ? Colors.blue : Colors.white,
                fontSize: 20,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  DateTime now = DateTime.now();
                  if (cubit.postImagePicked == null) {
                    cubit.createPost(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  } else {
                    cubit.uploadPostImage(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  }
                },
                child: Text(
                  'Post',
                  style: GoogleFonts.amiri(
                    color: cubit.isLight ? Colors.blue : Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
            elevation: 5,
          ),
          body: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is CreatePostLoadingState)
                      const LinearProgressIndicator(),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        20,
                        20,
                        20,
                        0,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                              userModel.image!,
                            ),
                          ),
                          space(10, 0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userModel.name!,
                                style: GoogleFonts.amiri(
                                  color: cubit.isLight
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              space(0, 8),
                              Row(
                                children: [
                                  Icon(
                                    IconlyLight.user2,
                                    color: cubit.isLight
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  space(5, 0),
                                  Text(
                                    'public',
                                    style: GoogleFonts.amiri(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    space(0, 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        maxLines: 6,
                        minLines: 1,
                        style: GoogleFonts.cairo(
                          height: 1.5,
                          color: cubit.isLight ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: 'What\'s On Your Mind?',
                          hintStyle: GoogleFonts.amiri(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (SocialCubit.get(context).postImagePicked != null)
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                    image: FileImage(cubit.postImagePicked!),
                                    fit: BoxFit.contain),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                cubit.removePostImage();
                              },
                              icon: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          blurRadius: 9,
                                          spreadRadius: 4,
                                          offset: const Offset(0, 4))
                                    ]),
                                child: const CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      Icons.close_rounded,
                                      color: Colors.white,
                                    ),
                                ),
                              ),
                          )
                        ],
                      ),
                    space(0, 50),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          cubit.isLight ? Colors.white : const Color(0xff4C5C68),
                        ),
                      ),
                      onPressed: () {
                        cubit.getPostImage();
                      },
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      label: Text(
                        'Add photo'.toUpperCase(),
                        style: GoogleFonts.amiri(
                            fontSize: 20,
                            color: cubit.isLight ? Colors.blue : Colors.white),
                      ),
                      icon: Icon(
                        IconlyLight.image,
                        color: cubit.isLight ? Colors.blue : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
