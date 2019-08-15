import 'dart:async';

import 'package:forms_validation/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{

  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  

  // GET and SET
  // Recovery data for Stream
  Stream<String>  get passwordStream => _passwordController.stream.transform(validatePassword);
  Stream<String>  get emailStream    => _emailController.stream.transform(validateEmail);
  Stream<bool>    get formValidStream=> Observable.combineLatest2(emailStream, passwordStream, (e,p)=> true);

   // Insert valus of Stream
  Function (String) get changeEmail     => _emailController.sink.add;
  Function (String) get changePassword  => _passwordController.sink.add;

  // Get the last value used
  String get email    => _emailController.value;
  String get password => _passwordController.value;


  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }

}