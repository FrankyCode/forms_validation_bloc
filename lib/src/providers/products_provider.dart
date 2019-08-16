import 'dart:convert';
import 'dart:io';

import 'package:forms_validation/src/preferences_user/preferences_user.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

import 'package:forms_validation/src/model/product_model.dart';

class ProductProvider {
  //TODO: URL for your database
  final _url = 'PUT HERE YOUR URL DATABASE';
  final _prefs = new PreferenceUser();

  Future<bool> createProduct(ProductModel product) async {
    final url = '$_url/productos.json?auth=${_prefs.token}';

    final resp = await http.post(url, body: productModelToJson(product));

    final decodeData = json.decode(resp.body);
    

    return true;
  }

  Future<bool> updateProduct(ProductModel product) async {
    final url = '$_url/productos/${product.id}.json?auth=${_prefs.token}';

    final resp = await http.put(url, body: productModelToJson(product));

    final decodeData = json.decode(resp.body);

    return true;
  }

  Future<List<ProductModel>> readProducts() async {
    final url = '$_url/productos.json?auth=${_prefs.token}';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductModel> products = new List();

    if (decodedData == null) return [];

    if(decodedData['error'] != null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = ProductModel.fromJson(prod);
      prodTemp.id = id;

      products.add(prodTemp);
    });

    
    return products;
  }

  Future<int> deletedProduct(String id) async {
    final url = '$_url/productos/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);
    print(json.decode(resp.body));
    return 1;
  }



  Future<String> uploadImage(File img) async {
    //TODO: URL for your API service to upload photos. I used cloudinary for example
    final url = Uri.parse('HERE API URL');
    final mimeType = mime(img.path).split('/');

    final imgUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', img.path,
        contentType: MediaType(mimeType[0], mimeType[1]));
    
    imgUploadRequest.files.add(file);

    final streamResponse = await imgUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode !=201){
      print('Somethings is wrong');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);

    print(respData);
    return respData['secure_url'];
  }
}
