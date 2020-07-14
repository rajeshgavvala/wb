import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/user/model/feedback.dart';
import 'package:mobile_app/user/services/userSharedPreferences.dart';
import 'package:mobile_app/user/view/home/userHome.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class FeedbackForm extends StatefulWidget {
  FeedbackForm({Key key}) : super(key: key);

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {

final scaffoldKey = new GlobalKey<ScaffoldState>();
final formKey = new GlobalKey<FormState>();
bool autoValidate = false;

double rating = 0.0 ;
double rate;
String inputMessage='Rate your product';
String feedbackMessage;


Future<RateReview> createNewFeedback(String pname, String prate, String preview) async {
    final http.Response response = await http.post(
    'http://192.168.0.108:5000/user/feedback/insert',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "pType":pname,
      "rate":prate,
      'review': preview,
      
    }),
  );

  print(response.statusCode);

  if (response.statusCode == 200) {
     print(response.statusCode);
    
    //print(json.decode(response.body));
    
    return new RateReview();
  } else {
    throw Exception('Failed to insert feedback');
  }
}

@override
Widget build(BuildContext context) {
return Scaffold(
  key: scaffoldKey,
  appBar: AppBar(
    title:Text('Rate & Review'),
  ),
  body: Form(
    key: formKey,
    autovalidate: autoValidate,
    child: runGui(),
    ),
  );
}

Widget runGui(){
  return Center(
    child: Column(
      children: <Widget>[
 
        Padding(
          padding: const EdgeInsets.all(12.0),
          /*
          child: Text(title, 
                  style: TextStyle(fontSize: 22)) */),
 
        SmoothStarRating(
          allowHalfRating: false,
          onRated: (value) {
            String msg;
            double urate;
            if(value==1){
              msg = 'Very Bad';
              urate = value;
            }
            else if(value==2){
              msg = 'Bad';
              urate = value;
            }
            else if(value==3){
              msg = 'Good';
              urate = value;
            }
            else if(value==4){
              msg = 'Very Good';
              urate = value;
            }
            else if(value==5){
              msg = 'Excellent';
              urate = value;
            }
          
            setState(() {
              inputMessage = msg;
              rate = urate;
            });
          },
          starCount: 5,
          rating: rating,
          size: 40.0,
          color: Colors.green,
          borderColor: Colors.black,
          spacing:0.0,           
        ),
 
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('$inputMessage', 
                  style: TextStyle(fontSize: 22))
                  ),
        new Container(
          child: TextField(
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Review product',
              hintText:"Description",
              border: OutlineInputBorder(
                borderSide: BorderSide(color:Colors.black),
              ),
            ),
            onChanged: (val) {
              if(val!=null){
                feedbackMessage = val;
                print(feedbackMessage); 
              }
              return val;
            },
          ),
          padding: EdgeInsets.only(left:50.0,right: 50.0, top: 10.0, bottom: 10.0),
        ),
        new RaisedButton(
          onPressed:()=> _submit(),
          child: new Text('SUBMIT'),
          color: Colors.orange,
          ),
 
      ],
    ),
  );
}
void _submit() async{

  if (formKey.currentState.validate()) {
      formKey.currentState.save();

      var pValue = await UserSharedPreferences().getUserId();
      print(pValue);
      createNewFeedback(pValue,'$rate',feedbackMessage);

    formKey.currentState.reset();

    _showSnackBar("Feedback $rate registered successfully");

    formKey.currentState.reset();

    await new Future.delayed(const Duration(seconds: 5));

    //Navigator.pushNamed(context, '/wbapi/login');
    Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserHome()));
    

     }else{
       setState(()=>autoValidate=true);
     }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  } 

}