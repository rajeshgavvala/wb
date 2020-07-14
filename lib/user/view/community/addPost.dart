import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/user/view/community/myCommunity.dart';

class AddPost extends StatefulWidget {
  AddPost({Key key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  final formKey = new GlobalKey<FormState>();

  File sampleImage;
  String _myDescription;
  String urlImage;
  final picker = ImagePicker();

  Future getImage() async{
    var tempImage = await picker.getImage(source: ImageSource.camera);
    setState(() {
      sampleImage=File(tempImage.path);
    });
  }

  bool validateAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  void floatStausImage() async{
    if(validateAndSave()){
      final StorageReference postBlogImage = FirebaseStorage.instance.ref().child("Post Images");
      var timeKey = new DateTime.now();
      final StorageUploadTask uploadTask = postBlogImage.child(timeKey.toString()+".png").putFile(sampleImage);

      var url = await (await uploadTask.onComplete).ref.getDownloadURL();

      urlImage = url.toString();
      print('urlImage::'+urlImage);

      goToMyCommunityPage();
      saveToDatabase(urlImage);
    }
  }

  void saveToDatabase(urlImage){
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM, d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

    var data = {
      "image":urlImage,
      "description" : _myDescription,
      "date" : date,
      "time" : time,
    };

    databaseReference.child("Posts").push().set(data); 


  }

  void goToMyCommunityPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context){return new PostBlogPage();}));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
       appBar: AppBar(
         title: new Text('Send a post')
       ),
       body: new Center(
         child:sampleImage==null?Text('Select an Image'):enableUpload(),
       ),
       floatingActionButton: new FloatingActionButton(
         onPressed: getImage,
         tooltip: 'Add Image',
         child: new Icon(Icons.add_a_photo),
         
       ),
    );
  }

  Widget enableUpload(){
    return new Container(
      child: new Form(
        key: formKey,
      child: Column(
        children: <Widget>[
          Image.file(sampleImage,height:400.0, width:400.0,),
          SizedBox(height:15.0),

          TextFormField(
            decoration: new InputDecoration(
              labelText: 'Description'
            ),
            validator:(value){
              return value.isEmpty ? 'Blog Description is required' : null;
            },
            onSaved: (value){
              return _myDescription = value;
            },
          ),

          SizedBox(height:15.0),

          RaisedButton(
            elevation: 10.0,
            child: Text('Send new post'),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: floatStausImage,
            ),

        ],
      ),
        ),
    );
  }


}