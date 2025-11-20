import 'package:batteryappproject/Settings.dart';
import 'package:flutter/material.dart';
import 'home.dart';
void main()=>runApp(const myapp());
class myapp extends StatefulWidget {
  const myapp({super.key});
  @override
  State<myapp> createState() => _myappState();
}
class _myappState extends State<myapp> {
  bool notification=false;
  bool isDarkMode=false;
  void updateTheme(bool val){
    setState(() {
      isDarkMode=val;
    });
  }
  void updateNotification(bool val){
    setState(() {
      notification=val;
    });
  }
  void resetDefault(){
    setState(() {
      isDarkMode=false;
      notification=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Battery Life Predictor',
      debugShowCheckedModeBanner:false,
        initialRoute:'/',
        routes:{
        '/':(context)=>Home(),
          '/settings':(context)=>Settings(isDarkMode:isDarkMode,onThemeChanged:updateTheme,notification:notification,onNotificationChange:updateNotification,resetDefaults:resetDefault,)
        },
        theme:ThemeData.light(),
      darkTheme:ThemeData.dark(),
      themeMode:isDarkMode?ThemeMode.dark:ThemeMode.light,
    );
  }
}