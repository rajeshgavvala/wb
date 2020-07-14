import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_app/user/view/community/myCommunity.dart';
import 'package:mobile_app/user/view/myWorld/myWorld.dart';
import 'package:mobile_app/user/view/productsHome.dart';


class BodyHome extends StatefulWidget {
  BodyHome({Key key}) : super(key: key);

  @override
  _BodyHomeState createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:new ListView(
        children: <Widget>[
        new Padding(padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
        child:new UserCarousel(),
        ),
        new Padding(
          padding: EdgeInsets.only(top:30.0),
          child: new Container(
          height: 400,
          child: new GridView(),
        ),
          ),
        ],
        
      ),
     
      
    );
  }
}



//Carousel
class UserCarousel extends StatefulWidget {
  UserCarousel({Key key}) : super(key: key);

  @override
  _UserCarouselState createState() => _UserCarouselState();
}

class _UserCarouselState extends State<UserCarousel> {
  @override
  Widget build(BuildContext context) {
    return new Center(     
        child: SizedBox(
          height: 200.0,
          child: Carousel(
            boxFit: BoxFit.fitHeight,
            autoplay: true,
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(milliseconds: 2000),
            dotSize: 6.0,
            dotIncreasedColor:Colors.blue,
            dotBgColor: Colors.transparent,
            dotColor: Colors.black,
            dotPosition: DotPosition.bottomLeft,
            dotVerticalPadding: 10.0,
            showIndicator: true,
            indicatorBgPadding: 7.0,
            images: [
              Card(
                  child:Column(mainAxisSize: MainAxisSize.min, 
                  children: <Widget>[
                    Image.asset('assets/wb_logo.png'),
                 
              ])),
              Card(
                  child:Column(mainAxisSize: MainAxisSize.min, 
                  children: <Widget>[
                    Image.asset('assets/small.png'),
                 ButtonBar(
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: const Text('Details'),
                  onPressed: () {print("Mugs");},
                ),
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: const Text('Cart'),
                  onPressed: () {print("Mugs");},
                ),
              ],
            ),
              ])),
              Card(
                  child:Column(mainAxisSize: MainAxisSize.min, 
                  children: <Widget>[
                    Image.asset('assets/happy.png'),
                 
              ])),
              Card(
                  child:Column(mainAxisSize: MainAxisSize.min, 
                  children: <Widget>[
                    Image.asset('assets/safe.jpg'),
                 
              ])),
              Card(
                  child:Column(mainAxisSize: MainAxisSize.min, 
                  children: <Widget>[
                    Image.asset('assets/water.jpeg'),
                 
              ])),
              Card(
                  child:Column(mainAxisSize: MainAxisSize.min, 
                  children: <Widget>[
                    Image.asset('assets/smallCatetridge.png'),
                 ButtonBar(
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: const Text('Details'),
                  onPressed: () {print("smallCatetridge");},
                ),
              ],
            ),
              ])),
              Card(
                  child:Column(mainAxisSize: MainAxisSize.min, 
                  children: <Widget>[
                    Image.asset('assets/smallBottles.png'),
                 ButtonBar(
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: const Text('Bottles'),
                  onPressed: () {print("WaterBottles");},
                ),
              ],
            ),
              ])),
            ],
          ),
        ),
      );
  }
}


// GridView class
class GridView extends StatefulWidget {
  GridView({Key key}) : super(key: key);

  @override
  _GridViewState createState() => _GridViewState();
}

class _GridViewState extends State<GridView> {

  Material grid(IconData icon, String title, int color){
    return Material(
      color: Colors.greenAccent,
      elevation: 0.0,
      borderRadius: BorderRadius.circular(25.0),
      child: InkWell(
        onTap: (){
          if(title=='Products'){
            print('Products');
            Navigator.push(context,MaterialPageRoute(builder: (context) => ProductsHome()));
          }else if(title=='Community'){
            print('Community');
            Navigator.push(context,MaterialPageRoute(builder: (context) => PostBlogPage()));
          }else if(title=='MyWorld'){
            print('MyWorld');
            Navigator.push(context,MaterialPageRoute(builder: (context) => MyProdcutWorld()));
          }
        },
        child:Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(title,
                    style: TextStyle(
                      color:new Color(color),
                      fontSize:20.0,
                      ),
                    ),
                  ),
                  
                  Material(
                    color: new Color(color),
                    borderRadius: BorderRadius.circular(20.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 40.0,
                      ),
                      ),
                     
                     ),
        
                ],
              ),
            ],
            ),
        ),
        
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
         crossAxisCount: 2,
         crossAxisSpacing: 12.0,
         mainAxisSpacing: 12.0,
         padding: EdgeInsets.symmetric(horizontal:16.0, vertical:8.0),
         children: <Widget>[
           grid(Icons.category, 'Products', 0xffed622d),
           grid(Icons.group_work, 'Community', 0xffed622d),
           grid(Icons.memory, 'MyWorld', 0xffed622d),
           grid(Icons.card_giftcard, 'Rewards', 0xffed622d),
           //$₹
         ],
         staggeredTiles: [
           StaggeredTile.extent(1, 150.0),
           StaggeredTile.extent(1, 150.0),
           StaggeredTile.extent(1, 150.0),
           StaggeredTile.extent(1, 150.0),
         ],
       );
  }
}