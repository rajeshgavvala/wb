
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/user/controllers/signupUser.dart';
import 'package:mobile_app/user/view/home/userHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserLogin extends StatefulWidget {
  UserLogin({Key key}) : super(key: key);

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  bool _rememberMe = false;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final scaffoldKey = new GlobalKey<ScaffoldState>();

   bool _isLoading = false;
  String _username;
  String _password;

  
  @override
  void initState(){
    super.initState();

    usernameController.addListener(_getUsername);
    passwordController.addListener(_getPassword);

  }

  @override
  void dispose(){
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _getUsername(){
    _username = '${usernameController.text}';
    print(_username);
  }

  _getPassword(){
    _password = '${passwordController.text}';
  }

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Login"),
      ),
      resizeToAvoidBottomPadding: false,
      key: scaffoldKey,
       body: Stack(
         fit: StackFit.expand,
         children: <Widget>[
           Image.asset('assets/userLogo.jpg',
           fit: BoxFit.cover,
           ),
           Padding(
             padding: EdgeInsets.only(top:50.0),
             child: _isLoading ? Center(child: CircularProgressIndicator()): new Column(
            mainAxisAlignment:MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 100,
                child: CircleAvatar(
                radius: 50,
                backgroundImage: ExactAssetImage('assets/wb.jpeg'),
                ),
              decoration: new BoxDecoration(
              shape: BoxShape.circle,
              border: new Border.all(
                color: Colors.red,
                width: 3.0,
              ),
            ),
          ),
        Padding(padding:EdgeInsets.only(top:10),
        child: Stack(
        children: <Widget>[
         SingleChildScrollView(
            child:Container(
            height: 370.0,
            width: 350.0,
            padding:EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            decoration: BoxDecoration(
              color:Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:EdgeInsets.symmetric(vertical:25.0),
                child:TextField(
                  autocorrect: false,
                  autofocus: false,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  decoration: InputDecoration(
                    hintText: 'username',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.all(15.0)
                  ),
                  
                  controller: usernameController,

                ),
                ),
                TextField(
                  autocorrect: false,
                  autofocus: false,
                  obscureText: true,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  decoration: InputDecoration(
                    hintText: 'password',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.all(15.0)
                  ),
                  controller: passwordController,
                ),
                Padding(padding:EdgeInsets.only(top:8.0,bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new GestureDetector(
                      child: Row(
                        children: <Widget>[
                          new Checkbox(
                            value: _rememberMe,
                            onChanged: (value) => setState((){
                              _rememberMe = !_rememberMe;
                            }),
                          ),
                          new Text(
                            'Remember me'
                          ),
                        ],
                      ),
                      onTap: () => setState((){
                        _rememberMe = !_rememberMe;
                      }),
                    ),
                  new RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                      text: 'Forgot password?',
                      recognizer: new TapGestureRecognizer()..onTap = () => {
                        Navigator.pushNamed(context, '')
                      },
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],  
                ),
              ),
                Padding(
                  padding: EdgeInsets.only(bottom:8.0),
                  child: MaterialButton(
                    onPressed: (){
                      setState(() {
                      _isLoading = true;
                    });
                    print(_username + _password);
                    signIn(_username, _password);
                    
                  },
                color: Colors.blue,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                  ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                   ),
                ),
                ),
              ),
                RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'New User? ',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              recognizer: new TapGestureRecognizer()..onTap = () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserSignup()))},
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ), 
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ]
            ),
          );
  }

  signIn(String username, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //print(username);
    //print(password);

    var jsonResponse;
    var response = await http.post(
      "https://dry-meadow-98225.herokuapp.com/wbapi/auth/user/login",

      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',},
      
      body: jsonEncode(<String, String>{
       'username': username,
        'password': password,}),
    );

    print(response.statusCode);

    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(response.body);
      if(jsonResponse['accessToken']==null){
         _showSnackBar("username or password worng!");
         await new Future.delayed(const Duration(seconds: 4));
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => UserLogin()), (Route<dynamic> route) => false);
        }else if(jsonResponse['accessToken']!= null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("userId", jsonResponse['email']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => UserHome()), (Route<dynamic> route) => false);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      if(response.statusCode==401){
        String jsonResponse = response.body;
        Map decoded = json.decode(jsonResponse);
        String message = decoded['message'];
        _showSnackBar("$message!");
      }
    }
  }
  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  
  }

}