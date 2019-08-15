import 'package:flutter/material.dart';
import 'package:forms_validation/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body:Container(),
      floatingActionButton: _createButton(context),
    );
  }

  Widget _createButton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'product'),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
