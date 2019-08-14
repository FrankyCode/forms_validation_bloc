import 'dart:async';

class LoginBloc{

  final _emailController    = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  // GET and SET
  // Insert valus of Stream
  Function (String) get changeEmail     => _emailController.sink.add;
  Function (String) get changePassword  => _passwordController.sink.add;

  // Recovery data for Stream
  Stream<String>  get passwordStream => _passwordController.stream;
  Stream<String>  get emailStream    => _emailController.stream;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }

}