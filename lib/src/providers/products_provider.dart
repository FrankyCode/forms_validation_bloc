import 'dart:convert';

import 'package:forms_validation/src/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider{

    final _url = 'https://flutter-varios-96ac0.firebaseio.com';

    Future<bool> createProduct(ProductModel product) async{

      final url = '$_url/productos.json';

      final resp = await http.post(url, body: productModelToJson(product));

      final decodeData = json.decode(resp.body);

      print(decodeData);

      return true;
    }

}