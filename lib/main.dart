import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:growth/constants/app_constant.dart';
import 'package:growth/screens/details/detail_screen.dart';
import 'package:growth/screens/login_screen.dart';
import 'package:growth/screens/registers/registers_screen.dart';
import 'package:growth/view_models/call_list_view_model.dart';
import 'package:growth/view_models/user_view_model.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

import 'cache/locale_manager.dart';
import 'deneme/globals.dart' as globals;
import 'locator.dart';

void main() async {
  globals.appNavigator = GlobalKey<NavigatorState>();
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.prefrencesInit();
  var token = LocaleManager.instance.getStringValue("token");
  runApp(
    MyApp(token: token),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.token}) : super(key: key);
  final token;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId(ApplicationConstants.oneSignalKey);
    OneSignal.shared.setNotificationOpenedHandler((openedResult) {
      var data = openedResult.notification.additionalData;
      if (data != null) {
        if (data['type'] == 'register' || data['type'] == 'lead') {
          if (data["license_id"] != null) {
            globals.appNavigator!.currentState?.push(
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  id: int.parse(data["license_id"]!.toString()),
                ),
              ),
            );
          }
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(create: (context) => UserModel()),
        ListenableProvider<CallModel>(create: (context) => CallModel()),
      ],
      child: Consumer<UserModel>(
        builder: (ctx, user, _) => MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('tr', 'TR'),
          ],
          navigatorKey: globals.appNavigator,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: ApplicationConstants.mor,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: widget.token == ''
              ? const LoginScreen()
              : const RegistersScreen(),
          //SplashScreen()
        ),
      ),
    );
  }
}
