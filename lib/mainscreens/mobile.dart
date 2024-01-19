
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:untitled2/components/api_function/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../api_function/model.dart';
import '../components/Article.dart';
import '../components/Focus.dart';
import '../const/color.dart';
import '../constWidget/textwidget.dart';
import '../focus_screens/f_mobile.dart';
import '../ttsexample.dart';
import 'aap_bar.dart';
import 'package:http/http.dart' as http;


class MobilePage extends StatefulWidget {
  MobilePage({super.key, required this.title, required this.userdata});
  //required this.article_name_in});


  GoogleSignInAccount? userdata;
  final String title;
  // final int article_name_in;

  @override
  State<MobilePage> createState() => _MobilePageState();
}

class _MobilePageState extends State<MobilePage> {
  double textsize=17;

  int selected_index=3;
  int selected_index2=1;
  int article_name_in=0;
  var Paragraph='';
  StreamController _uiChangeStreamController=StreamController();
  // final stt.SpeechToText _speech=stt.SpeechToText();

  bool _isListening=false;
  String _text="";

  @override
  void initState() {
    super.initState();
    fetchData(); // Call the function to fetch data when the widget initializes
  }



  FlutterTts flutterTts = FlutterTts();
  Future<void> speakText(String Paragraph) async {
    final ttsExample = TtsExample(); // Create an instance of the TtsExample class
    await ttsExample.speakText(Paragraph); // Call the speakText function


    // Emit a UI change event to stop the AI
    _uiChangeStreamController.sink.add(null);
  }

  Future<void> stopSpeaking() async {
    await flutterTts.stop(); // Stop TTS
  }


  List<Article_Model> article_content=[];
  Future<void> fetchData() async {
    // try {
    //   final response = await http.get(Uri.parse('https://merd-api.merakilearn.org/englishAi/content/today'));

    //   if (response.statusCode == 200) {
    //     final jsonData = json.decode(response.body)['articles'] as List<dynamic>;

    //     setState(() {
    //       article_content = jsonData
    //           .map((data) => Article_Model.fromJson(data as Map<String, dynamic>))
    //           .toList();
    //     });
    //     print(article_content.length);
    //     print(article_content);
    //     print("hello");
    //   } else {
    //     // Handle error if the API request fails.
    //     print('API request failed with status code: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   print('Error fetching data: $e');
    // }

    try {
      final response= await http.get(Uri.parse('https://merd-api.merakilearn.org/englishAi/content/today'));
      if (response.statusCode==200){
        final responseBody= response.body;
        if (responseBody != null && responseBody.isNotEmpty){
          final jsonData = json.decode(responseBody)['articles'] as List<dynamic>;
          
          setState(() {
            article_content = jsonData.map((data)=> 
            Article_Model.fromJson(data as Map<String, dynamic>)).toList();

          });

          print(article_content.length);
          print(article_content);
          
        }else{
          print('Response body is null or empty');
        }
      } else{print('Api request failed with status code :${response.statusCode}');}
    }catch( error){print("CatchError : ${error}");}
  }


