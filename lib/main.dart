import 'package:flutter/material.dart';
import 'package:votercircle_task/view/create_post.dart';
import 'package:votercircle_task/view/post_card.dart';

void main() => runApp(
    MyApp()

);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Votercircle Inc',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Votercircle Inc'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  static String tag = 'login-page';
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var emails=new TextEditingController();
  var passwords=new TextEditingController();

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

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: emails,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.number,
      controller: passwords,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
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

          if(emails.text=='raghu'&&passwords.text=='12345'){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Create_post(
                  image: "https://avatars2.githubusercontent.com/u/3234592?s=460&v=4",
                  auth: "Yes",
                  name: "Raghavendra B N",
                  time: "10 mins ago · "
              )),
            );
          }else{
            showInSnackBar("Invalid Login");
          }

        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );
    final skipButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: FlatButton(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {


            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PostCard(
                  image: "https://avatars2.githubusercontent.com/u/3234592?s=460&v=4",
                  content: "Flutter is so amazing! I am loving it.I have been using this framework from past couple of weeks. Learning curve is high & it will be easy for you if you are coming from C# or Java background. It gives consistent UI across platforms and its blazing fast!. if you are into mobile app development, you should give it a try.",
                  name: "Raghavendra B N",
                  time: "10 mins ago · ",
                  auth: "No",
              )),
            );


        },
        padding: EdgeInsets.all(12),
        color: Colors.transparent,
        child: Text('Skip', style: TextStyle(color: Colors.black)),
      ),
    );



    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            SizedBox(height: 1.0),
            skipButton,

          ],
        ),
      ),

    );
  }
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }
}
