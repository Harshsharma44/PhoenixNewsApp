import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:untitled5/Loading.dart';
import 'package:untitled5/model.dart';
import 'package:http/http.dart';
import 'package:untitled5/search.dart';
import 'package:untitled5/webview/webview.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled5/Loading.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      theme: ThemeData(

    canvasColor: Colors.black,
    accentColor: Colors.black87,

  ),
      home: LoadingScreen()));
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }

}

class MyAppState extends State<MyApp> {
  @override
void initState() {
    // TODO: implement initState
    super.initState();
    getNewsByQuery("China");
    getNewsBySlider("India");
  }

  var sissi= "";
  TextEditingController oyex = new TextEditingController();
  List<NewsQueryModel> newModelList = <NewsQueryModel>[];
  List<NewsQueryModel> newSlideList = <NewsQueryModel>[];
  getNewsBySlider(String query) async {
    String url =
        "https://newsapi.org/v2/everything?q=$query&sortBy=popularity&apiKey=6ae192c8687d4c0cbccdfa7f17d7d1df";


    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element){
        NewsQueryModel newsModel = NewsQueryModel();
        newsModel = NewsQueryModel.fromMap(element);
        newSlideList.add(newsModel);

        setState(() {
          isLoading = false;
        });

      }

      );
    });
  }

  bool isLoading = true;

 getNewsByQuery(String query) async {
   String url =
"https://newsapi.org/v2/everything?q=$query&sortBy=popularity&apiKey=6ae192c8687d4c0cbccdfa7f17d7d1df";


       Response response = await get(Uri.parse(url));
       Map data = jsonDecode(response.body);
       setState(() {
         data["articles"].forEach((element){
           NewsQueryModel newsModel = NewsQueryModel();
           newsModel = NewsQueryModel.fromMap(element);
           newModelList.add(newsModel);

           setState(() {
             isLoading = false;
           });

         }

         );
       });
 }




  List<String> nk = ['Indian News','World News','Top News'];
  final List items = [Colors.blueAccent, Colors.amberAccent, Colors.yellow , Colors.white];

  @override
  Widget build(BuildContext context) {
   return SafeArea (
       child: Scaffold(

       body: SingleChildScrollView(
         child: Container(
           decoration: BoxDecoration(
             gradient: LinearGradient(
               colors: [Colors.black.withOpacity(0),Colors.white30,Colors.black.withOpacity(0)]
             )
           ),
           child: Column(
             children: <Widget>[
               Padding(padding: EdgeInsets.all(5)),
               Container(
                 margin: EdgeInsets.symmetric(vertical: 2 , horizontal: 10),
                 child: Container(
                   margin: EdgeInsets.only(top: 5),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(20)
                   ),
                   padding: EdgeInsets.only(top: 7),
                   child: Row(
                     children: <Widget>[
                       Padding(padding: EdgeInsets.all(5)),
                       GestureDetector(
                              onTap: (){
                              setState(() {
                                   if(sissi==""){

                                   }
                                   else{
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=> Search(luery: sissi)));

                                   }
                              });
                              },
                             child: Icon(Icons.search)),
                       Padding(padding: EdgeInsets.only(right: 5)),

                       Expanded(
                         child: Container(

                           child: TextField(
                             textInputAction: TextInputAction.search,
                             cursorColor: Colors.white,
                             decoration: InputDecoration(
                               fillColor: Colors.redAccent,
                               hoverColor: Colors.black,


                               label: Icon(Icons.sensors),
                               hintText: "Type any NEWS ",
                               border: InputBorder.none
                             ),

                             controller: oyex,
                             onSubmitted: (utu){
                               setState(() {
                                  sissi = utu;
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Search(luery: sissi)));
                               });
                             },
                           ),
                         ),
                       ),

                     ],
                   ),
                 )
               ),



               Padding(padding: EdgeInsets.all(5)),
               Container(
                 height: 90,
                 color: Colors.white12,
                 alignment: Alignment.center,
                 width: double.infinity,
                 child: Column(
                   children: [
                     Padding(padding: EdgeInsets.all(6)),


                     Row(
                       children: [
                         Padding(padding: EdgeInsets.all(5)),
                         Icon(Icons.category_outlined,
                         color: Colors.white,),
                         Padding(padding: EdgeInsets.all(5)),
                         Container(
                           alignment: Alignment.topLeft,
                           child: AnimatedTextKit(animatedTexts: [  ColorizeAnimatedText("Some Categories: ", textStyle: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold), colors: [Colors.pinkAccent,Colors.black,Colors.white12,Colors.purple])
                           ],
                             repeatForever: true,

                           ),
                         ),
                       ],
                     ),
                     Padding(padding: EdgeInsets.all(3)),
                     Row(
                       children: <Widget>[
                         Padding(padding: EdgeInsets.all(6)),

                         InkWell(
                           child: Text("India",style: TextStyle(fontSize: 20 , color: Colors.white , fontWeight: FontWeight.bold),),
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> Search(luery: "India")));
                           },

                         ),
                         Padding(padding: EdgeInsets.all(6)),
                         InkWell(
                           child: Text("World",style: TextStyle(fontSize: 20 , color: Colors.white , fontWeight: FontWeight.bold),),
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> Search(luery: "World")));
                           },
                         ),
                         Padding(padding: EdgeInsets.all(6)),
                         InkWell(
                           child: Text("Sports",style: TextStyle(fontSize: 20 , color: Colors.white , fontWeight: FontWeight.bold),),
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> Search(luery: "Sports")));
                           },
                         ),
                         Padding(padding: EdgeInsets.all(6)),
                         InkWell(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> Search(luery: "Education")));
                           },
                           child: Text("Education",style: TextStyle(fontSize: 20 , color: Colors.white , fontWeight: FontWeight.bold),),

                         )
                       ],
                     ),
                   ],
                 ),
               ),
               Padding(padding: EdgeInsets.all(5)),
               CarouselSlider(

                   items: newSlideList.map(
                           (item){
                             return Builder(

                                 builder: (BuildContext context){
                                return  InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Webview(item.newsUrl)));

                                  },
                                  child: Container(
                                    width: double.infinity,
                                     child: Stack(
                                       children: <Widget>[
                                         ClipRRect(

                                           child: Image.network(item.newsImg),
                                         ),
                                         Positioned(child:
                                         Container(

                                           decoration: BoxDecoration(
                                             gradient: LinearGradient(
                                               colors: [Colors.greenAccent.withOpacity(0), Colors.pinkAccent]
                                             )
                                           ),
                                             child: Text(
                                               item.newsHead , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold,color: Colors.white),)),left: 0,right: 0,bottom: 10,
                                         )
                                       ],
                                     ),
                                    margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 0),
                                    color: Colors.black,
                                  ),
                                );
                                 }
                             );
                           }
                   ).toList(),
                 options: CarouselOptions(
                   autoPlay: true,
                   height: 250,

                 ),
               ),
             Padding(padding: EdgeInsets.all(5)),

             Padding(padding: EdgeInsets.all(5)),
             Container(
               color: Colors.white12,
               alignment: Alignment.bottomLeft,
                 child: Row(
                   children: [
                     Icon(Icons.newspaper_sharp,color: Colors.white,),
                     Padding(padding: EdgeInsets.all(5)),
                     AnimatedTextKit(animatedTexts: [  ColorizeAnimatedText("Headlines of Today", textStyle: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold), colors: [Colors.pinkAccent,Colors.black,Colors.white12,Colors.purple])
                     ],
                     repeatForever: true,

                     )
                   ],
                 ),
             ),

               Container(
                 margin: EdgeInsets.symmetric(vertical: 0 , horizontal: 0),
                 padding: EdgeInsets.all(5),
                 child: ListView.builder(
                   physics: NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
                   itemCount: newModelList.length,
                     itemBuilder: (context, index){
                     return  InkWell(
                       onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Webview(newModelList[index].newsUrl)));
                       },
                       child:   Container(
                         decoration: BoxDecoration(
                           color: Colors.black
                         ),
                         height: 250,
                         child: Card(
                           margin: EdgeInsets.all(10),
                         shape: RoundedRectangleBorder(
                         borderRadius:  BorderRadius.circular(10),
                         ),

                           child: Stack(
                             children: <Widget>[
                               ClipRRect(

                                   borderRadius: BorderRadius.circular(12),
                                   child:  Container(decoration: BoxDecoration(
                                     color: Colors.black
                                   ),height: 220,width: 400,child: Image.network(newModelList[index].newsImg))


                               ),
                               Positioned(

                                 child: Container(
                                   height: 20,
                                   decoration: BoxDecoration(
                                     gradient: LinearGradient(
                                       colors: [Colors.black12.withOpacity(0),Colors.black87]
                                     )
                                   ),

                                       child: Column(
                                         children: [
                                           Container(

                                             width: double.infinity,
                                             alignment: Alignment.topLeft,
                                             child: Text(
                                              newModelList[index].newsHead.length > 45 ? newModelList[index].newsHead.substring(0,45) : newModelList[index].newsHead,style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold,color: Colors.white),),
                                           ),
                                           Container(

                                             width: double.infinity,
                                               child: Text( newModelList[index].newsDes.length > 80 ? "${newModelList[index].newsDes.substring(0,79)} ... " : newModelList[index].newsDes , style: TextStyle(fontWeight: FontWeight.w400 , color: Colors.white,fontSize: 12)))

                                         ],
                                       ),

                                 ),
                                       bottom: 10, left: 0,right: 0, top: 150,
                               )
                             ],
                           )
                         ),
                       ),
                     );
                     }
                 ),
               )


             ],
           ),
         ),
       ),
     )
    );
  }
}


