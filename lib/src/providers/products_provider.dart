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

      Future<bool> updateProduct(ProductModel product) async{

      final url = '$_url/productos/${product.id}.json';

      final resp = await http.put(url, body: productModelToJson(product));

      final decodeData = json.decode(resp.body);

      print(decodeData);

      return true;
    }

    Future<List<ProductModel>> readProducts()async {
      final url = '$_url/productos.json';
      final resp = await http.get(url);
      final Map<String, dynamic> decodedData = json.decode(resp.body);
      final List<ProductModel> products = new List();
      
      if(decodedData == null) return [];

      decodedData.forEach((id, prod){
        final prodTemp = ProductModel.fromJson(prod);
        prodTemp.id = id;

        products.add(prodTemp);

        print(id);
      });

      print (products);
      return products;
    }


    Future<int> deletedProduct(String id) async {

      final url = '$_url/productos/$id.json';
      final resp = await http.delete(url);
      print(json.decode(resp.body));
      return 1;


    }
}