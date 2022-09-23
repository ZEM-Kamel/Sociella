import 'package:sociella/Pages/on-boarding/on-boarding%20screen.dart';
import 'package:sociella/firebase_options.dart';
import 'package:sociella/layout/Home/home_layout.dart';
import 'package:sociella/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:sociella/shared/Cubit/socialCubit/SocialState.dart';
import 'package:sociella/shared/bloc_observer.dart';
import 'package:sociella/shared/components/components.dart';
import 'package:sociella/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'shared/components/constants.dart';
import 'shared/network/cache_helper.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{  showToast(text: 'Messaging Background', state: ToastStates.success);
  debugPrint('background');
  debugPrint(message.data.toString());

}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );  //when the app is opened
  FirebaseMessaging.onMessage.listen((event)
  {   showToast(text: 'on Message', state: ToastStates.success);
    debugPrint('when the app is opened');
    debugPrint(event.data.toString());

  });
  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  { showToast(text: 'on Message Opened App', state: ToastStates.success);
    debugPrint('when click on notification to open app');
    debugPrint(event.data.toString());

  });
  // background notification
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


  BlocOverrides.runZoned(
        () {},
    blocObserver: MyBlocObserver(),
  );
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget =  const HomeLayout();
  } else {
    widget = const OnBoard();
  }

  debugPrint(uId);
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final  Widget startWidget;
  final bool? isDark;

   const MyApp({Key? key, this.isDark, required this.startWidget})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPosts()
            ..getAllUsers()
            ..getStories()
              ..changeMode(fromShared: isDark,)
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: SocialCubit.get(context).isLight
                ? ThemeMode.light
                : ThemeMode.dark,
            home: SplashScreenView(
              duration: 3500,
              pageRouteTransition: PageRouteTransition.Normal,
              navigateRoute: startWidget,
              imageSize: 200,
              imageSrc: SocialCubit.get(context).isLight
                  ?'assets/images/sLight.png'
              :'assets/images/sDark.png',
              text: 'Sociella',
              textType: TextType.ColorizeAnimationText,
              textStyle: GoogleFonts.b612(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                letterSpacing: 10
              ),
              colors:  [
                SocialCubit.get(context).isLight
                    ? Colors.black
                    : Colors.white ,
                const Color(0xff2e6171),
                const Color(0xff556f7a),
                const Color(0xff798086),
              ],
              backgroundColor: SocialCubit.get(context).isLight
                  ?  Colors.white
                  : const Color(0xff4C5C68),
            ),
          );
        },
      ),
    );
  }
}
