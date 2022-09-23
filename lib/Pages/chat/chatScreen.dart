import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:sociella/Pages/chat/private_chat.dart';
import 'package:sociella/model/user_model.dart';
import 'package:sociella/shared/Cubit/socialCubit/SocialState.dart';
import 'package:sociella/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/Cubit/socialCubit/SocialCubit.dart';
import '../../shared/components/constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return SocialCubit.get(context).users.isEmpty? Scaffold(
          backgroundColor:
          cubit.isLight ? Colors.white : const Color(0xff4C5C68),

          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children :
              const [
                Icon(
                  IconlyLight.chat,
                  size: 70,
                  color: Colors.grey,
                ),
                Center(
                  child: Text(
                    'No Users Yet,\nPlease Add\nSome Friends ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ]
            ),
          ),
        ):

          SingleChildScrollView(
          child: ConditionalBuilder(
              condition: cubit.users.isNotEmpty,
              builder: (BuildContext context) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        color:cubit.isLight? Colors.grey[300] : const Color(0xff4C5C68).withOpacity(0.7),
                        child: Container(
                            height: 125.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  buildStoryItem(cubit.users[index], context),
                              separatorBuilder: (context, index) => space(5, 0),
                              itemCount: cubit.users.length,
                            )),
                      ),
                      ListView.separated(
                        padding:  const EdgeInsets.all(20.0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildUsersItem(cubit.users[index], context),
                        separatorBuilder: (context, index) =>
                            myDivider(Colors.grey.withOpacity(0.3)),
                        itemCount: cubit.users.length,
                      ),
                    ],
                  ),
              fallback: (BuildContext context) =>
                  const Center(child: CircularProgressIndicator())),
        );
      },
    );
  }

  Widget buildUsersItem(UserModel users, context) {

    return InkWell(
      onTap: () {
        navigateTo(context, PrivateChatScreen(userModel: users));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                '${users.image}',
              ),
            ),
            space(15, 0),
            Expanded(
              child: Text(
                '${users.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.amiri(
                  fontSize: 20,
                  color: SocialCubit.get(context).isLight
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
            space(10, 0),
            OutlinedButton.icon(
              onPressed: () {
                navigateTo(context, PrivateChatScreen(userModel: users));
              },
              label: Text(
                'Message',
                style: GoogleFonts.amiri(
                  fontSize: 15,
                  height: 1.3,
                  color: SocialCubit.get(context).isLight
                      ? CupertinoColors.activeBlue
                      : Colors.white,
                ),
              ),
              icon: const Icon(
                IconlyLight.chat,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildStoryItem(UserModel users, context) => InkWell(
        onTap: () {
          navigateTo(context, PrivateChatScreen(userModel: users));
        },
        child: Container(
          margin: const EdgeInsetsDirectional.all(1),
            width: 60.0,
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      radius: 23.0,
                      backgroundImage: NetworkImage(
                        '${users.image}',
                      ),
                    ),
                    const CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 5.0,
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
                space(0, 10),
                Text(
                  '${users.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.amiri(
                    fontSize: 18,
                    color: SocialCubit.get(context).isLight
                        ? Colors.black
                        : Colors.white,
                  ),
                )
              ],
            )),
      );
}
