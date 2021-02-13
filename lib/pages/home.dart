
import 'package:FaceNetAuthentication/pages/db/database.dart';
import 'package:FaceNetAuthentication/pages/sign-in.dart';
import 'package:FaceNetAuthentication/pages/sign-up.dart';
import 'package:FaceNetAuthentication/services/facenet.service.dart';
import 'package:FaceNetAuthentication/services/ml_vision_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:FaceNetAuthentication/commons.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FaceNetService _faceNetService = FaceNetService();
  MLVisionService _mlVisionService = MLVisionService();
  DataBaseService _dataBaseService = DataBaseService();

  CameraDescription cameraDescription;
  bool loading = false;
  bool adminLoginToggle = false;
  bool adminLoginPage = false;
  String userName;
  String password;
  FToast fToast;

  bool get isValid => userName != null && password != null && userName != '' && password != '';

  @override
  void initState() {
    super.initState();
    _startUp();
  }

  _startUp() async {
    _setLoading(true);

    List<CameraDescription> cameras = await availableCameras();

    cameraDescription = cameras.firstWhere(
      (CameraDescription camera) => camera.lensDirection == CameraLensDirection.front,
    );

    await _faceNetService.loadModel();
    await _dataBaseService.loadDB();
    _mlVisionService.initialize();

    _setLoading(false);
  }

  _setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  _setStaffLogin(bool value){
    setState(() {
      adminLoginToggle = value;
    });
  }

  _setAdminLoginPage(bool value){
    setState(() {
      adminLoginPage = value;
    });
  }

  _setUserName(String value){
    setState(() {
      userName = value;
    });
  }

  _setPassword(String value){
    setState(() {
      password = value;
    });
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );

    // Custom Toast Position
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !adminLoginPage?
      Stack(
        alignment: Alignment.center,
         children: [
           Positioned(
             top: 100,
               child: Container(
                 width: MediaQuery.of(context).size.width,
                 height: MediaQuery.of(context).size.height - 150,
                 alignment: Alignment.center,
                 child: Image.asset('assets/images/bg.png',color: Commons.commonThemeColor,),
               ),),
           Positioned(
             top: 80,
             left: 30,
             child: Text('Sign in',style: TextStyle(
               color: Commons.commonThemeColor,
               fontWeight: FontWeight.bold,
               fontSize: 40
           ),),),
           Positioned(
             top: 200,
             child: _studentLoginButton()),
           Positioned(
               top: 280,
               child:_adminLoginToggle()),
           if(adminLoginToggle)
           Positioned(
             top: 350,
             child: Container(
               width: MediaQuery.of(context).size.width - 100,
               color:  Colors.white,
               child: TextField(
                 decoration: InputDecoration(
                     border: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.teal),
                     ),
                     labelText: 'User Name',
                     prefixIcon: Icon(Icons.person, color: Commons.commonThemeColor,),),
                 onChanged: (value){
                   _setUserName(value);
                 },
               )
             ),
           ),
           if(adminLoginToggle)
           Positioned(
             top: 420,
             child: Container(
               width: MediaQuery.of(context).size.width - 100,
               color: Colors.white,
               child: TextField(
                 decoration: InputDecoration(
                   border: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.teal),
                   ),
                   labelText: 'Password',
                   prefixIcon: Icon(Icons.lock, color: Commons.commonThemeColor,),),
                 obscureText: true,
                 onChanged: (value){
                   _setPassword(value);
                 },
               ),
             ),
           ),
           if(adminLoginToggle)
           Positioned(
               top: 500,
               child: _adminLoginButton()),
         ],
      ):  Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Image.asset('assets/images/bg.png',color:Commons.commonThemeColor,),
          ),
          Positioned(top: 0,child: Commons.appHeader('Face Auth Admin', context),),
          Positioned(
            top: 100,
            left: 30,
            child: Text('Admin Page',style: TextStyle(
                color: Commons.commonThemeColor,
                fontWeight: FontWeight.bold,
                fontSize: 25
            ),),),
          Positioned(
              top: 100,
              right: 30,
              child: _adminLogOutButton()),
          Positioned(
              top: 200,
              child: _addStudentButton(),),
          Positioned(
              top: 280,
              child:_clearDBButton()),
        ],
      ),
    );
  }

  Widget _studentLoginButton(){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SignIn(
              cameraDescription: cameraDescription,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
            color: Commons.commonThemeColor,
            borderRadius: BorderRadius.circular(4)
        ),
        child: Text('Student\'s login',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white
        ),),
      ),
    );
  }

  Widget _adminLoginToggle(){
    return  GestureDetector(
      onTap: (){
        if(adminLoginToggle){
          _setStaffLogin(false);
        }
        else {
          _setStaffLogin(true);
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
            color: Commons.commonThemeColor,
            borderRadius: BorderRadius.circular(4)
        ),
        child: Text('Staff\'s login',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white
        ),),
      ),
    );
  }

  Widget _adminLoginButton(){
    return GestureDetector(
      onTap: (){
        if(isValid && userName == 'admin' && password == 'password'){
          _setAdminLoginPage(true);
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
            color: !isValid? Colors.grey: Commons.commonThemeColor,
            borderRadius: BorderRadius.circular(4)
        ),
        child: Text('login',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white
        ),),
      ),
    );
  }

  Widget _adminLogOutButton(){
    return GestureDetector(
      onTap: (){
        _setUserName(null);
        _setPassword(null);
        _setAdminLoginPage(false);
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

  Widget _addStudentButton(){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SignUp(
              cameraDescription: cameraDescription,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
            color: Commons.commonThemeColor,
            borderRadius: BorderRadius.circular(4)
        ),
        child: Text('Add Student',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white
        ),),
      ),
    );
  }

  Widget _clearDBButton(){
    return  GestureDetector(
      onTap: (){
        _dataBaseService.cleanDB();
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
            color:Commons.commonThemeColor,
            borderRadius: BorderRadius.circular(4)
        ),
        child: Text('Clear DB',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white
        ),),
      ),
    );
  }
}
