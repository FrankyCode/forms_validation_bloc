import 'package:flutter/material.dart';
import 'package:forms_validation/src/model/product_model.dart';
import 'package:forms_validation/src/providers/products_provider.dart';
import 'package:forms_validation/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();

  ProductModel produc = new ProductModel();
  final productProvider = new ProductProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
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
      onPressed: _submit,
    );
  }

  void _submit(){

   if (!formKey.currentState.validate()){
      return;
   }

   formKey.currentState.save();
   print(produc.title);
   print(produc.price);
   print(produc.available);
  
    productProvider.createProduct(produc);


  }
}
