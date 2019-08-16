import 'package:flutter/material.dart';
import 'package:forms_validation/src/bloc/provider.dart';
import 'package:forms_validation/src/model/product_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsBloc = Provider.productsBloc(context);
    productsBloc.loadingProduct();

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: _createList(productsBloc),
      floatingActionButton: _createButton(context),
    );
  }

  Widget _createList(ProductBloc productBloc) {
    return StreamBuilder(
        stream: productBloc.productsStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, i) => _createItem(context, productBloc, products[i]),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _createItem(BuildContext context,ProductBloc productBloc, ProductModel product) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) => productBloc.deletedProducts(product.id),
        child: Card(
          child: Column(
            children: <Widget>[
              (product.photoUrl == null)
                  ? Image(
                      image: AssetImage('assets/img/no-image.png'),
                    )
                  : FadeInImage(
                      image: NetworkImage(product.photoUrl),
                      placeholder: AssetImage('assets/img/jar-loading.gif'),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ListTile(
                title: Text('${product.title} - ${product.price}'),
                subtitle: Text(product.id),
                onTap: () =>
                    Navigator.pushNamed(context, 'product', arguments: product),
              ),
            ],
          ),
        ));
  }

  Widget _createButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'product'),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
