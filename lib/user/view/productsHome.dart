import 'package:flutter/material.dart';
import 'package:mobile_app/user/model/products.dart';
import 'package:mobile_app/user/view/productDetail.dart';

class ProductsHome extends StatefulWidget {
  ProductsHome({Key key}) : super(key: key);

  @override
  _ProductsHomeState createState() => _ProductsHomeState();
}

class _ProductsHomeState extends State<ProductsHome> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Range Products"),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
       body: new Center(
        child: new Column(
          children: <Widget>[
            new SizedBox(
                  height: 50.0,
                ),
            new Flexible(
                child: new GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: productsItems.length,
              itemBuilder: (BuildContext context, int index) {
                return new GestureDetector(
                  onTap: () {
                    /* Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => new ItemDetails(
                              itemImage: productsItems[index].itemImage,
                              itemName: productsItems[index].itemName,
                              itemPrice: productsItems[index].itemPrice,
                              itemRating: productsItems[index].itemRating,
                            )));*/

                    
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => new ProductDetail(
                              itemImage: productsItems[index].itemImage,
                              itemName: productsItems[index].itemName,
                              itemPrice: productsItems[index].itemPrice,
                              itemRating: productsItems[index].itemRating,
                            ))); 
                  },
                  child: new Card(
                    child: Stack(
                      alignment: FractionalOffset.topLeft,
                      children: <Widget>[
                        new Stack(
                          alignment: FractionalOffset.bottomCenter,
                          children: <Widget>[
                            new Container(
                              decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: new AssetImage(
                                          productsItems[index].itemImage))),
                            ),
                            new Container(
                              height: 35.0,
                              color: Colors.black.withAlpha(100),
                              child: new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      "${productsItems[index].itemName}",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.0,
                                          color: Colors.white),
                                    ),
                                    new Text(
                                      "€${productsItems[index].itemPrice}",
                                      style: new TextStyle(
                                          color: Colors.brown[500],
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Container(
                              height: 30.0,
                              width: 60.0,
                              decoration: new BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: new BorderRadius.only(
                                    topRight: new Radius.circular(5.0),
                                    bottomRight: new Radius.circular(5.0),
                                  )),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  new Icon(
                                    Icons.star,
                                    color: Colors.blue,
                                    size: 20.0,
                                  ),
                                  new Text(
                                    "${productsItems[index].itemRating}",
                                    style: new TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}