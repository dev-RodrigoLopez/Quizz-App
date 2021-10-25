import 'package:ff_quizz_app/pages/quizz_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //Para cambiar el color de las letras de las opciones de arriba
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      )
    );


    return Scaffold(
      backgroundColor: Color(0xFF2D046E),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

           SizedBox( height: 90 ),

           Center(
             child:  
              SvgPicture.asset(
                "assets/icons.svg",
                width: 250,
                height: 250,  
              ),
           ),

           SizedBox( height: 90 ),


           Text(
             'Quizz',
             style: TextStyle(
               color: Color(0xFFA20CBE), 
               fontSize: 90
             ),
           ),

           Container(
             width: MediaQuery.of(context).size.width,
             margin: EdgeInsets.symmetric(
               horizontal: 30,
               vertical: 40
             ),
             padding: EdgeInsets.symmetric(
               vertical: 10, 
               horizontal: 20
             ),
             child: ElevatedButton(
               onPressed: (){

                 Navigator.push(
                   context, 
                   MaterialPageRoute(
                     builder: (context) => QuizzPage()
                    )
                  );

               }, 
               child: Text(
                 'Play',
                 style: TextStyle(
                   fontSize: 32
                 ),
               ), 
               style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all(Color(0xFFFFBA00)),
                 textStyle: MaterialStateProperty.all(TextStyle( color: Colors.white ))),
               ),
           ),

          ],
        ),
      )
    );
  }
}