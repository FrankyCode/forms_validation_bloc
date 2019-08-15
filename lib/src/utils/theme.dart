import 'package:flutter/material.dart';

ThemeData basicTheme(){
  TextTheme _basicTextTheme(TextTheme base){
    return base.copyWith(
      headline: base.headline.copyWith(
        fontFamily: 'Montserrat',
        fontSize: 22.0,
        color: Colors.white
      ),
      title: base.title.copyWith(
        fontFamily: 'Montserrat',
        fontSize: 15.0,
        color: Colors.white
      ),
      button: base.button.copyWith(
        fontFamily: 'Montserrat',
        fontSize: 12.0,
        color: Colors.white,

        
      )
    );
  }

 final ThemeData base = ThemeData();
 return base.copyWith(
   textTheme: _basicTextTheme(base.textTheme),
   iconTheme: IconThemeData(color: Colors.white, size: 20),
   primaryColor: Colors.deepPurple,
 );

}
  
 