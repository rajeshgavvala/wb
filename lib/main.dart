import 'package:flutter/material.dart';
import 'package:mobile_app/user/controllers/loginUser.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
} 

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('DigiApp'),
         actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserLogin()));
              },
              textColor: Colors.white,
              child: Icon(
                Icons.account_circle,
                color: Colors.grey[800],
                size: 30.0,),
              )
        ],
       ),
    );
  }
}





















/*
class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class OptionsList{
  static const String user = 'ProductUser';
  static const String admin = 'ProductAdmin';
  static const String owner = 'ProductOwner';
  static const String retailer = 'ProductRetailer';
  static const String testing = 'TestPage';
  
  static const List<String> options = <String>[
    user,
    admin,
    owner,
    retailer,
    testing,
  ];
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DigiApp"),
        actions: <Widget>[
            PopupMenuButton<String>(
              onSelected:(val) => selectOption(val, context),
              itemBuilder:(BuildContext context){
                return OptionsList.options.map((String option){
                    return PopupMenuItem<String>(
                      value:option,
                      child: Text(option));
                      }).toList();
                      },
                  ),
                  ],
        automaticallyImplyLeading: false,
      ),
    );
  }
}

void selectOption(String option, BuildContext context){
  if(option==OptionsList.user){
    print('User');
    Navigator.push(context, MaterialPageRoute(builder: (context) => UserLogin()));
    
  }else if(option==OptionsList.admin){
    print('Admin');
    
  }else if(option==OptionsList.owner){
   print('Owner');

  }else if(option==OptionsList.retailer){
    print('Retailer');
  }
  else if(option==OptionsList.testing){
    print('Testing');
  }
} */




/*
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<SliderModel> mySLides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage){
    return Container(
     margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    mySLides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [const Color(0xff3C8CE7), const Color(0xff00EAFF)])),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: PageView(
            controller: controller,
              onPageChanged: (index) {
                setState(() {
                  slideIndex = index;
                });
              },
          children: <Widget>[
            SlideTile(
              imagePath: mySLides[0].getImageAssetPath(),
              title: mySLides[0].getTitle(),
              desc: mySLides[0].getDesc(),
            ),
            SlideTile(
              imagePath: mySLides[1].getImageAssetPath(),
              title: mySLides[1].getTitle(),
              desc: mySLides[1].getDesc(),
            ),
            SlideTile(
              imagePath: mySLides[2].getImageAssetPath(),
              title: mySLides[2].getTitle(),
              desc: mySLides[2].getDesc(),
            )
          ],
          ),
        ),
        bottomSheet: slideIndex != 2 ? Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: (){
                  controller.animateToPage(2, duration: Duration(milliseconds: 400), curve: Curves.linear);
                },
                splashColor: Colors.blue[50],
                child: Text(
                  "SKIP",
                  style: TextStyle(color: Color(0xFF0074E4), fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    for (int i = 0; i < 3 ; i++) i == slideIndex ? _buildPageIndicator(true): _buildPageIndicator(false),
                  ],),
              ),
              FlatButton(
                onPressed: (){
                  print("this is slideIndex: $slideIndex");
                  controller.animateToPage(slideIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
                },
                splashColor: Colors.blue[50],
                child: Text(
                  "NEXT",
                  style: TextStyle(color: Color(0xFF0074E4), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ): InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => UserLogin()));
          },
          child: Container(
            height: Platform.isIOS ? 70 : 60,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              "GET STARTED NOW",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class SlideTile extends StatelessWidget {
  final String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath),
          SizedBox(
            height: 40,
          ),
          Text(title, textAlign: TextAlign.center,style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20
          ),),
          SizedBox(
            height: 20,
          ),
          Text(desc, textAlign: TextAlign.center,style: TextStyle(
          fontWeight: FontWeight.w500,
              fontSize: 14))
        ],
      ),
    );
  }
}
      
      
class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("We are ISO 9001-2008 Certified company having presence in Asia and Europe. Our team consist of Experts from IIT, IIM, FH-Germany makes us your Local Global partner. Our expertise with Engineering support, Engineering consultancies and Engineering innovations assist our customers to realize their goals such as value transformation, increase market share, minimizing risks and capitalization on new opportunities. We are working with Global OEM and Tier 1 suppliers around the globe.");
  sliderModel.setTitle("Who are we");
  sliderModel.setImageAssetPath("assets/wb.jpeg");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Our offers includes Process driven Flexible, Scalable End to End Solutions ");
  sliderModel.setTitle("Services");
  sliderModel.setImageAssetPath("assets/services.jpeg");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("we deliver or support");
  sliderModel.setTitle("Support");
  sliderModel.setImageAssetPath("assets/service.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
 */


  
