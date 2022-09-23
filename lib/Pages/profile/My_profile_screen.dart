import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:sociella/Pages/profile/Edit_profile_screen.dart';
import 'package:sociella/model/post_model.dart';
import 'package:sociella/shared/components/components.dart';
import 'package:sociella/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/user_model.dart';
import '../../shared/Cubit/socialCubit/SocialCubit.dart';
import '../../shared/Cubit/socialCubit/SocialState.dart';
import '../comment/comment_screen.dart';
import '../friend/friendScreen.dart';
import '../post/edit_post.dart';
import '../veiwPhoto/image_view.dart';
import '../veiwPhoto/post_view.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context)
          .getMyPosts(SocialCubit.get(context).userModel!.uId);
      List<PostModel>? posts = SocialCubit.get(context).userPosts;
      List<UserModel>? friends = SocialCubit.get(context).friends;
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state)
        {
          if (state is SavedToGalleryLoadingState) {
            Navigator.pop(context);
          }
          if (state is SavedToGallerySuccessState) {
            Fluttertoast.showToast(
                msg: "Downloaded to Gallery!",
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
                timeInSecForIosWeb: 5,
                fontSize: 18);
          }

          if (state is LikesSuccessState) {
            Fluttertoast.showToast(
                msg: "Likes Success!",
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
                timeInSecForIosWeb: 5,
                fontSize: 18);
          }

          if (state is DisLikesSuccessState) {
            Fluttertoast.showToast(
                msg: "UnLikes Success!",
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                timeInSecForIosWeb: 5,
                fontSize: 18);
          }
        },
        builder: (context, state) {
          List<PostModel>? userPosts = SocialCubit.get(context).userPosts;
          var userModel = SocialCubit.get(context).userModel;
          var cubit = SocialCubit.get(context);
          return SocialCubit.get(context).userModel == null
              ? Scaffold(
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
                    const CircularProgressIndicator(),
                  ],
                ),
              )):
            userPosts.isEmpty
              ? SafeArea(
                child: Scaffold(
                 backgroundColor:
                 cubit.isLight ? Colors.white : const Color(0xff4C5C68),
                    body: buildProfileWithOutPosts(),
                  ),
              )
              : ConditionalBuilder(
                  condition: userPosts.isNotEmpty,
                  builder: (BuildContext context) => SafeArea(
                    child: Scaffold(
                      backgroundColor:
                          cubit.isLight ? Colors.white : const Color(0xff4C5C68),
                      body: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 280,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  InkWell(
                                    onTap: ()
                                    {
                                      navigateTo(context, ImageViewScreen(image: cubit.userModel!.cover, body: ''));

                                    },
                                    child: Align(
                                      alignment: AlignmentDirectional.topCenter,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  '${userModel!.cover}'),
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(8.0),
                                            )),
                                        width: double.infinity,
                                        height: 230,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: ()
                                    {
                                      navigateTo(context, ImageViewScreen(image: cubit.userModel!.image, body: ''));

                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 75,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          '${userModel.image}',
                                        ),
                                        radius: 70,
                                      ),
                                    ),
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
                            space(0, 5),
                            Text(
                              '${userModel.name}',
                              style: GoogleFonts.b612(
                                fontSize: 20,
                                color:
                                    cubit.isLight ? Colors.blue : Colors.white,
                              ),
                            ),
                            space(0, 5),
                            Text(
                              '${userModel.bio}',
                              style: GoogleFonts.b612(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                              ),
                            ),
                            space(0, 15),

                            Card(
                              margin:
                              const EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.grey[100],
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          '${posts.length}',
                                          style: GoogleFonts.amiri(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(fontSize: 20),
                                          ),
                                        ),
                                        Text(
                                          'Posts',
                                          style: GoogleFonts.b612(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          '10K',
                                          style: GoogleFonts.b612(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(fontSize: 20),
                                          ),
                                        ),
                                        Text(
                                          'Followers',
                                          style: GoogleFonts.b612(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: ()
                                      {
                                        navigateTo(context, FriendsScreen(friends,myFreinds: true,));

                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            '${friends.length}',
                                            style: GoogleFonts.b612(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(fontSize: 20),
                                            ),
                                          ),
                                          Text(
                                            'Friends',
                                            style: GoogleFonts.b612(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            space(0, 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextButton.icon(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.blue)),
                                      onPressed: ()
                                      {
                                        cubit.getStoryImage(context);
                                      },
                                      icon: const Icon(
                                        IconlyLight.plus,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Add story',
                                        style: GoogleFonts.b612(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  space(20, 0),
                                  Expanded(
                                    child: TextButton.icon(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          cubit.isLight
                                              ? Colors.grey.shade400
                                              : const Color(0xff4C5C68),
                                        ),
                                      ),
                                      onPressed: () {
                                        navigateTo(
                                            context, EditProfileScreen());
                                      },
                                      icon: Icon(
                                        IconlyLight.edit,
                                        color: cubit.isLight
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      label: Text(
                                        'Edit profile',
                                        style: GoogleFonts.b612(
                                          color: cubit.isLight
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            myDivider2(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Text(
                                  'Posts',
                                  style: GoogleFonts.amiri(
                                    fontSize: 24,
                                    color: cubit.isLight
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            space(0, 10),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: userPosts.length,
                              separatorBuilder: (context, index) =>
                                  space(0, 10),
                              itemBuilder: (context, index) =>
                                  (buildPostItem(userPosts[index], context,index)),
                            ),
                            space(0, 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  fallback: (BuildContext context) =>
                      const CircularProgressIndicator(),
                );
        },
      );
    });
  }
}

Widget buildProfileWithOutPosts () => Builder(
  builder: (context) {
    var cubit = SocialCubit.get(context);
    var userModel = SocialCubit.get(context).userModel;
    List<PostModel>? posts = SocialCubit.get(context).userPosts;
    List<UserModel>? friends = SocialCubit.get(context).friends;

    return Column(
      children: [
        SizedBox(
          height: 240,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              InkWell(
                onTap: () {
                  ///view Photo
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => view()));
                },
                child: Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              '${userModel!.cover}'),
                        ),
                        borderRadius:
                        const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        )),
                    width: double.infinity,
                    height: 200,
                  ),
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 65,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    '${userModel.image}',
                  ),
                  radius: 60,
                ),
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
        space(0, 5),
        Text(
          '${userModel.name}',
          style: GoogleFonts.amiri(
            fontSize: 24,
            color:
            cubit.isLight ? Colors.blue : Colors.white,
          ),
        ),
        space(0, 5),
        Text(
          '${userModel.bio}',
          style: GoogleFonts.amiri(
            textStyle: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
        space(0, 15),
        Card(
          margin:
          const EdgeInsets.symmetric(horizontal: 10),
          color: Colors.grey[100],
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${posts.length}',
                      style: GoogleFonts.amiri(
                        textStyle: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 20),
                      ),
                    ),
                    Text(
                      'Posts',
                      style: GoogleFonts.amiri(
                        textStyle: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '10K',
                      style: GoogleFonts.amiri(
                        textStyle: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 20),
                      ),
                    ),
                    Text(
                      'Followers',
                      style: GoogleFonts.amiri(
                        textStyle: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: ()
                  {
                    navigateTo(context, FriendsScreen(friends,myFreinds: true,));

                  },
                  child: Column(
                    children: [
                      Text(
                        '${friends.length}',
                        style: GoogleFonts.amiri(
                          textStyle: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      Text(
                        'Friends',
                        style: GoogleFonts.amiri(
                          textStyle: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        space(0, 15),
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(
                          Colors.blue)),
                  onPressed: ()
                  {
                    cubit.getStoryImage(context);
                  },
                  icon: const Icon(
                    IconlyLight.plus,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Add story',
                    style: GoogleFonts.amiri(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              space(20, 0),
              Expanded(
                child: TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(
                      cubit.isLight
                          ? Colors.grey.shade400
                          : const Color(0xff4C5C68),
                    ),
                  ),
                  onPressed: () {
                    navigateTo(
                        context, EditProfileScreen());
                  },
                  icon: Icon(
                    IconlyLight.edit,
                    color: cubit.isLight
                        ? Colors.black
                        : Colors.white,
                  ),
                  label: Text(
                    'Edit profile',
                    style: GoogleFonts.amiri(
                      color: cubit.isLight
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        myDivider2(),
        const Spacer(),
        const Icon(
          IconlyLight.infoSquare,
          size: 100,
          color: Colors.grey,
        ),
        Text(
          'No Posts yet', style: GoogleFonts.b612(
          fontWeight: FontWeight.w700,
          fontSize: 30,
          color:  Colors.grey,
        ),),
        const Spacer(),
      ],
    );
  }
);

Widget buildPostItem(PostModel postModel, context,index) {
  late String postId;
  var cubit = SocialCubit.get(context);
  postId = SocialCubit.get(context).postsId[index];
  return Card(
    color: SocialCubit.get(context).isLight
        ? Colors.white
        : const Color(0xff4C5C68),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  '${postModel.image}',
                ),
              ),
              space(15, 0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${postModel.name}',
                          style: GoogleFonts.amiri(
                            fontSize: 20,
                            height: 1.3,
                            color: SocialCubit.get(context).isLight
                                ? CupertinoColors.activeBlue
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
                    Text(
                      daysBetween(
                          DateTime.parse(postModel.dateTime.toString())),
                      style: GoogleFonts.amiri(
                          fontSize: 15,
                          color: Colors.grey,
                          textStyle: Theme.of(context).textTheme.caption,
                          height: 1.3),
                    ),
                  ],
                ),
              ),
              space(15, 0),
              IconButton(
                onPressed: () {
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
                              if (postModel.uId == cubit.userModel!.uId)
                                InkWell(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        EditPosts(
                                          postModel: postModel,
                                          postId: postId,
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                      top: 20,
                                      bottom: 0,
                                    ),
                                    child: Row(
                                      children:  [
                                        const Icon(
                                          Icons.edit_location_outlined,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        space(10, 0),
                                        const Text(
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
                                  padding: const EdgeInsets.only(
                                  left: 8,
                                    right: 8,
                                    top: 20,
                                    bottom: 0,
                                  ),
                                  child: Row(
                                    children:  [
                                      const Icon(
                                        Icons.turned_in_not_sharp,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      space(10, 0),
                                      const Text(
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

                              if (postModel.postImage != '')
                                InkWell(
                                  onTap: () {
                                    cubit.saveToGallery(postModel.postImage!);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                      top: 20,
                                      bottom: 0,
                                    ),
                                    child: Row(
                                      children:  [
                                        const Icon(
                                          IconlyLight.download,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        space(10, 0),
                                        const Text(
                                          "Save Image",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    top: 20,
                                    bottom: 0,
                                  ),
                                  child: Row(
                                    children:  [
                                      const Icon(
                                        Icons.share,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                     space(10, 0),
                                      const Text(
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
                              if (postModel.uId == cubit.userModel!.uId)
                                InkWell(
                                  onTap: () {
                                    cubit.deletePost(postId);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                      top: 20,
                                      bottom: 0,
                                    ),
                                    child: Row(
                                      children:  [
                                        const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                       space(10, 0),
                                        const Text(
                                          "Delete Post",
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
                icon: Icon(
                  IconlyLight.moreCircle,
                  size: 25,
                  color: SocialCubit.get(context).isLight
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              color: Colors.grey[300],
              height: 2,
              width: double.infinity,
            ),
          ),
          Text(
            '${postModel.text}',
            style: GoogleFonts.b612(
              color:
                  SocialCubit.get(context).isLight ? Colors.black : Colors.white,
            ),
          ),
          space(0, 12),
          if (postModel.postImage != '')
            InkWell(
              onTap: ()
              {
                navigateTo(context, FullScreen(postModel,index: index,));

              },
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            // blurRadius: 0,
                            // spreadRadius: 0,
                            // offset: Offset(0, 0)
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image(
                            image: NetworkImage('${postModel.postImage}'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.heart,
                  color: Colors.red,
                ),
                label: Text(
                  '${SocialCubit.get(context).likes[index]}',
                  style: GoogleFonts.amiri(
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: ()
                {
                  navigateTo(context, CommentsScreen(SocialCubit.get(context).postsId[index],postModel.uId,));

                },
                icon: const Icon(
                  IconlyLight.chat,
                  color: Colors.orangeAccent,
                ),
                label: Text(
                  '${SocialCubit.get(context).commentsNum[index]}',
                  style: GoogleFonts.amiri(
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Container(
              color: Colors.grey[300],
              height: 2,
              width: double.infinity,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  navigateTo(context, const MyProfileScreen());
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage('${postModel.image}'),
                ),
              ),
              space(10, 0),
              InkWell(
                onTap: ()
                {
                  navigateTo(context, CommentsScreen(SocialCubit.get(context).postsId[index],postModel.uId,));

                },
                child: SizedBox(
                  width: 120,
                  child: Text(
                    'Write a comment ...',
                    style: GoogleFonts.amiri(
                      textStyle: Theme.of(context).textTheme.caption,
                      fontSize: 15,
                      color: const Color(0xff090446),
                    ),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
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
                label: Text(
                  'Like',
                  style: GoogleFonts.amiri(
                    color: SocialCubit.get(context).likedByMe[index] == true
                        ? Colors.red
                        : Colors.grey,
                  ),
                ),
                icon: Icon(
                  IconlyLight.heart,
                  color: SocialCubit.get(context).likedByMe[index] == true
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.upload,
                  color: Colors.green,
                ),
                label: Text(
                  'Share',
                  style: GoogleFonts.amiri(
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

