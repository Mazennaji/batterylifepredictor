import 'package:flutter/material.dart';
import 'Home.dart';
void main()=>runApp(const myapp());
class myapp extends StatelessWidget {
  const myapp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title:'Battery Life Predictor',
      debugShowCheckedModeBanner:false,
      home:Home(),
    );
  }
}