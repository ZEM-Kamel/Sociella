// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:sociella/shared/components/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../model/likesModel.dart';
// import '../../shared/Cubit/socialCubit/SocialCubit.dart';
// import '../../shared/Cubit/socialCubit/SocialState.dart';
// import '../../shared/components/constants.dart';
//
// class LikesScreen extends StatelessWidget {
//    final String? postId;
//    final String? receiverUid;
//    LikesScreen(this.postId,  this.receiverUid, {Key? key, }) : super(key: key);
//    var formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     SocialCubit cubit = SocialCubit.get(context);
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Likes'),
//           titleSpacing: 0,
//           elevation: 8,
//         ),
//         body: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('posts')
//                 .doc(postId)
//                 .collection('likes')
//                 .orderBy('dateTime', descending: true)
//                 .snapshots(),
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (!snapshot.hasData) {
//                 return const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.red,
//                   ),
//                 );
//               } else {
//                 cubit.peopleReacted = [];
//                 snapshot.data.docs.forEach((element) {
//                   cubit.peopleReacted
//                       .add(LikesModel.fromJson(element.data()));
//                 });
//                 return ConditionalBuilder(
//                   condition: snapshot.hasData == true &&
//                       cubit.peopleReacted.isNotEmpty == true,
//                   builder: (BuildContext context) => Column(
//                     children: [
//                       Expanded(
//                         child: ListView.separated(
//                             physics: const BouncingScrollPhysics(),
//                             reverse: false,
//                             itemBuilder: (context, index) {
//                            return   userLikeItem(
//                                   context, cubit.peopleReacted[index]);
//                             },
//                             separatorBuilder: (context, index) =>
//                                 SizedBox(
//                                   height: 0,
//                                 ),
//                             itemCount: cubit.peopleReacted.length),
//                       ),
//                     ],
//                   ),
//                   fallback: (BuildContext context) =>
//                       CircularProgressIndicator(),
//                 );
//               }
//             }));
//   }
//
//   Widget userLikeItem(context, LikesModel like) {
//         return Padding(
//           padding: const EdgeInsets.all(15),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: NetworkImage('${like.image}'),
//                 radius: 20,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 '${like.name}',
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               // Spacer(),
//               // if (SocialCubit.get(context).peopleReacted.uId != like.uId)
//               //   Container(
//               //     width: 120,
//               //     child: ElevatedButton(
//               //       style: ButtonStyle(
//               //           backgroundColor:
//               //               MaterialStateProperty.all(Colors.white)),
//               //       onPressed: () {
//               //         // SocialCubit.get(context).addFriend(
//               //         //     friendName: like.name,
//               //         //     friendProfilePic: like.profilePicture,
//               //         //     friendsUid: like.uId
//               //         // );
//               //         // SocialCubit.get(context).getFriends(like.uId);
//               //       },
//               //       child: Row(
//               //         mainAxisAlignment: MainAxisAlignment.center,
//               //         children: [
//               //           Icon(
//               //             Icons.person_add_alt_1_rounded,
//               //             size: 15,
//               //           ),
//               //           SizedBox(
//               //             width: 5,
//               //           ),
//               //           Text('LocaleKeys.addFriend.tr()',
//               //               style:
//               //                   TextStyle(color: Colors.white, fontSize: 12)),
//               //         ],
//               //       ),
//               //     ),
//               //   )
//             ],
//           ),
//         );
//   }
// }
