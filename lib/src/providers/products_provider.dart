import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

import 'package:forms_validation/src/model/product_model.dart';

class ProductProvider {
  final _url = 'https://flutter-varios-96ac0.firebaseio.com';

  Future<bool> createProduct(ProductModel product) async {
    final url = '$_url/productos.json';

    final resp = await http.post(url, body: productModelToJson(product));

    final decodeData = json.decode(resp.body);

    return true;
  }

  Future<bool> updateProduct(ProductModel product) async {
    final url = '$_url/productos/${product.id}.json';

    final resp = await http.put(url, body: productModelToJson(product));

    final decodeData = json.decode(resp.body);

    return true;
  }

  Future<List<ProductModel>> readProducts() async {
    final url = '$_url/productos.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductModel> products = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = ProductModel.fromJson(prod);
      prodTemp.id = id;

      products.add(prodTemp);
    });

    
    return products;
  }

  Future<int> deletedProduct(String id) async {
    final url = '$_url/productos/$id.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));
    return 1;
  }



  Future<String> uploadImage(File img) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/df6gqwcvl/image/upload?upload_preset=gmnmdvbw');
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
