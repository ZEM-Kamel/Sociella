import 'package:flutter_iconly/flutter_iconly.dart';
import '../../model/drawerModel.dart';

class MenuItems {
  static final profile = Items(title: 'Profile', icon: IconlyBroken.user2);
  static final notifications = Items(title: 'Notifications', icon: IconlyBroken.notification);
  static final savedPost = Items(title: 'Saved Post', icon: IconlyBroken.bookmark);
  static final restPassword = Items(title: 'Rest Password', icon: IconlyBroken.password);




  static List<Items> all = [
    profile,
    notifications,
    savedPost,
    restPassword,

  ];
}