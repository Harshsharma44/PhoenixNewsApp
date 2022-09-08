import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled5/main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetStarted();
  }

  void GetStarted() async {
    await Future.delayed(Duration(milliseconds: 5000));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyApp()));


  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(

           body: Center(
          child: Container(
            height: 400,
              decoration: BoxDecoration(
                color: Colors.white
              ),
            child: Column(
              children: <Widget>[

                
                Container(
                  width: 500,
                    height: 200,
                    child:
                    Lottie.asset('Animation/Odin.json')),
                Padding(padding: EdgeInsets.all(5)),
                Container(
                  width: 300,
                  child: Lottie.asset('Animation/Cat.json'),
                ),
                Padding(padding: EdgeInsets.all(5)),
                Container(
                  margin: EdgeInsets.all(10),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      WavyAnimatedText("Phoenix News",textStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, fontFamily: 'Combo')),


                    ],
                  ),
                )
              ],
            ),
              ),
        )
      ),
    );

  }
}
