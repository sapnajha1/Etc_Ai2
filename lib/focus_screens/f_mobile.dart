
// import 'package:english_ai/const/color.dart';
// import 'package:englishetc_voice_ai/components/Focus.dart';
// import 'package:englishetc_voice_ai/const/color.dart';
import 'package:flutter/material.dart';
import '../components/Article.dart';
import '../components/Focus.dart';
import '../const/color.dart';
import '../constWidget/textwidget.dart';


class f_MobilePage extends StatefulWidget {


  f_MobilePage({required this.article_name_in,required this.article_content, required this.selected_index,required this.selected_index2,required this.fontsize});
  int article_name_in;
  int selected_index;
  int selected_index2;
  List article_content;
  double fontsize;
  @override
  State<f_MobilePage> createState() => _f_MobilePageState();
}

class _f_MobilePageState extends State<f_MobilePage> {

  @override
  Widget build(BuildContext context) {

    var mq= MediaQuery.of(context).size;
    return Scaffold(



        backgroundColor: Colors.white,
        //BODY
        body:
        Column(children:[
          Expanded(
            child:
            SingleChildScrollView(physics: ScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // ARTICLE IMAGE
                              Article_image(height:mq.height*0.08,width:mq.width*0.200, imgurl:'images/games.jpeg',),

                              //// ARTICLE NAME
                              Flexible(child:textwidget( widget.article_content[widget.article_name_in].title,14, FontWeight.bold, Colors.black,),)

                            ],),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[

                                // FOCUS MODE
                                InkWell(onTap:(){Navigator.pop(context);},
                                    child: Focas_container(focustext:"Exit From Focus Mode",fontsize:12,)),

                                const SizedBox(width:3),

                                // INCREASING FONTSIZE


                                Container(height: 35,
                                  child:Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children:[
                                      FloatingActionButton(elevation: 0.0,shape:CircleBorder( ),mini: true,backgroundColor:
                                      widget.selected_index2==1?Color.fromARGB(255, 113, 168, 47):Colors.white,
                                          onPressed:(){setState(() {widget.selected_index2=1;widget.fontsize=19;});},child: textwidget("A",11, FontWeight.w500, Colors.black)),

                                      FloatingActionButton(elevation: 0.0,shape:CircleBorder( ),backgroundColor:
                                      widget.selected_index2==2?Color.fromARGB(255, 113, 168, 47):Colors.white,
                                          onPressed:(){setState(() {widget.selected_index2=2;widget.fontsize=23;});},child: textwidget("A", 15, FontWeight.w500, Colors.black)),

                                      FloatingActionButton(elevation: 0.0,shape:CircleBorder( ),backgroundColor:
                                      widget.selected_index2==3?Color.fromARGB(255, 113, 168, 47):Colors.white,
                                          onPressed:(){setState(() {widget.selected_index2=3;widget.fontsize=27;});},child: textwidget("A", 17, FontWeight.w500, Colors.black)),

                                    ],),
                                ),


                              ]),

                          // LEVEL ROW
                          const SizedBox(height:20),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Container(
                                      width:335,
                                      height:30,

                                      // LEVEL TEXT
                                      child:Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:[
                                            textwidget("Level",15, FontWeight.bold, menu),

                                            //DIFFERENT LEVEL ACCORDING TO THE NUMBERS'S  CONTAINER
                                            Padding(
                                              padding: const EdgeInsets.all(1.0),
                                              child: Container(
                                                // color: Colors.blue,
                                                child:Row(

                                                  children:[

                                                    FloatingActionButton(elevation: 0.0,shape:CircleBorder( ),backgroundColor:
                                                    widget.selected_index==1?Color.fromARGB(255, 113, 168, 47):Colors.white,
                                                        onPressed:(){setState(() {widget.selected_index=1;});},child: textwidget("1", 15, FontWeight.w500, Colors.black)),

                                                    FloatingActionButton(elevation: 0.0,shape:CircleBorder( ),backgroundColor:
                                                    widget.selected_index==2?Color.fromARGB(255, 113, 168, 47):Colors.white,
                                                        onPressed:(){setState(() {widget.selected_index=2;});},child: textwidget("2", 15, FontWeight.w500, Colors.black)),

                                                    FloatingActionButton(elevation: 0.0,shape:CircleBorder( ),backgroundColor:
                                                    widget.selected_index==3?Color.fromARGB(255, 113, 168, 47):Colors.white,
                                                        onPressed:(){setState(() {widget.selected_index=3;});},child: textwidget("3", 15, FontWeight.w500, Colors.black)),

                                                    FloatingActionButton(elevation: 0.0,shape:CircleBorder( ),backgroundColor:
                                                    widget.selected_index==4?Color.fromARGB(255, 113, 168, 47):Colors.white,
                                                        onPressed:(){setState(() {widget.selected_index=4;});},child: textwidget("4", 15, FontWeight.w500, Colors.black)),

                                                    FloatingActionButton(elevation: 0.0,shape:CircleBorder( ),backgroundColor:
                                                    widget.selected_index==5?Color.fromARGB(255, 113, 168, 47):Colors.white,
                                                        onPressed:(){setState(() {widget.selected_index=5;});},child: textwidget("5", 15, FontWeight.w500, Colors.black)),
                                                  ],),
                                              ),
                                            ),
                                          ])),
                                ),


                              ]),
                          // ARTICLE CONTENT

                          SizedBox(height: 40,),
                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                  child:((){
                                    if (widget.selected_index==1){
                                      return  textwidget(widget.article_content[widget.article_name_in].level1,widget.fontsize, FontWeight.w200, Colors.black,);
                                    }
                                    else if (widget.selected_index==2){
                                      return textwidget(widget.article_content[widget.article_name_in].level2,widget.fontsize, FontWeight.w200, Colors.black,);
                                    }
                                    else if (widget.selected_index==3){
                                      return textwidget(widget.article_content[widget.article_name_in].level3,widget.fontsize, FontWeight.w200, Colors.black,);
                                    }
                                    else if (widget.selected_index==4){
                                      return textwidget(widget.article_content[widget.article_name_in].level4,widget.fontsize, FontWeight.w200, Colors.black,);
                                    }
                                    else{
                                      return textwidget(widget.article_content[widget.article_name_in].level5,widget.fontsize, FontWeight.w200, Colors.black,);
                                    }

                                  })()
                              )
                          )




                        ])

                )
            ),
          ),


        ],)
    );
  }
}



