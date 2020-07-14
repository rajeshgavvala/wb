import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/user/controllers/loginUser.dart';
import 'package:mobile_app/user/services/userSharedPreferences.dart';
import 'package:mobile_app/user/view/cart.dart';
import 'package:mobile_app/user/view/chat/chat.dart';
import 'package:mobile_app/user/view/home/bodyHome.dart';
import 'package:mobile_app/user/view/notifications.dart';
import 'package:mobile_app/user/view/user/myOrders.dart';


class UserHome extends StatefulWidget {
  UserHome({Key key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    if(UserSharedPreferences().getUserId() == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => UserLogin()), (Route<dynamic> route) => false);
    }
    
}

int _currentIndex=0;

  final List<Widget> _childern= [
    BodyHome(),
    Cart(),
    Notifications(),
    Chat(),
  ];

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Welcome User", style: TextStyle(color: Colors.white)),
        
      ),
      
      body:_childern[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) => setState((){
          _currentIndex = newIndex;
          }),
          currentIndex: _currentIndex,
         backgroundColor: Colors.blue,
         selectedItemColor: Colors.black,
         unselectedItemColor: Colors.white,
         type: BottomNavigationBarType.fixed,
         items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Cart'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notifications'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chat'),
          ),
        ],
    ),
     drawer: NavBar(), 
    );
  }
  
}



//Navbar classs
class NavBar extends StatefulWidget {
  NavBar({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  @override
  void initState() {
    super.initState();
    getUser();
  }

  var user;
  getUser() async {
    var getUser =  await UserSharedPreferences().getUserId();
    setState(() {
      user = getUser;
      print('user::'+user);
    });
  }

  
 @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
                accountName: Text('',
                style: TextStyle(
                  color:Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),),
                accountEmail:Text('$user',
                style: TextStyle(
                  color:Colors.black,
                  fontSize: 20.0,
                ),),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/wb_logo.png')
                    ),
                    gradient:LinearGradient(colors:<Color>[
                      Colors.blueAccent,
                      Colors.white
              ],
              )
                ),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xffFDCF09),
              child: CircleAvatar(
                radius: 55,
                child: Icon(Icons.person),
              ),
            ),
            ),
            ),
          
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('MyAccount'),
            onTap: () => {}
          ),
          ListTile(
            leading: Icon(Icons.inbox),
            title: Text('Inbox'),
            onTap: () => {}
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('MyOrders'),
            onTap: () => {
              Navigator.push(context,MaterialPageRoute(builder: (context) => Listorders())),
            }
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              UserSharedPreferences().clearUserId();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MyApp()), (Route<dynamic> route) => false);
            }
          ),
        ],  
      ),
    );
  }
}


/*

import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/user/view/userHome.dart';
import 'package:mobile_app/userSharedPreferences.dart';


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
        title: Text("ProductUser Login"),
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
            height: 350.0,
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
                    Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
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
                Navigator.pushNamed(context, '')},
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 14.0,
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

    var jsonResponse;
    var response = await http.post(
      "http://192.168.0.108:8080/wbapi/auth/user/login",

      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',},
      
      body: jsonEncode(<String, String>{
       'username': username,
        'password': password,}),
    );

    print(response.statusCode);

    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      //print(response.body);
      if(jsonResponse['accessToken']==null){
         _showSnackBar("username or password worng!");
         await new Future.delayed(const Duration(seconds: 4));
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => UserLogin()), (Route<dynamic> route) => false);
        }else if(jsonResponse['accessToken']!= null) {
        setState(() {
          _isLoading = false;
        });
        UserSharedPreferences().setUserId(jsonResponse['email']);
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
        print(message);
        _showSnackBar("$message!");
      }
    }
  }
  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

} */





