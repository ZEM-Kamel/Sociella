import 'package:sociella/model/post_model.dart';
import 'package:sociella/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:sociella/shared/Cubit/socialCubit/SocialState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../comment/comment_screen.dart';
import '../post/edit_post.dart';

class FullScreen extends StatelessWidget {
  final PostModel model;
  final int index;
  const FullScreen(this.model, {Key? key,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context,) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child:  buildMenu(context, index),
          ),
        );
      },
    );
  }

  Widget buildMenu(context,  index, ) {
    var cubit = SocialCubit.get(context);
    late String postId;
    postId = SocialCubit.get(context).postsId[index];
    return Stack(
        children:
        [
          SizedBox.expand(
            child: InteractiveViewer(
              child: InkWell(
                onLongPress: ()
                {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30))),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (model.uId == cubit.userModel!.uId)
                                InkWell(
                                  onTap: () {
                                    navigateTo(context, EditPosts(
                                      postModel: model,
                                      postId:postId,

                                    ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.edit_location_outlined,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Edit Post",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  // cubit.savePost(
                                  //     postId: postId,
                                  //     date: DateTime.now(),
                                  //     userName: model.name,
                                  //     userId: model.uId,
                                  //     userImage: model.image,
                                  //     postText: model.text,
                                  //     postImage: model.postImage);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.turned_in_not_sharp,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Save Post",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              if (model.postImage != '')
                                InkWell(
                                  onTap: () {
                                    cubit.saveToGallery(
                                        model.postImage!);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.save_outlined,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Save Post Image",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.share,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Share",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('${model.postImage}'),
                          fit: BoxFit.contain)),
                ),
              ),
            ),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.red,
                                  blurRadius: 9,
                                  spreadRadius: 4,
                                  offset: Offset(0, 1))
                            ]),
                        child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  ]),
                ),
              ]),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model.name}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (model.text != "")
                          Text(
                            '${model.text}',
                            textAlign: TextAlign.start,
                            style: const TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          daysBetween(
                              DateTime.parse(model.dateTime.toString())),
                          style: GoogleFonts.amiri(
                              fontSize: 15,
                              color: Colors.grey,
                              textStyle: Theme.of(context).textTheme.caption,
                              height: 1.3),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: ()
                                {
                                  if (SocialCubit.get(context).likedByMe[index] == true) {
                                    SocialCubit.get(context)
                                        .disLikePost(SocialCubit.get(context).postsId[index]);
                                    SocialCubit.get(context).likedByMe[index] = false;
                                    SocialCubit.get(context).likes[index]--;
                                  } else {
                                    SocialCubit.get(context)
                                        .likePost(SocialCubit.get(context).postsId[index]);
                                    SocialCubit.get(context).likedByMe[index] = true;
                                    SocialCubit.get(context).likes[index]++;
                                  }
                                },
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${SocialCubit.get(context).likes[index]}',
                                        style: GoogleFonts.amiri(
                                          color: Colors.white,
                                          fontSize: 20
                                        ),
                                      ),
                                      space(10, 0),
                                      Icon(
                                        IconlyLight.heart,
                                        color: SocialCubit.get(context).likedByMe[index] == true
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Like',
                                        style: GoogleFonts.amiri(
                                          color: SocialCubit.get(context).likedByMe[index] == true
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  navigateTo(
                                      context,
                                      CommentsScreen(SocialCubit.get(context).postsId[index],
                                          model.uId,));
                                },
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                      '${SocialCubit.get(context).commentsNum[index]}',
                                        style: GoogleFonts.amiri(
                                            color: Colors.white,
                                            fontSize: 20
                                        ),
                                    ),
                                      space(10, 0),
                                      const Icon(
                                        Icons.comment_outlined,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Comments',
                                        style: GoogleFonts.amiri(
                                            color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ]);
  }
}
