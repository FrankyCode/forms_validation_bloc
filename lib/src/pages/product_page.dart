import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forms_validation/src/bloc/provider.dart';
import 'package:forms_validation/src/model/product_model.dart';

import 'package:forms_validation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductBloc productBloc;
  ProductModel produc = new ProductModel();
  bool _saving = false;
  File photo;

  @override
  Widget build(BuildContext context) {
    
    productBloc = Provider.productsBloc(context);
    final ProductModel prodData = ModalRoute.of(context).settings.arguments;
    if(prodData != null){
      produc = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _selecPhoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _takePhoto,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _showPhoto(),
                _createName(),
                _createPrice(),
                _createAvailable(),
                _createButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createName(){
    return TextFormField(
      initialValue: produc.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Product'),
      onSaved: (value) => produc.title = value,
      validator: (value){
        if(value.length < 3){
          return 'Insert the name of product';
        }else{
          return null;
        }
      },
    );
  }

  Widget _createPrice(){
     return TextFormField(
       initialValue: produc.price.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Price'),
      onSaved: (value) => produc.price = double.parse(value),
      validator: (value){
        if(utils.isNumeric(value)){
          return null;
        } else {
          return 'Only Numbers';
        }

      },
    );
  }

  Widget _createAvailable(){
    return SwitchListTile(
      value: produc.available,
      title: Text('Avalible'),
      onChanged: (value) => setState((){
        produc.available = value;
      }),
    );
  }

  Widget _createButton(context){
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).textTheme.headline.color,
      label: Text('Save'),
      icon: Icon(Icons.save),
      onPressed: ( _saving ) ? null : _submit,
    );
  }

  void _submit() async{

   if (!formKey.currentState.validate()) return;
   
   formKey.currentState.save();

   setState(() {_saving = true; });

   if(photo != null){
    produc.photoUrl = await productBloc.uploadPhoto(photo);
   }
  
    if(produc.id == null){
     productBloc.addProducts(produc);
    }else{
      productBloc.editProducts(produc);

    }

    //setState(() {_saving = false; });
    showSnackBar('Save Register');

    Navigator.pop(context);

  }


  void showSnackBar(String sms){
    final snackBar = SnackBar(
      content: Text(sms),
      duration: Duration(milliseconds: 15000),
    );
      scaffoldKey.currentState.showSnackBar(snackBar);

  }

  Widget _showPhoto(){
    if(produc.photoUrl != null){
      return FadeInImage(
        image: NetworkImage(produc.photoUrl),
        placeholder: AssetImage('assets/img/jar-loading.gif'),
        height: 300.0,
        fit: BoxFit.cover,
      );

    }else{
      return Image(
        image: AssetImage(photo?.path ?? 'assets/img/no-image.png'),
        height: 300.0,
        width: 300.0,
        fit: BoxFit.cover,
      );

    }
  }

  _selecPhoto() async{
    _proccesImage(ImageSource.gallery);

  }

  _takePhoto() async{
    _proccesImage(ImageSource.camera);
  }

  _proccesImage(ImageSource origin) async {
    photo = await ImagePicker.pickImage(
      source: origin
    );

    if(photo != null){
      // Clener
      produc.photoUrl = null;
    }

    setState(() {
      
    });
  }

}