//
// // import 'package:english_ai/const/color.dart';
// // import 'package:eng_clone_2/components/article_Img.dart';
// // import 'package:eng_clone_2/components/focus.dart';
// // import 'package:eng_clone_2/constWidget/textWidget.dart';


// // import 'package:eng_clone_2/constants/colors.dart';
// // import 'package:eng_clone_2/screens/article_content.dart';
// import 'package:flutter/material.dart';
//
// import '../article_content.dart';
// import '../components/Article.dart';
// import '../components/Focus.dart';
// import '../const/color.dart';
// import '../constWidget/textwidget.dart';
//
//
// class f_MobilePage extends StatefulWidget {
//
//
//   f_MobilePage({required this.article_name_in, required this.selected_index,required this.selected_index2,required this.fontsize});
//   int article_name_in;
//   int selected_index;
//   int selected_index2;
//   double fontsize;
//   @override
//   State<f_MobilePage> createState() => _f_MobilePageState();
// }
//
// class _f_MobilePageState extends State<f_MobilePage> {
//   // double textsize=17;
//
//   // int selected_index=3;
//   // int selected_index2=1;
//
//   // double fontsize=10;
//
//   // int article_name_in=3;
//   // int widget.article_name_in = widget.article_name_in;
//   // int widget.selected_index = widget.selected_index;
//   // int widget.selected_index2 = widget.selected_index2;
//     // double widget.fontsize = widget.fontsize;
//
//   @override
//   Widget build(BuildContext context) {
//
//     var mq= MediaQuery.of(context).size;
//     return Scaffold(
//
//
//
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
//                               Article_image(height:mq.height*0.08,width:mq.width*0.200, imgurl:articles[widget.article_name_in]['article_image']),
//                               const SizedBox(width:0),
//                               //// ARTICLE NAME
//                               textwidget(articles[widget.article_name_in]['article_name'],19, FontWeight.bold, Colors.black),
//
//                             ],),
//
//                           Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children:[
//
//                                 // FOCUS MODE
//                                 InkWell(onTap:(){Navigator.pop(context);} ,child: Focas_container(focustext:"Exit focus Mode",height:mq.height* 0.050,width:mq.width*0.470,fontsize:14)),
//                                 // const SizedBox(width:1),
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
//
//                                         FloatingActionButton(elevation: 0.0,backgroundColor:
//                                         widget.selected_index2==1?Color.fromARGB(255, 113, 168, 47):Colors.white,
//                                             onPressed:(){setState(() {widget.selected_index2=1;widget.fontsize=19;});},child: textwidget("A", 10, FontWeight.w500, Colors.black)),
//
//                                         FloatingActionButton(elevation: 0.0,backgroundColor:
//                                         widget.selected_index2==2?Color.fromARGB(255, 113, 168, 47):Colors.white,
//                                             onPressed:(){setState(() {widget.selected_index2=2;widget.fontsize=23;});},child: textwidget("A", 15, FontWeight.w500, Colors.black)),
//
//                                         FloatingActionButton(elevation: 0.0,backgroundColor:
//                                         widget.selected_index2==3?Color.fromARGB(255, 113, 168, 47):Colors.white,
//                                             onPressed:(){setState(() {widget.selected_index2=3;widget.fontsize=27;});},child: textwidget("A", 18, FontWeight.w500, Colors.black)),
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
//
//                                                     FloatingActionButton(elevation: 0.0,backgroundColor:
//                                                     widget.selected_index==1?Color.fromARGB(255, 113, 168, 47):Colors.white,
//                                                         onPressed:(){setState(() {widget.selected_index=1;});},child: textwidget("1", 15, FontWeight.w500, Colors.black)),
//
//                                                     FloatingActionButton(elevation: 0.0,backgroundColor:
//                                                     widget.selected_index==2?Color.fromARGB(255, 113, 168, 47):Colors.white,
//                                                         onPressed:(){setState(() {widget.selected_index=2;});},child: textwidget("2", 15, FontWeight.w500, Colors.black)),
//
//                                                     FloatingActionButton(elevation: 0.0,backgroundColor:
//                                                     widget.selected_index==3?Color.fromARGB(255, 113, 168, 47):Colors.white,
//                                                         onPressed:(){setState(() {widget.selected_index=3;});},child: textwidget("3", 15, FontWeight.w500, Colors.black)),
//
//                                                     FloatingActionButton(elevation: 0.0,backgroundColor:
//                                                     widget.selected_index==4?Color.fromARGB(255, 113, 168, 47):Colors.white,
//                                                         onPressed:(){setState(() {widget.selected_index=4;});},child: textwidget("4", 15, FontWeight.w500, Colors.black)),
//
//                                                     FloatingActionButton(elevation: 0.0,backgroundColor:
//                                                     widget.selected_index==5?Color.fromARGB(255, 113, 168, 47):Colors.white,
//                                                         onPressed:(){setState(() {widget.selected_index=5;});},child: textwidget("5", 15, FontWeight.w500, Colors.black)),
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
//                             padding: const EdgeInsets.all(10.0),
//                             child: Container(
//                               child: textwidget(articles[widget.article_name_in]['versions'][widget.selected_index-1],
//                                   widget.fontsize, FontWeight.w400, Colors.black),
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
//
//         ],)
//     );
//   }
// }
