import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/user/model/posts.dart';
import 'package:mobile_app/user/view/community/addPost.dart';


final analytics = new FirebaseAnalytics();
final reference = FirebaseDatabase.instance.reference().child('Blogs');


class PostBlogPage extends StatefulWidget {
  PostBlogPage({Key key}) : super(key: key);

  @override
  _PostBlogPageState createState() => _PostBlogPageState();
}

class _PostBlogPageState extends State<PostBlogPage> {

  List<Posts> postsList = [];

  @override
  void initState(){
    super.initState();

    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('Posts');
    databaseReference.once().then((DataSnapshot snap){
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      postsList.clear();

      for(var individualKey in KEYS){
        Posts posts = new Posts(
          DATA[individualKey]['image'],
          DATA[individualKey]['description'],
          DATA[individualKey]['date'],
          DATA[individualKey]['time'],
        );

        postsList.add(posts);
      }

      setState(() {
        print('Length: ${postsList.length}');
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text('User Community blog posts'),
      ),
      body: new Container(
        child: postsList.length ==0 ? new Text("No posts available") : new ListView.builder(
          itemCount: postsList.length,
          itemBuilder: (_,index){
            return postsUI(
              postsList[index].image, 
              postsList[index].description,
              postsList[index].date,
              postsList[index].time);
          }
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){return new AddPost();}));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget postsUI(String  image, String description, String date, String time ){
    return new Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),

      child: new Container(
        padding: new EdgeInsets.all(10.0),

        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
              date,
              style: Theme.of(context).textTheme.subtitle,
              textAlign: TextAlign.center,
            ),
            new Text(
              time,
              style: Theme.of(context).textTheme.subtitle,
              textAlign: TextAlign.center,
            ),
              ],
            ),
            SizedBox(height:10.0),

            new Image.network(image,fit:BoxFit.cover),
            SizedBox(height:10.0),
            new Text(
              description,
              style: Theme.of(context).textTheme.subhead,
              textAlign: TextAlign.center,
            ),
          ],)
      ),

    );
  }
}