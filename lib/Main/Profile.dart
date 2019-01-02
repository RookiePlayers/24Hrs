import 'package:firebase_database/firebase_database.dart';
import 'package:twenty_four_hours/Authentication/Model/Register.dart';
import 'package:twenty_four_hours/Gym/Models/gym_Profile.dart';
import 'package:twenty_four_hours/LifeStyle/Models/lifestyle_profile.dart';
import 'package:twenty_four_hours/Education/Models/education_profile.dart';
import 'dart:math';
class Profile{
  Register userinformation=null;
  int Xp=1;
  int level=1;
  Profile({this.userinformation});
  
  void increaseXp(int val)
  {
    
    this.Xp+=val;
    
    
  }
  void levelUp()
  {
    this.level=this.level++;
  }
}