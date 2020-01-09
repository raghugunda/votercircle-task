import 'package:flutter/material.dart';
import 'package:votercircle_task/view/post_card.dart';

class Create_post extends StatefulWidget {

  static String tag = 'login-page';
  final image, name, time,auth;

  Create_post(
      {this.image,

        this.name,
        this.time,
        this.auth,
      });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Create_post> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var contents=new TextEditingController();


  @override
  Widget build(BuildContext context) {

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.network("https://res-3.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco/v1497391258/yicm4n3ug1be1kdj8qid.png",
          fit: BoxFit.fill,),
      ),
    );

    final cont = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: contents,
      decoration: InputDecoration(
        hintText: 'What\'s on your mind',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );



    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostCard(
              image: "${widget.image}",
              content: contents.text,
              name: "${widget.name}",
              time: "${widget.time}",
              auth:"${widget.auth}",
            )),
          );


        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Post', style: TextStyle(color: Colors.white)),
      ),
    );



    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Post"),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            cont,

            SizedBox(height: 24.0),
            loginButton,

          ],
        ),
      ),

    );
  }
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }
}
