
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:votercircle_task/model/Comment.dart';

class PostCard extends StatefulWidget {
  final image, content, name, time,auth;

  PostCard(
      {this.image,
      this.content,
      this.name,
      this.time,
      this.auth,
     });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PostCard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Comment> commentsToPost = List<Comment>();
  bool visible_main_comments = false;
  bool visible_like = false;
  bool visible_reply_like = false;
  String comments_count='';
  var jiffy3 = Jiffy()
    ..startOf("seconds");

  var main_comments_controller = new TextEditingController();
  var reply_comments_controller = new TextEditingController();

  postComment() {

    setState(() {
      visible_main_comments = true;
    });
  }

  Widget main_comments() {
    return Theme(
      data: ThemeData(
        hintColor: Colors.transparent,
      ),
      child: Container(
        height: 42,
        margin: EdgeInsets.only(left: 20, right: 20,top: 10),
        child: TextField(
          controller: main_comments_controller,
          decoration: InputDecoration(
            hintText: 'Enter Comment',
            hintStyle: TextStyle(
              color: Colors.grey.withOpacity(0.6),
              fontSize: 16,
              fontFamily: 'Regular',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
            suffixIcon: GestureDetector(
              onTap: () {
                Comment cmt = Comment();
                cmt.message = main_comments_controller.text;
                main_comments_controller.clear();
                cmt.Name = '${widget.name}';
                cmt.created = jiffy3.fromNow();


                //print(cmt.Name);
                setState(() {
                  //visible_main_comments = false;
                  commentsToPost.add(cmt);
                  comments_count=commentsToPost.length.toString();
                  //main_comments_controller.clear();
                });
                FocusScope.of(context).requestFocus(FocusNode());

              },
              child: Icon(
                Icons.send,
                color: Colors.grey,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ),
    );
  }



  Widget getCommentWidget(Comment cmt) {
    return Container(
      margin: EdgeInsets.only(bottom: 3),
      decoration: new BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: new BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20,top: 5),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 10.0,
                  child: new Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        image: new NetworkImage('${widget.image}'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(cmt.Name,style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    fontFamily: 'Regular',
                  ),textAlign: TextAlign.left,),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45,top: 5),
            child: Text(cmt.message,style: TextStyle(
             fontWeight: FontWeight.w400,
              fontSize: 15,
              fontFamily: 'Regular',
            ),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(cmt.created),
              FlatButton(
                color: Colors.transparent,
                child: Text(cmt.isLiked==false?"Like":'You liked'),
                onPressed: () {
                  setState(() {
                    cmt.isLiked=!cmt.isLiked;
                  });

                },
              ),
              FlatButton(
                color: Colors.transparent,
                child: Text("Reply"),
                onPressed: () {
                  showDialog(

                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(32.0))),
                          title: Text(''),
                          content: Container(
                            height: 150,

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 1,top: 5),
                                  child: Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 10.0,
                                        child: new Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                              image: new NetworkImage('${widget.image}'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(cmt.Name,style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          fontFamily: 'Regular',
                                        ),textAlign: TextAlign.left,),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30,top: 5,bottom: 20),
                                  child: Text(cmt.message,style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    fontFamily: 'Regular',
                                  ),textAlign: TextAlign.left,),
                                ),
                                TextField(
                                  controller: reply_comments_controller,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Reply',
                                    hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(0.6),
                                      fontSize: 16,
                                      fontFamily: 'Regular',
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),

                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();

                              },
                            ),
                            new FlatButton(
                              child: new Text('Reply'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Comment repCmt = Comment();
                                repCmt.Name = '${widget.name}';
                                repCmt.message = reply_comments_controller.text;
                                repCmt.created = jiffy3.fromNow();
                                setState(() {

                                  cmt.replayes.add(repCmt);
                                  //reply_comments_controller.clear();
                                });
                                reply_comments_controller.clear();
                              },
                            )
                          ],
                        );
                      });

                },
              ),
            ],
          ),
          (cmt.replayes.length > 0)
              ? Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    children: cmt.replayes
                        .map<Widget>((rep) => getCommentWidget(rep))
                        .toList(),
                  ),
                )
              : Container(),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Timeline"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20.0,
                      child: new Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            image: new NetworkImage('${widget.image}'),
                          ),
                        ),
                      ),
                    ),
                    title: new Text(
                      '${widget.name}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: new Row(
                      children: [
                        new Text('${widget.time}'),
                        new Icon(
                          Icons.public,
                          size: 15.0,
                        )
                      ],
                    ),
                    trailing: new Icon(Icons.more_horiz),
                  ),
                  ListTile(
                    title: Text('${widget.content}'),
                  ),
                  Container(
                    padding: new EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              print(visible_like);
                              visible_like=!visible_like;
                              print(visible_like);
                            });

                          },
                          child: new Row(
                            children: <Widget>[
                              new CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Color(0xff3b5998),
                                child: new Icon(
                                  Icons.thumb_up,
                                  size: 12.0,
                                  color: Colors.white,
                                ),
                              ),

                              new Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 8.0),
                                child: new Text(visible_like==true?'You liked':'Like'),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: (){
                              if('${widget.auth}'=='No'){
                                showInSnackBar("Sorry...You need to login to add comments");
                              }else{
                                postComment();
                              }
                              },
                            child: new Text('$comments_count'+
                                " Comments  " +

                                " Share       ")),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              children: commentsToPost
                  .map<Widget>((cmt) => getCommentWidget(cmt))
                  .toList(),

              //
            ),
            visible_main_comments == true
                ? main_comments()
                : Container(
                    height: 1,
                  ),

          ],
        ),
      ),
    );
  }
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }
}
