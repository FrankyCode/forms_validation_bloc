import 'dart:convert';

import 'package:forms_validation/src/preferences_user/preferences_user.dart';
import 'package:http/http.dart' as http;

class UserProvider{

  final String _firebaseToken = 'AIzaSyA8FsQzqJDO_MXhSBnuIw-fHT6OrTUGKLk';
  final _prefs = new PreferenceUser();


  Future<Map<String, dynamic>> login(String email, String password) async{

    final authData = {
      'email' : email,
      'password' : password,
      'returnSecureToken' : true,
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode(authData)
    );


    Map<String, dynamic> decodeResp = json.decode(resp.body);

      print(decodeResp);

      if(decodeResp.containsKey('idToken')){
        //TODO: Save token storage
        _prefs.token = decodeResp['idToken'];
        return {'ok' : true, 'token': decodeResp['idToken']};
      } else {
        return {'ok' :false, 'sms': decodeResp['error']['message']};
      }
  }



  Future<Map<String, dynamic>> newUser(String email, String password) async{

      final authData = {
        'email' : email,
        'password' : password,
        'returnSecureToken' : true,        
      };

      final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken', 
        body: json.encode(authData)

        );

      Map<String, dynamic> decodeResp = json.decode(resp.body);
      print(decodeResp);
      if(decodeResp.containsKey('idToken')){
        _prefs.token = decodeResp['idToken'];

        return {'ok' : true, 'token': decodeResp['idToken']};
      } else {
        return {'ok' :false, 'sms': decodeResp['error']['message']};
      }

  }

}