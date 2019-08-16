import 'package:flutter/material.dart';
import 'package:forms_validation/src/bloc/provider.dart';
import 'package:forms_validation/src/pages/home_page.dart';
import 'package:forms_validation/src/pages/login_page.dart';
import 'package:forms_validation/src/pages/product_page.dart';
import 'package:forms_validation/src/pages/register_page.dart';
import 'package:forms_validation/src/preferences_user/preferences_user.dart';
import 'package:forms_validation/src/utils/theme.dart';

void main() async {
  final prefs = new PreferenceUser();
  await prefs.initPrefs();

  runApp(MyApp());
  
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login'   : (BuildContext context) => LoginPage(),
          'home'    : (BuildContext context) => HomePage(),
          'register': (BuildContext context) => RegisterPage(),
          'product' : (BuildContext context) => ProductPage(),
        },
        theme: basicTheme(),
      ),
    );
  }
}
