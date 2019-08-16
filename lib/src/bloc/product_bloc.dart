import 'dart:io';

import 'package:forms_validation/src/model/product_model.dart';
import 'package:forms_validation/src/providers/products_provider.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc {
  final _productController = new BehaviorSubject<List<ProductModel>>();
  final _loadingController = new BehaviorSubject<bool>();

  final _productProvider = new ProductProvider();

  Stream<List<ProductModel>> get productsStream => _productController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;

  void loadingProduct() async {
    final products = await _productProvider.readProducts();
    _productController.sink.add(products);
  }

  void addProducts(ProductModel product) async {
    _loadingController.sink.add(true);
    await _productProvider.createProduct(product);
    _loadingController.sink.add(false);
  }

  void editProducts(ProductModel product) async {
    _loadingController.sink.add(true);
    await _productProvider.updateProduct(product);
    _loadingController.sink.add(false);
  }

  void deletedProducts(String id) async {
    await _productProvider.deletedProduct(id);
  }

  Future<String> uploadPhoto(File photo) async {
    _loadingController.sink.add(true);
   final photoUrl = await _productProvider.uploadImage(photo);
    _loadingController.sink.add(false);

    return photoUrl;
  }

  dispose() {
    _productController?.close();
    _loadingController?.close();
  }
}
