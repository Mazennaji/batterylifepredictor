import 'package:flutter/material.dart';
class Settings extends StatelessWidget {
  bool isDarkMode;
  Function(bool) onThemeChanged;
  bool notification;
  Function(bool) onNotificationChange;
  Function resetDefaults;
   Settings({required this.isDarkMode,required this.onThemeChanged,
     required this.notification,required this.onNotificationChange,
     required this.resetDefaults,super.key});

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
        body:Column(
          children: [
            ListTile(
              title:Text('Dark Mode'),
              trailing:Switch(value:isDarkMode,
                onChanged:(val){
                  onThemeChanged(val);
                },),
            ),
            ListTile(
              title:Text('Enable Notifications'),
              trailing:Switch(
                value:notification,
                onChanged:(val){
                 onNotificationChange(val);
                },
              ),
            ),
            ElevatedButton( onPressed:(){
              resetDefaults();
            },child:Text('Reset to default')),
          ],
        )
    );
  }
}
