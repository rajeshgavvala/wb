import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_app/user/view/myWorld/registerNewProduct.dart';
import 'package:mobile_app/user/view/myWorld/reportIssue.dart';


class MyProdcutWorld extends StatefulWidget {
  MyProdcutWorld({Key key}) : super(key: key);

  @override
  _MyProdcutWorldState createState() => _MyProdcutWorldState();
}

class _MyProdcutWorldState extends State<MyProdcutWorld> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Product World'),
      ),
      body: new ListView(
        children:<Widget>[
          new Padding(
          padding: EdgeInsets.only(top:30.0),
          child: new Container(
          height: 400,
          child: new MyProdcutWorldGridView(),
        ),
          ),
        ],
      ) 
    );
      
  }
}

class MyProdcutWorldGridView extends StatefulWidget {
  MyProdcutWorldGridView({Key key}) : super(key: key);

  @override
  _MyProdcutWorldGridViewState createState() => _MyProdcutWorldGridViewState();
}

class _MyProdcutWorldGridViewState extends State<MyProdcutWorldGridView> {


  Material grid(IconData icon, String title, int color){
    return Material(
      color: Colors.blueGrey[200],
      elevation: 0.0,
      borderRadius: BorderRadius.circular(25.0),
      child: InkWell(
        onTap: (){
          if(title=='Add new product'){
            print('+ Products');
            Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterProduct()));
          }else if(title=='Report issue'){
            print('Report issue');
            Navigator.push(context,MaterialPageRoute(builder: (context) => ReportProblem()));
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
         crossAxisCount: 1,
         crossAxisSpacing: 12.0,
         mainAxisSpacing: 12.0,
         padding: EdgeInsets.symmetric(horizontal:16.0, vertical:8.0),
         children: <Widget>[
           grid(Icons.add, 'Add new product', 0xff536dfe),
           grid(Icons.report_problem, 'Report issue', 0xff536dfe),
           //$₹
         ],
         staggeredTiles: [
           StaggeredTile.extent(1, 150.0),
           StaggeredTile.extent(1, 150.0),
         ],
       );
  }
}