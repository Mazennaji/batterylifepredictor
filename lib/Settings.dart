import 'package:flutter/material.dart';
import 'home.dart';
class Settings extends StatefulWidget {
   bool isDarkMode;
   Function(bool) onThemeChanged;
  Settings({required this.isDarkMode,required this.onThemeChanged,super.key});
  @override
  State<Settings> createState() => _SettingsState();
}
class _SettingsState extends State<Settings> {
  late bool currentMode;
  @override
  void initState(){
    super.initState();
    currentMode=widget.isDarkMode;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Settings',style:TextStyle(fontSize:18,color:Colors.white)),
        backgroundColor:Colors.grey,
        centerTitle:true,
        actions: [
          TextButton(onPressed:(){
            Navigator.pop(context);
          },
              child:Text('Home',style:TextStyle(fontSize:18,color:Colors.white),)),
        ],
      ),
      body:ListTile(
        title:Text('Dark Mode'),
        trailing:Switch(value: widget.isDarkMode,
        onChanged:(val){
          widget.onThemeChanged(val);
        },),
      )
    );
  }
}
