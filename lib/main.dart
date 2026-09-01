import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/providers/news_provider.dart';
import 'package:gokceada/services/google_ads.dart';
import 'package:gokceada/pages/login_register_page.dart';
import 'package:gokceada/screens/barlarMap.dart';
import 'package:gokceada/screens/cafelerMap.dart';
import 'package:gokceada/screens/campingMap.dart';
import 'package:gokceada/screens/navBar/bus.dart';
import 'package:gokceada/screens/navBar/fery.dart';
import 'package:gokceada/screens/hediyelikMap.dart';
import 'package:gokceada/screens/hotelsMap.dart';
import 'package:gokceada/screens/kahvaltiMap.dart';
import 'package:gokceada/screens/navBar/activitiesMap.dart';
import 'package:gokceada/screens/navBar/atmList.dart';
import 'package:gokceada/screens/navBar/gezilecekMap.dart';
import 'package:gokceada/screens/navBar/iletisim.dart';
import 'package:gokceada/screens/navBar/koyler.dart';
import 'package:gokceada/screens/navBar/nerdeyenirview.dart';
import 'package:gokceada/pages/users_console.dart';
import 'package:gokceada/pages/home_page.dart';
import 'package:gokceada/screens/navBar/tavsiyeler.dart';
import 'package:gokceada/screens/pansionMaps.dart';
import 'package:gokceada/screens/plajlar.dart';
import 'package:gokceada/screens/restaurantsMap.dart';
import 'package:gokceada/screens/splash_screen.dart';
import 'package:gokceada/screens/surfingMap.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(
      EasyLocalization(
          supportedLocales: const [Locale('en', 'US'),Locale('en', 'UK'), Locale('tr', 'TR'),Locale('bg', 'BG'),Locale('el', 'GR'),Locale('ro', 'RO')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: const Gokceada()
      ),
      );
}

class Gokceada extends StatefulWidget {
  const Gokceada({super.key});

  @override
  State<Gokceada> createState() => _GokceadaState();
}

class _GokceadaState extends State<Gokceada> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleAds()),
        ChangeNotifierProvider(create: (_) => NewsProvider()..load()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(),
        title: 'Gokceada',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/atm': (context) =>  const AtmList(),
        '/pansionList': (context) => const PansionDetay(),
        '/advices': (context) => const Advices(),
        '/cafe': (context) => const CafeDetay(),
        '/iletisim': (context) => const Iletisim(),
        '/restaurantsView': (context) => const RestaurantDetay(),
        '/kahvalti': (context) => const BreakfastDetay(),
        '/hediyelik': (context) => const HediyelikDetay(),
        '/bar': (context) => const BarDetay(),
        '/plajlar': (context) => const PlajlarView(),
        '/gezilecek': (context) => const GezilecekDetay(),
        '/activities': (context) => const ActivitiesDetay(),
        '/foodareas': (context) => const NerdeYenirView(),
        '/login': (context) => const LoginPage(),
        '/fery': (context) => const Feribot(),
        '/villages': (context) => const Koyler(),
        '/usersConsole': (context) => const UsersConsole(),
        '/homepage': (context) => const HomePage(),
        '/koyler': (context) => const Koyler(),
        '/oteller': (context) =>  const OtelDetay(),
        '/camping': (context) =>  const CampingDetay(),
        '/surfing': (context) =>  const SurfingDetay(),
          '/bus': (context) => const BusTimes(),
        },
      ),
    );
  }
}

/// The app-wide Material 3 theme, derived from [ColorConstants]. Establishes an
/// Aegean colour scheme, a salt-white ground, flat salt app bars, and softly
/// rounded cards so individual screens no longer need to restyle these.
ThemeData _buildTheme() {
  final c = ColorConstants.instance;
  final scheme = ColorScheme.fromSeed(
    seedColor: c.sea,
    primary: c.sea,
    onPrimary: Colors.white,
    secondary: c.coral,
    onSecondary: Colors.white,
    tertiary: c.olive,
    onTertiary: Colors.white,
    surface: c.shell,
    onSurface: c.ink,
    brightness: Brightness.light,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: c.salt,
    dividerColor: c.lightGreyCardCollor,
    appBarTheme: AppBarTheme(
      backgroundColor: c.salt,
      foregroundColor: c.sea,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: c.sea),
      titleTextStyle: TextFonts.instance.appBarTitleColor,
    ),
    // Soft, diffuse card shadow (approx. blurRadius 12 / opacity 0.06).
    cardTheme: CardThemeData(
      color: c.shell,
      elevation: 3,
      shadowColor: c.ink.withValues(alpha: 0.10),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: c.commentColor),
    ),
  );
}

