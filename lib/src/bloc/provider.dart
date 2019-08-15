import 'package:flutter/material.dart';
import 'package:forms_validation/src/bloc/login_bloc.dart';
export 'package:forms_validation/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {

  static Provider _instance;
  factory Provider({Key key, Widget child}){
    if (_instance == null){
      _instance = new Provider._internal(key: key,child: child,);
    }

    return _instance;
  }

  final loginBloc = LoginBloc();

  Provider._internal({Key key, Widget child}):super(key: key,child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).loginBloc;
  }
}
