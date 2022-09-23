import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:sociella/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:sociella/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../shared/Cubit/socialCubit/SocialState.dart';


class CreateStory extends StatelessWidget {
  CreateStory({
    Key? key,
  }) : super(key: key);
  TextEditingController story = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {
      if (state is CreateStorySuccessState) {
        Navigator.pop(context);
        SocialCubit.get(context).getPersonalStory(SocialCubit.get(context).userModel!.uId);
        Fluttertoast.showToast(
            msg: "Your story is created successfully",
            fontSize: 16,
            gravity: ToastGravity.BOTTOM,
            textColor: Theme.of(context).scaffoldBackgroundColor,
            backgroundColor: Colors.green,
            toastLength: Toast.LENGTH_LONG);
      }
    }, builder: (context, state) {
      var bloc = SocialCubit.get(context);
      return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(bloc.storyImage!),
                        fit: BoxFit.contain)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            SocialCubit.get(context).userModel!.image!,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                SocialCubit.get(context).userModel!.name!,
                                style: const TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 23,
                              )
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              bloc.closeStory();
                              pop(context);
                              bloc.addText = false;
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 9,
                                        spreadRadius: 4,
                                        offset: const Offset(0, 4))
                                  ]),
                              child: CircleAvatar(
                                  backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                                  child: const Icon(
                                    Icons.close_rounded,
                                    color: Colors.black,
                                  )),
                            ))
                      ],
                    ),
                  ),
                  if (bloc.addText == false)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70.0),
                      child: Center(
                        child: TextFormField(
                          controller: story,
                          maxLines: 6,
                          minLines: 1,
                          style: const TextStyle(
                             color: Colors.white, fontSize: 30),
                          decoration: const InputDecoration(
                              hintText: "What's on your mind ...",
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              bloc.addTextStory();
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 9,
                                        spreadRadius: 4,
                                        offset: const Offset(0, 4))
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.text_fields,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    bloc.addText
                                        ? " add text"
                                        : " remove text",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              DateTime date = DateTime.now();
                              bloc.createStoryImage(
                               text: story.text, dateTime: date);
                              pop(context);
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 9,
                                        spreadRadius: 4,
                                        offset: const Offset(0, 4))
                                  ]),
                              child: ConditionalBuilder(
                                condition: state is! CreateStoryLoadingState,
                                builder: (context) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const[
                                    Icon(
                                      IconlyLight.upload,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      " Add Story",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                                fallback: (context) =>const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.blue,
                                    )),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}