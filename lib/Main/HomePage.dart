import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:twenty_four_hours/Authentication/Model/Register.dart';
import 'package:twenty_four_hours/Authentication/UI/WelcomePage.dart';
import 'package:twenty_four_hours/Authentication/auth.dart';
import 'package:twenty_four_hours/Authentication/auth_provider.dart';
import 'package:twenty_four_hours/DatabaseHandling/ExcersiseHandling.dart';
import 'package:twenty_four_hours/DatabaseHandling/UserInformationDB.dart';
import 'package:twenty_four_hours/DatabaseHandling/WorkoutDBHandling.dart';
import 'package:twenty_four_hours/Gym/Models/Achievements.dart';
import 'package:twenty_four_hours/Gym/Models/Exercise.dart';
import 'package:twenty_four_hours/Gym/Models/Workout.dart';
import 'package:twenty_four_hours/Main/Award.dart';
import 'package:twenty_four_hours/Main/Profile.dart';
import 'package:twenty_four_hours/Main/Settings/Setting.dart';
import 'package:twenty_four_hours/Main/Settings/SettingsPage.dart';
import 'package:twenty_four_hours/Main/main.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:twenty_four_hours/Main/DisplayAchivement.dart';
import 'package:twenty_four_hours/NavigationControl.dart';
class HomePage extends StatefulWidget {
  final VoidCallback onSignedOut;
  final Setting setting;
  final String title;

  HomePage({Key key,this.title,this.onSignedOut,this.setting}) : super(key: key);
  HomePagestate createState() => HomePagestate(setting:setting);

  void _signOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;

      await auth.signOut();

      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  FirebaseUser user;
}

class HomePagestate extends State<HomePage> {
  String currentUser = '';
  String result="";
  Setting setting;
  HomePagestate({this.setting});
  Widget app=WaitingScreen();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

          app= Scaffold(
          

            appBar: AppBar(title: Text(user.displayName), actions: <Widget>[
              IconButton(icon: Icon(Icons.settings), onPressed: () {
                NavigationControl(nextPage:new SettingsPage(
                user: userInfo,
                setting:setting)).navTo(context);})
              
            ]),
            body: ListView(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Text(result),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.white)),
                    height: 300,
                    padding: const EdgeInsets.all(10.0),
                  )),
              Align(alignment: Alignment.bottomCenter, child: AddTool())
            ]));

    return app;
       
  }

  StreamSubscription _subscription;
    StreamSubscription _profileSubscription;
    UserInformationDB userInfoDB;
  @override
  void initState() {
     
    _currentUser();
    print("THEME: ${setting.theme}");
    for (int i = 0; i < 7; i++) controllers.add(new TextEditingController());
    eh = new ExcersiseHandling();
    wh=new WorkoutDBHandling();
    userInfoDB=new UserInformationDB();
    print("-----------------------------------");
    eh.getExerciseStream(_updateExcercises).then((StreamSubscription s) => _subscription = s);
    userInfoDB.getUserInfo(_updateUserInfo).then((StreamSubscription s) => _profileSubscription= s);
        super.initState();
      }
    @override
    void dispose()
    {
      if(_subscription!=null)
      _subscription.cancel;
    }
      FirebaseUser user;
      FirebaseAuth Fauth;
      Register userInfo = new Register();
      String UID = '';
      DatabaseReference reference;
    
      Future currentUserInfo() async{
        reference = FirebaseDatabase.instance.reference();
    
        Auth().currentUser().then((uid) {
          reference
              .child("User_Information")
              .child(uid)
              .onChildAdded
              .listen(_onEntryAdded);
          setState(() {
            userInfo = userInfo;
          });
        });
      }
    
      _onEntryAdded(Event event) {
        userInfo = (new Register.fromSnapshot(event.snapshot));
        //   print(userInfo);
      }
    
      Future _currentUser() async {
        user = await FirebaseAuth.instance.currentUser();
        if (user == null)
          setState(() {
            currentUser = 'Guest';
          });
        else
          setState(() {
            currentUser = user.displayName;
          });
      }
    
      List<TextEditingController> controllers = List<TextEditingController>();
      Widget AddTool() {
        return 
            Wrap(
          children: <Widget>[
            TextField(
              controller: controllers[0],
              decoration: InputDecoration(hintText: "Name: "),
            ),
            TextField(
              controller: controllers[1],
              decoration: InputDecoration(hintText: "Describe: "),
            ),
            TextField(
              controller: controllers[2],
              decoration: InputDecoration(hintText: "Tips: "),
            ),
            TextField(
              controller: controllers[3],
              decoration: InputDecoration(hintText: "Muscles: "),
            ),
            TextField(
              controller: controllers[4],
              decoration: InputDecoration(hintText: "Imgurl: "),
            ),
            TextField(
              controller: controllers[5],
              decoration: InputDecoration(hintText: "Level: "),
            )
          ],
        
       
          );
      }
    
      ExcersiseHandling eh;
      WorkoutDBHandling wh;
      void _saveExercise(){
    
     Award a=GymAchievements.MyFitJourney;
    DisplayAchievement(a,new Profile(userinformation: userInfo),context).display();
    
        bool empty = false;
      
        if (!empty) {
          
          Exercise exercise = new Exercise(
            controllers[0].text,
            controllers[1].text,
            controllers[2].text,
            [controllers[3].text],
            controllers[4].text,
            controllers[5].text,
          );
            Workout w=new Workout(
              user.uid,
              [exercise,exercise],
              "Chest Day",
              "",
              "Advanced",
    
            );
            print(w.toJson());
    
          wh.saveWorkout(w);
          eh.saveExcercise(exercise);
          controllers[0].clear();
          controllers[1].clear();
          controllers[2].clear();
          controllers[3].clear();
          controllers[4].clear();
          controllers[5].clear();
        }
         
      }
    
      void _updateExcercises(Exercise exercise) {
     
        setState(() {
        
          if(exercise.name!=null)
              result+=exercise.name+"\n";
            });
      }
    
      void _updateUserInfo(Register reg) {
        setState((){
          userInfo=reg;
        });
        
  }
}
