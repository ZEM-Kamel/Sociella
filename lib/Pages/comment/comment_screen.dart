import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:sociella/model/CommentModel.dart';
import 'package:sociella/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/Cubit/socialCubit/SocialCubit.dart';
import '../../shared/components/components.dart';


class CommentsScreen extends StatelessWidget {
  late String? postId;
  final String? receiverUid;
  late int likesNumber;
  late int index;

  CommentsScreen(this.postId, this.receiverUid, {Key? key,}) : super(key: key);
  var commentController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = SocialCubit.get(context);

    return Scaffold(
        backgroundColor: cubit.isLight ? Colors.white : const Color(0xff4C5C68),
        appBar: AppBar(
          backgroundColor:
              cubit.isLight ? Colors.white : const Color(0xff4C5C68),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:
                cubit.isLight ? Colors.white : const Color(0xff4C5C68),
            statusBarIconBrightness:
                cubit.isLight ? Brightness.dark : Brightness.light,
            statusBarBrightness:
                cubit.isLight ? Brightness.dark : Brightness.light,
          ),
          elevation: 1,
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
            'Comments',
            style: GoogleFonts.amiri(
              color: cubit.isLight ? Colors.blue : Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .orderBy('dateTime', descending: true)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              } else {
                cubit.comments = [];
                snapshot.data.docs.forEach((element) {
                  cubit.comments.add(CommentModel.fromJson(element.data()));
                });
                return ConditionalBuilder(
                    condition: snapshot.hasData == true &&
                        cubit.comments.isNotEmpty == true,
                    builder: (BuildContext context) => Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                reverse: false,
                                itemBuilder: (context, index) {
                                  return buildComment(cubit.comments[index], context, );
                                },
                                separatorBuilder: (context, index) =>
                                    myDivider2(),
                                itemCount: cubit.comments.length,
                              ),
                            ),
                            Container(
                              color: cubit.isLight
                                  ? const Color(0xff4C5C68)
                                  : Colors.white,
                              child: Form(
                                key: formKey,
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: CircleAvatar(
                                          radius: 35,
                                          backgroundColor: cubit.isLight
                                              ? Colors.white
                                              : const Color(0xff4C5C68),
                                          child: Icon(
                                            IconlyBroken.image,
                                            size: 25,
                                            color: cubit.isLight
                                                ? Colors.black
                                                : Colors.white,
                                          )),
                                      onPressed: () {
                                        debugPrint('add image');
                                      },
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        autofocus: false,
                                        keyboardType: TextInputType.text,
                                        enableInteractiveSelection: true,
                                        style: TextStyle(
                                          color: cubit.isLight
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 18,
                                        ),
                                        enableSuggestions: true,
                                        scrollPhysics:
                                            const BouncingScrollPhysics(),
                                        decoration: InputDecoration(
                                          focusedBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          fillColor: Colors.grey,
                                          hintText: 'comment..',
                                          hintStyle: TextStyle(
                                            color: cubit.isLight
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        autocorrect: true,
                                        controller: commentController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'The comment can\'t be empty';
                                          }
                                          return null;
                                        },
                                        onFieldSubmitted: (value) {},
                                      ),
                                    ),
                                    IconButton(
                                      icon: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: cubit.isLight
                                              ? Colors.white
                                              : const Color(0xff4C5C68),
                                          child: Icon(
                                            IconlyBroken.send,
                                            size: 25,
                                            color: cubit.isLight
                                                ? Colors.black
                                                : Colors.white,
                                          )),
                                      onPressed: () {
                                        if (formKey.currentState!.validate() ==
                                            true) {
                                          debugPrint('comment');
                                          SocialCubit.get(context).sendComment(
                                              dateTime:
                                                  DateTime.now().toString(),
                                              text: commentController.text,
                                              postId: postId);
                                          commentController.text = '';
                                          SocialCubit.get(context).getPosts();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                    fallback: (BuildContext context) => Column(
                          children: [
                            Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  const Icon(
                                    IconlyLight.chat,
                                    size: 100,
                                    color: Colors.grey,
                                  ),
                                  Center(
                                      child: Text(
                                    'No comments yet,\nPut your comment',
                                    style: GoogleFonts.b612(
                                      color: Colors.grey,
                                      fontSize: 25,
                                    ),
                                  )),
                                ])),
                            Container(
                              color: cubit.isLight
                                  ? const Color(0xff4C5C68)
                                  : Colors.white,
                              child: Form(
                                key: formKey,
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: CircleAvatar(
                                          radius: 35,
                                          backgroundColor: cubit.isLight
                                              ? Colors.white
                                              : const Color(0xff4C5C68),
                                          child: Icon(
                                            IconlyBroken.image,
                                            size: 25,
                                            color: cubit.isLight
                                                ? Colors.black
                                                : Colors.white,
                                          )),
                                      onPressed: () {
                                        debugPrint('add image');
                                      },
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        autofocus: false,
                                        keyboardType: TextInputType.text,
                                        enableInteractiveSelection: true,
                                        style: TextStyle(
                                          color: cubit.isLight
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 18,
                                        ),
                                        enableSuggestions: true,
                                        scrollPhysics:
                                            const BouncingScrollPhysics(),
                                        decoration: InputDecoration(
                                          focusedBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          fillColor: Colors.grey,
                                          hintText: 'comment..',
                                          hintStyle: TextStyle(
                                            color: cubit.isLight
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        autocorrect: true,
                                        controller: commentController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'The comment can\'t be empty';
                                          }
                                          return null;
                                        },
                                        onFieldSubmitted: (value) {},
                                      ),
                                    ),
                                    IconButton(
                                      icon: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: cubit.isLight
                                              ? Colors.white
                                              : const Color(0xff4C5C68),
                                          child: Icon(
                                            IconlyBroken.send,
                                            size: 25,
                                            color: cubit.isLight
                                                ? Colors.black
                                                : Colors.white,
                                          )),
                                      onPressed: () {
                                        if (formKey.currentState!.validate() ==
                                            true) {
                                          debugPrint('comment');
                                          SocialCubit.get(context).sendComment(
                                              dateTime:
                                                  DateTime.now().toString(),
                                              text: commentController.text,
                                              postId: postId);
                                          commentController.text = '';
                                          SocialCubit.get(context).getPosts();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ));
              }
            }),
    );
  }

  Widget buildComment(CommentModel comment, context) {

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              '${comment.image}',
            ),
          ),
          space(10, 0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 9,
                          spreadRadius: 4,
                          offset: const Offset(0, 4))
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: SocialCubit.get(context).isLight
                        ? Colors.grey.shade300
                        : const Color(0xff4C5C68),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      12,
                      5,
                      12,
                      12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${comment.name}',
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.amiri(
                                color: SocialCubit.get(context).isLight
                                    ? Colors.blue
                                    : Colors.white,
                              ),
                            ),
                            space(5, 0),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ],
                        ),
                        space(0, 10),
                        Text(
                          '${comment.comment}',
                          style: GoogleFonts.b612(
                            color: SocialCubit.get(context).isLight
                                ? Colors.black
                                : Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  daysBetween(DateTime.parse(comment.dateTime.toString())),
                  style: GoogleFonts.amiri(
                      fontSize: 15,
                      color: Colors.grey,
                      textStyle: Theme.of(context).textTheme.caption,
                      height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
