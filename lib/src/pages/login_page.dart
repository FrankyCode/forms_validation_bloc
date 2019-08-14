import 'package:flutter/material.dart';
import 'package:forms_validation/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.of(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground(size),
          _loginForm(size, bloc),
        ],
      ),
    );
  }

  Widget _createBackground(size) {
    final purpleBackground = Container(
      height: size.height * 0.4, // 40% of Screen
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0)
      ])),
    );

    final circle = Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        purpleBackground,
        Positioned(
          top: 90.0,
          left: 30.0,
          child: circle,
        ),
        Positioned(
          top: -40.0,
          right: -50.0,
          child: circle,
        ),
        Positioned(
          bottom: 10.0,
          right: -10.0,
          child: circle,
        ),
        Positioned(
          bottom: 130.0,
          right: 80.0,
          child: circle,
        ),
        Positioned(
          bottom: -50.0,
          right: 130.0,
          child: circle,
        ),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.person_pin_circle,
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text('Dummy User Text', style: TextStyle(color: Colors.white))
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(size, bloc) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Log In',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 60.0),
                _createEmail(bloc),
                SizedBox(height: 30.0),
                _createPassword(bloc),
                SizedBox(height: 30.0),
                _createButton(),
              ],
            ),
          ),
          Text('Did you forget your password?'),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.alternate_email,
                    color: Colors.deepPurple,
                  ),
                  hintText: 'example@email.com',
                  labelText: 'Email',
                  counterText: snapshot.data),
              onChanged: bloc.changeEmail,
            ),
          );
        });
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock_outline,
                    color: Colors.deepPurple,
                  ),
                  hintText: '123456',
                  labelText: 'Password',
                  counterText: snapshot.data),
              onChanged: bloc.changePassword,
            ),
          );
        });
  }

  Widget _createButton() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 30.0),
        child: Text('Log In'),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0.0,
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: () {},
    );
  }
}