  @override
  Widget build(BuildContext context) {
    var mq= MediaQuery.of(context).size;

    if (article_content.isEmpty){
      return const  Center(child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Loading",
            style: TextStyle(fontSize:15,color:Colors.white),),
          SizedBox(height: 10,),
          CircularProgressIndicator(
            strokeWidth:4.0,
          )
        ],
      ));
    }
    return Scaffold(

      //APPBAR
        appBar: appbar(
          Paragraph: Paragraph,
          userData: widget.userdata,
          appbaricon: Icons.person,
          appbarsize: 16,image_height: 20,image_width: 30,textfont: 18,popupmenu:15, cleanedWord: null, notAvailable: '', score: null,
        ),
        backgroundColor: Colors.white,
        //BODY
        body:
        Column(children:[
          Expanded(
            child:
            SingleChildScrollView(physics: ScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // ARTICLE IMAGE
                              Article_image(height:mq.height*0.05,width:mq.width*0.220, imgurl:'images/games.jpeg', ),

                              // ARTICLE NAME
                              //  Wrap(children:[ Container(width:150,height:50,color:Colors.red,child: textwidget(article_content[article_name_in].title,20, FontWeight.bold, Colors.black))]),
                              Flexible( child: textwidget( article_content[article_name_in].title,14, FontWeight.bold, Colors.black,),)
                            ],),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[

                                // FOCUS MODE
                                InkWell(onTap:(){Navigator.push(context,MaterialPageRoute(builder: (context)=>f_MobilePage(article_name_in: article_name_in, selected_index: selected_index,article_content: article_content, selected_index2: selected_index2,fontsize: textsize,)));} ,
                                    child: Focas_container(focustext:"Enter Focus Mode",fontsize:14,)),
                                // height:mq.height* 0.055,width:mq.width*0.480,

                                // INCREASING FONTSIZE


                                Container(height:30,
                                  child:Row(mainAxisAlignment: MainAxisAlignment.start,

                                    children:[
                                      FloatingActionButton(elevation: 0.0,backgroundColor:
                                      selected_index2==1?Color.fromARGB(255, 113, 168, 47):Colors.white,shape:CircleBorder( ),
                                          onPressed:(){setState(() {selected_index2=1;textsize=20;});},child: textwidget("A", 10, FontWeight.w500, Colors.black)),
                                      FloatingActionButton(elevation: 0.0,backgroundColor:
                                      selected_index2==2?Color.fromARGB(255, 113, 168, 47):Colors.white,shape:CircleBorder( ),
                                          onPressed:(){setState(() {selected_index2=2;textsize=22;});},child: textwidget("A", 15, FontWeight.w500, Colors.black)),
                                      FloatingActionButton(elevation: 0.0,backgroundColor:
                                      selected_index2==3?Color.fromARGB(255, 113, 168, 47):Colors.white,shape:CircleBorder( ),
                                          onPressed:(){setState(() {selected_index2=3;textsize=25;});},child: textwidget("A", 18, FontWeight.w500, Colors.black)),


                                    ],),
                                ),


                              ]),

                          // LEVEL ROW
                          const SizedBox(height:20),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:3),
                                  child: Container(
                                      width:335,
                                      height:30,

                                      // LEVEL TEXT
                                      child:Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:[
                                            textwidget("Level",15, FontWeight.bold, menu),
                                            // SizedBox(width:10),

                                            //DIFFERENT LEVEL ACCORDING TO THE NUMBERS'S  CONTAINER
                                            Padding(
                                              padding: const EdgeInsets.all(1.0),
                                              child: Container(
                                                child:Row(

                                                  children:[
                                                    FloatingActionButton(elevation: 0.0,shape:CircleBorder( ),backgroundColor:
                                                    selected_index==1?Color.fromARGB(255, 113, 168, 47):Colors.white,
                                                        onPressed:(){setState(() {selected_index=1;});},child: textwidget("1", 15, FontWeight.w500, Colors.black)),
                                                    FloatingActionButton(elevation: 0.0,shape:CircleBorder( ),backgroundColor:
                                                    selected_index==2?Color.fromARGB(255, 113, 168, 47):Colors.white,
                                                        onPressed:(){setState(() {selected_index=2;});},child: textwidget("2", 15, FontWeight.w500, Colors.black)),
                                                    FloatingActionButton(elevation: 0.0,shape:CircleBorder( ),backgroundColor:
                                                    selected_index==3?Color.fromARGB(255, 113, 168, 47):Colors.white,
                                                        onPressed:(){setState(() {selected_index=3;});},child: textwidget("3", 15, FontWeight.w500, Colors.black)),
                                                    FloatingActionButton(elevation: 0.0,shape:CircleBorder( ),backgroundColor:
                                                    selected_index==4?Color.fromARGB(255, 113, 168, 47):Colors.white,
                                                        onPressed:(){setState(() {selected_index=4;});},child: textwidget("4", 15, FontWeight.w500, Colors.black)),
                                                    FloatingActionButton(elevation: 0.0,shape:CircleBorder( ),backgroundColor:
                                                    selected_index==5?Color.fromARGB(255, 113, 168, 47):Colors.white,
                                                        onPressed:(){setState(() {selected_index=5;});},child: textwidget("5", 15, FontWeight.w500, Colors.black)),
                                                  ],),
                                              ),
                                            ),
                                          ])),
                                ),


                              ]),

                          // SizedBox(height:20),
                          //
                          // Row(
                          //   children: [
                          //     ElevatedButton(onPressed:(){if (Paragraph != null) {speakText(Paragraph!);}}, child:ImageIcon(
                          //       AssetImage("images/new.png"),)),
                          //     SizedBox(width:15),
                          //     ElevatedButton(onPressed: (){stopSpeaking();}, child:Icon(Icons.air)),
                          //     SizedBox(width:15),
                          //     ElevatedButton(onPressed: (){_startListening();}, child:Icon(Icons.mic)),
                          //     SizedBox(width:15),
                          //     ElevatedButton(onPressed: (){_stopListening();}, child:const Icon(Icons.mic_off)),
                          //   ],
                          // ),

                          //ARTICLE CONTENT

                          SizedBox(height: 20,),
                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                  child:((){
                                    if (selected_index==1){
                                      Paragraph=article_content[article_name_in].level1;

                                      return  textwidget(article_content[article_name_in].level1,textsize, FontWeight.w200, Colors.black,);
                                    }
                                    else if (selected_index==2){
                                      Paragraph=article_content[article_name_in].level2;

                                      return textwidget(article_content[article_name_in].level2,textsize, FontWeight.w200, Colors.black,);
                                    }
                                    else if (selected_index==3){
                                      Paragraph=article_content[article_name_in].level3;

                                      return textwidget(article_content[article_name_in].level3,textsize, FontWeight.w200, Colors.black,);
                                    }
                                    else if (selected_index==4){
                                      Paragraph=article_content[article_name_in].level4;

                                      return textwidget(article_content[article_name_in].level4,textsize, FontWeight.w200, Colors.black,);
                                    }
                                    else{
                                      Paragraph=article_content[article_name_in].level5;

                                      return textwidget(article_content[article_name_in].level5,textsize, FontWeight.w200, Colors.black,);
                                    }

                                  })()
                              )
                          )


                        ])

                )
            ),
          ),

          Container(height: 60,width:mq.width
              ,child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    InkWell(
                        onTap: (){setState((){if(article_name_in>0){article_name_in--;}});}, child: Image.asset("images/left-arrow.png",height:35,width:35)),
                    InkWell(onTap: (){setState((){if(article_name_in<article_content.length-1){article_name_in++;}});},child: Image.asset("images/right-arrow-black-triangle.png",height:35,width:35))
                  ])),
        ],)
    );

  }


