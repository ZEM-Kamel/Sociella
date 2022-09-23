import 'package:sociella/Pages/comment/comment_screen.dart';
import 'package:sociella/Pages/profile/My_profile_screen.dart';
import 'package:sociella/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:sociella/shared/components/components.dart';
import 'package:sociella/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/post_model.dart';
import '../../model/storyModel.dart';
import '../../shared/Cubit/socialCubit/SocialState.dart';
import '../../shared/components/constants.dart';
import '../addPost/addPostScreen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../friend/profileScreen.dart';
import '../post/edit_post.dart';
import '../story/veiw_story.dart';
import '../veiwPhoto/post_view.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
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

        var userModel = SocialCubit.get(context).userModel;
        var cubit = SocialCubit.get(context);
        SocialCubit.get(context)
            .getFriends(SocialCubit.get(context).userModel!.uId);
        return SocialCubit.get(context).posts.isEmpty
            ? Scaffold(
                backgroundColor:
                    cubit.isLight ? Colors.white : const Color(0xff4C5C68),
                body: Column(
                  children: [
                    Card(
                      color: SocialCubit.get(context).isLight
                          ? Colors.white
                          : const Color(0xff4C5C68),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                navigateTo(context, const MyProfileScreen());
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    NetworkImage('${userModel!.image}'),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: 220,
                                height: 50,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: TextButton(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.grey[300]),
                                  ),
                                  child: Text(
                                    '\' What\'s on your mind ? \'',
                                    style: GoogleFonts.amiri(
                                      fontSize: 16,
                                      color: SocialCubit.get(context).isLight
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    navigateTo(context, AddPostScreen());
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: 2,
                              height: 50,
                              color: Colors.grey,
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.getPostImage();
                                navigateTo(context, AddPostScreen());
                              },
                              icon: Icon(
                                Icons.photo_library_outlined,
                                size: 30,
                                color: cubit.isLight
                                    ? CupertinoColors.activeBlue
                                    : Colors.white,
                              ),
                              splashRadius: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
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
                    const Spacer(),
                  ],
                ))
            : ConditionalBuilder(
                condition: cubit.posts.isNotEmpty,
                builder: (BuildContext context) => RefreshIndicator(
                  onRefresh: () async {
                    cubit.getPosts();
                    return cubit.getUserData();
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    cubit.getStoryImage(context);
                                  },
                                  child: Container(
                                    width: 110,
                                    height: 190,
                                    margin: const EdgeInsetsDirectional.only(start: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(17)),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 153,
                                          child: Stack(
                                            alignment: AlignmentDirectional.bottomCenter,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional.topCenter,
                                                child: Container(
                                                  width: 110,
                                                  height: 135,
                                                  decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.only(
                                                        topRight: Radius.circular(17),
                                                        topLeft: Radius.circular(17),
                                                        bottomLeft: Radius.circular(10),
                                                        bottomRight: Radius.circular(10),
                                                      ),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              cubit.userModel!.image!),
                                                          fit: BoxFit.cover)),
                                                ),
                                              ),
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor:
                                                Colors.grey.withOpacity(0.3),
                                                child: const CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor: Colors.blue,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "Create Story",
                                          style: Theme.of(context).textTheme.subtitle2,
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 180,
                                  child: ListView.separated(
                                      physics: const NeverScrollableScrollPhysics(),
                                      reverse: true,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          StoryItem(context, cubit.stories[index]),
                                      separatorBuilder: (context, index) => const SizedBox(
                                        width: 10,
                                      ),
                                      itemCount: cubit.stories.length),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),

                        ),
                        Card(
                          color: SocialCubit.get(context).isLight
                              ? Colors.white
                              : const Color(0xff4C5C68),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 10,
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    navigateTo(
                                        context, const MyProfileScreen());
                                  },
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        NetworkImage('${userModel!.image}'),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 220,
                                    height: 50,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: TextButton(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.grey[300]),
                                      ),
                                      child: Text(
                                        'What\'s On Your Mind?',
                                        style: GoogleFonts.amiri(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              SocialCubit.get(context).isLight
                                                  ? Colors.black
                                                  : Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        navigateTo(context, AddPostScreen());
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 2,
                                  height: 50,
                                  color: Colors.grey,
                                ),
                                IconButton(
                                  onPressed: () {
                                    cubit.getPostImage();
                                    navigateTo(context, AddPostScreen());
                                  },
                                  icon: Icon(
                                    Icons.photo_library_outlined,
                                    size: 30,
                                    color: cubit.isLight
                                        ? CupertinoColors.activeBlue
                                        : Colors.white,
                                  ),
                                  splashRadius: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        space(0, 10),
                        ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cubit.posts.length,
                          separatorBuilder: (context, index) => space(0, 10),
                          itemBuilder: (context, index) => (buildPostItem(
                              cubit.posts[index], context, index)),
                        ),
                        space(0, 10),
                      ],
                    ),
                  ),
                ),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );
      },
    );
  }

  Widget buildPostItem(PostModel postModel, context, index) {
    late String postId;
    var cubit = SocialCubit.get(context);
    postId = SocialCubit.get(context).postsId[index];
    return Card(
      color: SocialCubit.get(context).isLight
          ? Colors.white
          : const Color(0xff4C5C68),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 7),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {

                    if (postModel.uId !=
                        SocialCubit.get(context).userModel!.uId) {
                      navigateTo(context, FriendsProfileScreen(postModel.uId));
                    } else {
                      navigateTo(context, const MyProfileScreen());
                    }

                  },
                  borderRadius: BorderRadius.circular(25),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      '${postModel.image}',
                    ),
                  ),
                ),
                space(15, 0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (postModel.uId !=
                                  SocialCubit.get(context).userModel!.uId) {
                                navigateTo(context, FriendsProfileScreen(postModel.uId));
                              } else {
                                navigateTo(context, const MyProfileScreen());
                              }
                            },
                            child: Text(
                              '${postModel.name}',
                              style: GoogleFonts.amiri(
                                fontSize: 20,
                                height: 1.3,
                                color: SocialCubit.get(context).isLight
                                    ? CupertinoColors.activeBlue
                                    : Colors.white,
                              ),
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
                      Row(
                        children: [
                          const Icon(
                            LineariconsFree.earth,
                            size: 20,
                            color: Colors.grey,
                          ),
                          space(10, 0),
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
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                color: Colors.grey[300],
                height: 2,
                width: double.infinity,
              ),
            ),
            Text(
              '${postModel.text}',
              style: GoogleFonts.b612(
                color: SocialCubit.get(context).isLight
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            space(0, 12),
            if (postModel.postImage != '')
              InkWell(
                onTap: () {
                  navigateTo(
                      context,
                      FullScreen(
                        postModel,
                        index: index,
                      ));
                },
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Container(
                        height: 320,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
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
                  onPressed: () {
                    // navigateTo(context, LikesScreen(SocialCubit.get(context).postsId[index],postModel.uId));
                  },
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
                  onPressed: () {
                    navigateTo(
                        context,
                        CommentsScreen(
                          SocialCubit.get(context).postsId[index],
                          postModel.uId,
                        ));
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
                    backgroundImage: NetworkImage('${SocialCubit.get(context).userModel!.image}'),
                  ),
                ),
                space(10, 0),
                InkWell(
                  onTap: () {
                    navigateTo(
                        context,
                        CommentsScreen(
                          SocialCubit.get(context).postsId[index],
                          postModel.uId,
                        ));
                  },
                  child: SizedBox(
                    width: 120,
                    child: Text(
                      'Write a comment..',
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

  Widget StoryItem(context, StoryModel model) {
    var bloc = SocialCubit.get(context).userModel;
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ViewStory(model)));
      },
      child: Container(
        width: 110,
        height: 180,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(17)),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(
                    image: NetworkImage(model.storyImage!),
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 23,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: model.uId == bloc!.uId
                          ? NetworkImage(bloc.image!)
                          : NetworkImage(model.image!),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 110,
                    height: 25,
                    child: Text(
                      model.uId == bloc.uId ? bloc.name! : model.name!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }



}
