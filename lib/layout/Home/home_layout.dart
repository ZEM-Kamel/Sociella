import 'package:badges/badges.dart';
import 'package:sociella/Pages/notifications/notifications_screen.dart';
import 'package:sociella/Pages/search/search_screen.dart';
import 'package:sociella/model/drawerModel.dart';
import 'package:sociella/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:sociella/shared/Cubit/socialCubit/SocialState.dart';
import 'package:sociella/shared/components/components.dart';
import 'package:sociella/shared/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import '../drawer/drawerItem.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerController = ZoomDrawerController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                      ),             space(0, 20),
                      TextButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                cubit.isLight ? Colors.blue : Colors.white)),
                        onPressed: () {
                          SocialCubit.get(context)..getUserData()..getAllUsers()..getPosts();
                        },
                        icon: Icon(
                          IconlyLight.upload,
                          color: cubit.isLight ? Colors.white : Colors.blue,
                        ),
                        label: Text(
                          'Reload',
                          style: GoogleFonts.b612(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                            color: cubit.isLight ? Colors.white : Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                ))
            : ZoomDrawer(
                openCurve: Curves.easeInOut,
                closeCurve: Curves.easeOut,
                mainScreenTapClose: true,
                menuScreenTapClose: true,
                controller: drawerController,
                borderRadius: 50.0,
                dragOffset: 10.0,
                slideWidth: 290.0,
                menuScreen: Builder(builder: (context) {
                  return MenuScreen(
                    currentItem: cubit.currentItem,
                    onSelectedItem: (item) {
                      cubit.changeItem(item, context);
                      ZoomDrawer.of(context)!.toggle();
                    },
                  );
                }),
                mainScreen: cubit.mScreen,
                showShadow: true,
                menuBackgroundColor: cubit.isLight
                    ? const Color(0xff4C5C68)
                    : Colors.white.withOpacity(0.7),
                drawerShadowsBackgroundColor:
                    cubit.isLight ? Colors.grey.shade400 : Colors.blue.shade200,
                reverseDuration: const Duration(seconds: 1),
                angle: -6,
                duration: const Duration(seconds: 1),
              );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  int initialIndex = 0;
  MainScreen(this.initialIndex, {Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  static late TabController tabController;
  late int initialIndex;

  @override
  void initState() {
    initialIndex = widget.initialIndex;
    tabController = TabController(length: 5, vsync: this);
    tabController.index = initialIndex;
    tabController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return DefaultTabController(
          length: cubit.screens.length,
          initialIndex: cubit.currentIndex,
          child: Scaffold(
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
              elevation: 5,
              /*leading: IconButton(
                onPressed: () {
                  ZoomDrawer.of(context)!.toggle();
                },
                icon: Icon(
                  Icons.menu,
                  color: cubit.isLight ? const Color(0xff4C5C68) : Colors.white,
                ),
              ),*/
              titleSpacing: 10.0,
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: GoogleFonts.amiri(
                  color: cubit.isLight ? Colors.blue : Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(context, const SearchScreen());
                  },
                  splashColor: Colors.blue,
                  splashRadius: 20,
                  icon: Icon(
                    IconlyBroken.search,
                    color: cubit.isLight ? Colors.black : Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    cubit.getInAppNotification();
                    navigateTo(context, const NotificationScreen());
                  },
                  splashColor: Colors.blue,
                  splashRadius: 20,
                  icon: SocialCubit.get(context).unReadNotificationsCount != 0
                      ? tabBarBadge(
                          icon: IconlyBroken.notification,
                          count:
                              SocialCubit.get(context).unReadNotificationsCount)
                      : Icon(
                          IconlyBroken.notification,
                          color: cubit.isLight ? Colors.black : Colors.white,
                        ),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40.0),
                child: TabBar(
                  controller: tabController,
                  onTap: (index) {
                    changeTabBar(cubit, index, context);
                  },
                  indicatorWeight: 4.0,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                  splashFactory: InkSplash.splashFactory,
                  isScrollable: true,
                  indicatorColor: cubit.isLight ? Colors.blue : Colors.white,
                  labelColor: cubit.isLight ? Colors.blue : Colors.white,
                  unselectedLabelColor:
                      cubit.isLight ? Colors.black26 : const Color(0xff090446),
                  tabs: tabs(context),
                ),
              ),
            ),
            body: TabBarView(
                physics: const RangeMaintainingScrollPhysics(),
                controller: tabController,
                children: SocialCubit.get(context).screens),
          ),
        );
      },
    );
  }

  ///START : Tabs
  List<Widget> tabs(context) {
    return [
      const Tab(
        icon: Icon(
          IconlyBroken.home,
          size: 25,
        ),
      ),
      const Tab(
        icon: Icon(
          IconlyBroken.activity,
          size: 25,
        ),
      ),
      Tab(
        icon: SocialCubit.get(context).friendRequests.isNotEmpty
            ? tabBarBadge(
                icon: IconlyLight.addUser,
                count: SocialCubit.get(context).friendRequests.length)
            : const Icon(
                IconlyLight.addUser,
          size: 25,
              ),
      ),
      const Tab(
        icon: Icon(
          IconlyBroken.discovery,
          size: 25,
        ),
      ),
      const Tab(
        icon: Icon(
          IconlyBroken.setting,
          size: 25,
        ),
      ),
    ];
  }

  ///END : Tabs

  Widget tabBarBadge({required IconData icon, required int count}) {
    return Badge(
      badgeContent: Text('$count'),
      animationType: BadgeAnimationType.scale,
      child: Icon(icon),
    );
  }

  void changeTabBar(SocialCubit cubit, int index, BuildContext context) {
    cubit.changeTabBar(index, context);
  }
}