//
//
//
// // import 'package:english/focus_screens/f_mobile.dart';
// import 'package:flutter/material.dart';
// import '../article_content.dart';
// import '../components/Article.dart';
// import '../components/Focus.dart';
// import '../const/color.dart';
// import '../constWidget/textwidget.dart';
// import '../focus_screens/f_mobile.dart';
// import 'aap_bar.dart';
//
//
// class MobilePage extends StatefulWidget {
//   const MobilePage({super.key, required this.title, required this.article_name_in});
//
//
//
//   final String title;
//   final int article_name_in;
//
//   @override
//   State<MobilePage> createState() => _MobilePageState();
// }
//
// class _MobilePageState extends State<MobilePage> {
//   double textsize=17;
//
//   int selected_index=3;
//   int selected_index2=1;
//   int article_name_in=0;
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     var mq= MediaQuery.of(context).size;
//     return Scaffold(
//
//       //APPBAR
//         appBar: appbar(
//           appbaricon: Icons.person,
//           appbarsize: 16,midpadding:0,image_height: 20,image_width: 40,textfont: 18,popupmenu: 15,
//         ),
//         backgroundColor: Colors.white,
//         //BODY
//         body:
//         Column(children:[
//           Expanded(
//             child:
//             SingleChildScrollView(physics: ScrollPhysics(),
//                 child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               // ARTICLE IMAGE
//                               Article_image(height:mq.height*0.08,width:mq.width*0.200, imgurl:articles[article_name_in]['article_image']),
//                               const SizedBox(width:20),
//                               //// ARTICLE NAME
//                               textwidget(articles[article_name_in]['article_name'],22, FontWeight.bold, Colors.black),
//
//
//                             ],),
//
//                           Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children:[
//
//                                 // FOCUS MODE
//                                 InkWell(onTap:(){Navigator.push(context,MaterialPageRoute(builder: (context)=>f_MobilePage(article_name_in: article_name_in, selected_index: selected_index, selected_index2: selected_index2,fontsize: textsize,)));} ,child: Focas_container(focustext:"Enter Focus Mode",height:mq.height* 0.050,width:mq.width*0.470,fontsize:14)),
//
//
//                                 // INCREASING FONTSIZE
//
//
//                                 Padding(
//                                   padding: const EdgeInsets.all(1.0),
//                                   child: Container(height:30,
//                                     child:Row(mainAxisAlignment: MainAxisAlignment.start,
//
//                                       children:[
//                                         FloatingActionButton(elevation: 0.0,backgroundColor:
//                                         selected_index2==1?Color.fromARGB(255, 113, 168, 47):Colors.white,
//                                             onPressed:(){setState(() {selected_index2=1;textsize=20;});},child: textwidget("A", 10, FontWeight.w500, Colors.black)),
//                                         FloatingActionButton(elevation: 0.0,backgroundColor:
//                                         selected_index2==2?Color.fromARGB(255, 113, 168, 47):Colors.white,
//                                             onPressed:(){setState(() {selected_index2=2;textsize=22;});},child: textwidget("A", 15, FontWeight.w500, Colors.black)),
//                                         FloatingActionButton(elevation: 0.0,backgroundColor:
//                                         selected_index2==3?Color.fromARGB(255, 113, 168, 47):Colors.white,
//                                             onPressed:(){setState(() {selected_index2=3;textsize=25;});},child: textwidget("A", 18, FontWeight.w500, Colors.black)),
//
//
//                                       ],),
//                                   ),
//                                 ),
//
//
//                               ]),
//
//                           // LEVEL ROW
//                           const SizedBox(height:20),
//                           Row(mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 3),
//                                   child: Container(
//                                       width:335,
//                                       height:30,
//
//                                       // LEVEL TEXT
//                                       child:Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children:[
//                                             textwidget("Level",15, FontWeight.bold, menu),
//                                             SizedBox(width:17),
//
//                                             //DIFFERENT LEVEL ACCORDING TO THE NUMBERS'S  CONTAINER
//                                             Padding(
//                                               padding: const EdgeInsets.all(1.0),
//                                               child: Container(
//                                                 child:Row(
//
//                                                   children:[
//                                                     FloatingActionButton(elevation: 0.0,backgroundColor:
//                                                     selected_index==1?Color.fromARGB(255, 113, 168, 47):Colors.white,
//                                                         onPressed:(){setState(() {selected_index=1;});},child: textwidget("1", 15, FontWeight.w500, Colors.black)),
//                                                     FloatingActionButton(elevation: 0.0,backgroundColor:
//                                                     selected_index==2?Color.fromARGB(255, 113, 168, 47):Colors.white,
//                                                         onPressed:(){setState(() {selected_index=2;});},child: textwidget("2", 15, FontWeight.w500, Colors.black)),
//                                                     FloatingActionButton(elevation: 0.0,backgroundColor:
//                                                     selected_index==3?Color.fromARGB(255, 113, 168, 47):Colors.white,
//                                                         onPressed:(){setState(() {selected_index=3;});},child: textwidget("3", 15, FontWeight.w500, Colors.black)),
//                                                     FloatingActionButton(elevation: 0.0,backgroundColor:
//                                                     selected_index==4?Color.fromARGB(255, 113, 168, 47):Colors.white,
//                                                         onPressed:(){setState(() {selected_index=4;});},child: textwidget("4", 15, FontWeight.w500, Colors.black)),
//                                                     FloatingActionButton(elevation: 0.0,backgroundColor:
//                                                     selected_index==5?Color.fromARGB(255, 113, 168, 47):Colors.white,
//                                                         onPressed:(){setState(() {selected_index=5;});},child: textwidget("5", 15, FontWeight.w500, Colors.black)),
//                                                   ],),
//                                               ),
//                                             ),
//                                           ])),
//                                 ),
//
//
//                               ]),
//                           //ARTICLE CONTENT
//
//                           SizedBox(height: 40,),
//                           Padding(
//                             padding: const EdgeInsets.all(20.0),
//                             child: Container(
//                               child: textwidget(articles[article_name_in]['versions'][selected_index-1],
//                                   textsize, FontWeight.w400, Colors.black),
//                             ),
//                           )
//
//
//                         ])
//
//                 )
//             ),
//           ),
//
//           Container(height: 60,width:mq.width
//               ,child:Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children:[
//                     InkWell(
//                         onTap: (){setState((){if(article_name_in>0){article_name_in--;}});}, child: Image.asset("images/left-arrow.png",height:35,width:35)),
//                     InkWell(onTap: (){setState((){if(article_name_in<4){article_name_in++;}});},child: Image.asset("images/right-arrow-black-triangle.png",height:35,width:35))
//                   ])),
//         ],)
//     );
//   }
// }
}