import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:untitled5/model.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:untitled5/webview/webview.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class Search extends StatefulWidget {

   String luery;
  Search({required this.luery});


  @override
  State<Search> createState() => _SearchState(oop: luery);
}

class _SearchState extends State<Search> {
String oop;
  _SearchState({required this.oop});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsByQuery(oop);

  }

  TextEditingController oyex = new TextEditingController();
  List<NewsQueryModel> newModelList = <NewsQueryModel>[];
  String sissi = "";
  bool isLoading = true ;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      Padding(padding: EdgeInsets.all(7)),
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
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white12
                        ),
                        child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_outlined)),
                      ),
                      Text("Back to Main Page",style: TextStyle(fontSize: 20),),
                      Padding(padding: EdgeInsets.all(5)),

                    ],
                  )
                )
            ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),

                          ),
                          color: Colors.black,
                          child: Row(
                            children: [
                              Icon(Icons.newspaper_sharp,color: Colors.white,),
                              Padding(padding: EdgeInsets.all(5)),
                              AnimatedTextKit(animatedTexts: [  ColorizeAnimatedText(oop, textStyle: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold), colors: [Colors.pinkAccent,Colors.black,Colors.white12,Colors.purple])
                              ],
                                repeatForever: true,

                              )
                            ],
                          ),
                        ),
                      ),



            Padding(padding: EdgeInsets.all(5)),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 0 , horizontal: 0),
                        padding: EdgeInsets.all(5),
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: newModelList.length,
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Webview(newModelList[index].newsUrl)));

                                },
                                child: Card(
                                    margin: EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:  BorderRadius.circular(10),
                                    ),

                                    child: Stack(
                                      children: <Widget>[
                                        ClipRRect(

                                            borderRadius: BorderRadius.circular(12),
                                            child: Container(decoration: BoxDecoration(
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
                                                    newModelList[index].newsHead.length > 45 ? newModelList[index].newsHead.substring(0,40) : newModelList[index].newsHead,style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold,color: Colors.white),),
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
                              );
                            }
                        ),
                      )
          ])
      )
          )
      ),
    );
  }
}
