import 'package:first_login/Page/API_Display.dart';
import 'package:first_login/Page/API_data.dart';
import 'package:first_login/Page/Animationpart.dart';
import 'package:first_login/Page/CommonSearch.dart';
import 'package:first_login/Page/FormPreview.dart';
import 'package:first_login/Page/MainContent.dart';
import 'package:first_login/Page/MyPDFPage.dart';
import 'package:first_login/Page/OrderZomato.dart';
import 'package:first_login/Page/PdfExamplePage.dart';
import 'package:first_login/Page/PdfFromWidgetPage.dart';
import 'package:first_login/Page/PdfPreviewPage.dart';

import 'package:first_login/Page/ProfileAnimation.dart';

import 'package:first_login/Page/ProfileCard.dart';
import 'package:first_login/Page/Review.dart';
import 'package:first_login/Page/ScreenPage.dart';
import 'package:first_login/Page/Search.dart';

import 'package:first_login/Page/Sign_up_Api.dart';
import 'package:first_login/Page/SplashScreen.dart';
import 'package:first_login/Page/TableAPI.dart';
import 'package:first_login/Page/ZomatoProfile.dart';
import 'package:first_login/Page/api_fetching.dart';
import 'package:first_login/Page/forget.dart';
import 'package:first_login/Page/home.dart';
import 'package:first_login/Page/login_firstpage.dart';
import 'package:first_login/Page/login_second.dart';
import 'package:first_login/Page/register.dart';
import 'package:first_login/Page/sprung.dart';
import 'package:first_login/RestaurantPage/pizza1.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,

    onGenerateRoute: (RouteSettings settings) {
      if (settings.name == 'restaurant') {
        final restaurant = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (context) => Pizza1(restaurant: restaurant),
        );
      }
    },

      initialRoute: 'search',
      routes: {
        'search':(context) => Search(),
        'login': (context) => LoginSecond(),
        'register': (context) => Register(),
        'home': (context) => Home(),
        'firstPage': (context) => LoginFirstpageirstPage(),
        'forget': (context) => Forget(),
        'pageView': (context) => PageView(),
        'screenPage': (context) => Screenpage(),
        'splashScreen': (context) => Splashscreen(),
        'profilCard': (context) => ProfileCardApp(),
        'profileAnimation': (context) => ProfileCardAppAnimation(),
        'zoomble': (context) => Animationpart(),
        'sprung': (context) => Sprung(),
        'table' :(context) => TableAPI(),
        'apiData' : (context) => ApiData(),
        'apiDisplay':(context) =>ApiDisplay(), //not actual Pagination
        'order':(context) =>Orderzomato(),    //Zomato profile page
        'profileZomato':(context) =>Zomatoprofile(), //Zomato profile Page
        'content':(context) => Maincontent(),
        'commonSearch':(context) => Commonsearch(),//actual Pagination
        'formpreview':(context)=> Formpreview(),   //Quotation Summary
        'review':(context) => Review(), //
        'MyPDFPage':(content) =>MyPDFPage(),   //not a pdf ony example ,main page is Pdfcustom
        'PdfExamplePage':(content)=>PdfExamplePage(), //not a pdf
        'PdfPreviewPage':(content)=>PdfPreviewPage(), //not a pdf
        'PdfFromWidgetPage':(content)=>PdfFromWidgetPage() //not a pdf
     //   'restaurant':(context) => Pizza1()
        //  home:LoginFirstpageirstPage(),
        //  home: Register()
        //  home:Menu()
        // home: Newhttp()
        // home: ApiFetching(),
        //  home: ApiData(),
        //   home: SignUpApi(),
        // home: Home(),
      }
    );
  }
}