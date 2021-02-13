import 'package:flutter/material.dart';
import 'package:FaceNetAuthentication/commons.dart';
import 'home.dart';

class Profile extends StatelessWidget {
  const Profile({Key key, @required this.username}) : super(key: key);

  final String username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Image.asset('assets/images/studentBg.png',
             // color:Commons.commonThemeColor,
            ),
          ),
          Positioned(top: 0,child: Commons.appHeader('Students page', context),),
          Positioned(
              top: 100,
              right: 30,
              child: _logOutButton(context)),
          Positioned(
            top: 100,
            left: 30,
            child: Text('Hi! ${username.substring(0,1).toUpperCase()}${username.substring(1)}',style: TextStyle(
                color: Commons.commonThemeColor,
                fontWeight: FontWeight.bold,
                fontSize: 25
            ),),),
          Positioned(
            top: 200,
            left: 30,
            child: Text('Your Exam is Preparing...',style: TextStyle(
                color: Commons.commonThemeColor,
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),),),
        ],
      ),
    );
  }

  Widget _logOutButton(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage()
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
            color:Commons.commonThemeColor,
            borderRadius: BorderRadius.circular(4)
        ),
        child: Text('log out',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.white
        ),),
      ),
    );
  }
}
