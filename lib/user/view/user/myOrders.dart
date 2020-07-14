import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile_app/user/model/orders.dart';
import 'package:mobile_app/user/view/user/feedback.dart';


class Listorders extends StatefulWidget {
  Listorders({Key key}) : super(key: key);

  @override
  _ListordersState createState() => _ListordersState();
}

class _ListordersState extends State<Listorders> {

  List<Orders> _orders = List<Orders>();

  File file;

  Future<List<Orders>> getorders(String id) async {

    var response = await http.post(
      "http://192.168.0.108:5000/user/order/getOrders",
      headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'id': id,
    }),
    );

    var orders = List<Orders>();

    if(response.statusCode==200){
      var responseJson = json.decode(response.body);
      var ordersJson = responseJson["orders"];
      for (var issueJson in ordersJson) {
        orders.add(Orders.fromJson(issueJson));
      }

      print(ordersJson);
      print(orders);
   }
   return orders;
  }

 
@override
  initState(){
    getorders('u1@gmail.com').then((value) {
      setState(() {
        _orders.addAll(value);
      });
    });
    super.initState();
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My orders'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 5.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Product Name: '+_orders[index].pType,
                    style: TextStyle(
                      color: Colors.grey.shade600
                    ),
                  ),
                  Text(
                   'Product code: '+ _orders[index].productCode,
                    style: TextStyle(
                      color: Colors.grey.shade600
                    ),
                  ),
                  Text(
                    'Purchased: '+_orders[index].purchasedOn,
                    style: TextStyle(
                      color: Colors.grey.shade600
                    ),
                  ),
                  Text(
                    'Warranty: '+_orders[index].warrantTill,
                    style: TextStyle(
                      color: Colors.grey.shade600
                    ),
                  ),
                  ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                            Icons.star,
                            color: Color.fromRGBO(68, 153, 213, 1.0),
                          ),
                      Text(
                        'Rate & Review',
                        style: TextStyle(
                          color: Color.fromRGBO(68, 153, 213, 1.0),
                          ),
                          )
                        ],
                      ),
                  onPressed: () {
                    print('Feedback');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackForm()));
                  },
                ),
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                            Icons.extension,
                            color: Color.fromRGBO(68, 153, 213, 1.0),
                          ),
                      Text(
                        'Extend warranty',
                        style: TextStyle(
                          color: Color.fromRGBO(68, 153, 213, 1.0),
                          ),
                          )
                        ],
                      ),
                  onPressed: () {
                    print('Warranty extended');
                    _showcontent();
                  },
                ),
              ],
            ),
                ],
              ),
              
            ),
          );
        },
        itemCount: _orders.length,
      )
    );
  }

  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Extend Warranty'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text('This feature included soon!'),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}