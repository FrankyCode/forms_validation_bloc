import 'package:flutter/material.dart';
import 'package:forms_validation/src/bloc/login_bloc.dart';
export 'package:forms_validation/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {
  final loginBloc = LoginBloc();

  Provider({Key key, Widget child}):super(key: key,child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).loginBloc;
  }
}