class MenuScreen extends StatelessWidget {
  final Items currentItem;
  final ValueChanged<Items> onSelectedItem;

  const MenuScreen(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var userModel = SocialCubit.get(context).userModel!;
        return SocialCubit.get(context).userModel == null
            ? Scaffold(
                backgroundColor:
                    cubit.isLight ? Colors.white : const Color(0xff4C5C68),
                body: Column(
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
                  ],
                ))
            : SafeArea(
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  extendBody: true,
                  backgroundColor:
                      cubit.isLight ? Colors.white : const Color(0xff4C5C68),
                  body: Column(
                    children: [
                      SizedBox(
                        height: 240,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage('${userModel.cover}'),
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    )),
                                width: double.infinity,
                                height: 200,
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
                              right: 5,
                              child: IconButton(
                                onPressed: () {
                                  ZoomDrawer.of(context)!.close();
                                },
                                icon: const CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: Icon(
                                    IconlyLight.arrowRight2,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${userModel.name}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.amiri(
                            fontSize: 30,
                            color: cubit.isLight ? Colors.black : Colors.white),
                      ),
                      myDivider(Colors.grey),
                      space(0, 15),
                      ...MenuItems.all.map(buildMenuItem).toList(),
                      const Spacer(
                        flex: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 130,
                              child: FlutterSwitch(
                                duration: const Duration(milliseconds: 500),
                                width: 120.0,
                                height: 45.0,
                                toggleSize: 40.0,
                                value: cubit.isLight,
                                borderRadius: 30.0,
                                activeToggleColor: Colors.blue,
                                inactiveToggleColor: Colors.grey,
                                activeSwitchBorder: Border.all(
                                  color: const Color(0xFFD1D5DA),
                                  width: 3.0,
                                ),
                                inactiveSwitchBorder: Border.all(
                                  color: const Color(0xFF31125E),
                                  width: 3.0,
                                ),
                                activeColor: Colors.white,
                                inactiveColor: const Color(0xFF0C0224),
                                activeIcon: const Icon(
                                  Icons.wb_sunny,
                                  color: Color(0xFFFFDF5D),
                                ),
                                inactiveIcon: const Icon(
                                  Icons.nightlight_round,
                                  color: Color(0xFFF8E3A1),
                                ),
                                onToggle: (val) {
                                  cubit.changeMode();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      space(0, 10),
                      InkWell(
                        onTap: () {
                          logOut(context);
                          FirebaseAuth.instance.signOut();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Icon(Icons.power_settings_new_rounded,
                                  size: 30,
                                  color: cubit.isLight
                                      ? Colors.black
                                      : Colors.white),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Logout',
                                style: GoogleFonts.amiri(
                                    fontSize: 30,
                                    color: cubit.isLight
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget buildMenuItem(Items item) => BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return SocialCubit.get(context).userModel == null
              ? Center(
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
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListTile(
                    selected: currentItem == item,
                    selectedTileColor:
                        cubit.isLight ? Colors.white : Colors.black,
                    minLeadingWidth: 10,
                    leading: Icon(
                      item.icon,
                      color: cubit.isLight ? Colors.black : Colors.white,
                      size: 26,
                    ),
                    title: Text(
                      item.title,
                      style: GoogleFonts.amiri(
                        fontSize: 26,
                        color: cubit.isLight ? Colors.black : Colors.white,
                      ),
                    ),
                    onTap: () {
                      onSelectedItem(item);
                    },
                  ),
                );
        },
      );
}
