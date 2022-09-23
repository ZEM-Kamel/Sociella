
import 'package:sociella/Pages/friend/profileScreen.dart';
import 'package:sociella/Pages/profile/My_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/user_model.dart';
import '../../shared/Cubit/socialCubit/SocialCubit.dart';
import '../../shared/Cubit/socialCubit/SocialState.dart';
import '../../shared/components/components.dart';

class FriendsScreen extends StatelessWidget {
  bool? myFreinds = false;
  List<UserModel>? friends;
  FriendsScreen(this.friends,{Key? key, this.myFreinds}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context){
      return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){
          List<UserModel>? friends = this.friends;
          var cubit = SocialCubit.get(context);
           return SocialCubit.get(context).friends.isEmpty ?  Scaffold(
             extendBodyBehindAppBar: true,
             backgroundColor:
             cubit.isLight ? Colors.white : const Color(0xff4C5C68),
             appBar: AppBar(
               systemOverlayStyle: SystemUiOverlayStyle(
                 statusBarColor: Colors.transparent,
                 statusBarIconBrightness:
                 cubit.isLight ? Brightness.dark : Brightness.light,
                 statusBarBrightness:
                 cubit.isLight ? Brightness.dark : Brightness.light,
               ),
               backgroundColor:
               cubit.isLight ? Colors.white : const Color(0xff4C5C68),
               elevation: 1,
               leading: IconButton(
                 onPressed: () {
                   pop(context);
                 },
                 icon: Icon(
                   Icons.arrow_back,
                   color: cubit.isLight ? Colors.black : Colors.white,
                 ),
               ),
               titleSpacing: 1,
               title: Text(
                 'Friends',
                 style: GoogleFonts.amiri(
                   textStyle: TextStyle(
                     color: cubit.isLight ? Colors.black : Colors.white,
                     fontSize: 20,
                     fontWeight: FontWeight.w600,
                   ),
                 ),
               ),
             ),
             body: Center(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisSize: MainAxisSize.min,
                 children:
                 [
                   const Icon(
                     IconlyLight.infoSquare,
                     size: 100,
                     color: Colors.grey,
                   ),
                   Text(
                     'No Friends yet',
                     style: GoogleFonts.b612(
                       fontWeight: FontWeight.w700,
                       fontSize: 30,
                       color: Colors.grey,
                     ),
                   ),
                 ],
               ),
             ),
           ) :

          Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor:
              cubit.isLight ? Colors.white : const Color(0xff4C5C68),
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness:
                  cubit.isLight ? Brightness.dark : Brightness.light,
                  statusBarBrightness:
                  cubit.isLight ? Brightness.dark : Brightness.light,
                ),
                backgroundColor:
                cubit.isLight ? Colors.white : const Color(0xff4C5C68),
                elevation: 1,
                leading: IconButton(
                  onPressed: () {
                    pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: cubit.isLight ? Colors.black : Colors.white,
                  ),
                ),
                titleSpacing: 1,
                title: Text(
                  'Friends',
                  style: GoogleFonts.amiri(
                    textStyle: TextStyle(
                      color: cubit.isLight ? Colors.black : Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              body: //state is GetFriendLoadingState
              friends!.isEmpty ?
              const Center(child: CircularProgressIndicator(),) : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => chatBuildItem(context,friends[index],myFreinds ?? false),
                separatorBuilder:(context,index) =>const SizedBox(height: 0,),
                itemCount:friends.length,
              )
          );
        },
      );
    });
  }

}
Widget chatBuildItem (context,UserModel model,bool myFriends) {
  var cubit = SocialCubit.get(context);
  return InkWell(
    onTap: (){
      if (SocialCubit.get(context).userModel!.uId == model.uId) {
        navigateTo(context, const MyProfileScreen());
      } else {
        navigateTo(context, FriendsProfileScreen(model.uId));
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage:NetworkImage('${model.image}'),
            radius: 35,
          ),
          const SizedBox(width: 10,),
          Text('${model.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.b612(
              textStyle: TextStyle(
                color: cubit.isLight ? Colors.black : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),
          if(myFriends)
            PopupMenuButton(
              color: cubit.isLight ? Colors.black : Colors.white,
              onSelected: (value){
                if(value == 'Unfriend') {
                  SocialCubit.get(context).unFriend(model.uId);
                }
              },
              child: Icon(IconlyLight.moreSquare,color: cubit.isLight ? Colors.black : Colors.white,),
              itemBuilder: (context) => [
                PopupMenuItem(
                    height: 40,
                    value:'Unfriend',
                    child: Row(children: [
                      Icon(IconlyLight.delete,color: cubit.isLight ? Colors.white : Colors.black),
                      const SizedBox(width: 15,),
                      Text('Unfriend',    style: GoogleFonts.b612(
                        textStyle: TextStyle(
                          color: cubit.isLight ? Colors.white : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),),
                    ],))
              ],
            ),
        ],
      ),
    ),
  );
}
