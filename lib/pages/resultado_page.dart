import 'package:ff_quizz_app/pages/home_page.dart';
import 'package:ff_quizz_app/pages/quizz_page.dart';
import 'package:ff_quizz_app/widgets/boton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResultadoPage extends StatelessWidget {

  final int score;

  const ResultadoPage({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFF2D046E),
      body: Container(
        height: size.height * 1,
        child: Column(
          children: <Widget>[

           SizedBox( height: size.height * 0.1 ),

           Center(
             child:  
              SvgPicture.asset(
                "assets/icons.svg",
                width: size.width * 0.25,
                height: size.height * 0.25,  
              ),
           ),

           SizedBox( height: size.height * 0.06 ),


           Text(
             'Result',
             style: TextStyle(
               color: Color(0xFFA20CBE), 
               fontSize: ( size.width < 250 )
                ? 30
                : 45
             ),
           ),

           SizedBox( height: size.height * 0.015  ),

           Text(
             '${score}/10',
             style: TextStyle(
               color: Color(0xFFA20CBE), 
               fontSize: ( size.width < 250 )
                ? 50
                : 70
             ),
           ),

            SizedBox( height: size.height * 0.07  ),

            GestureDetector(
              child: BotonGenerico( texto: 'Restaurar', color: Color(0xFFFFBA00) ),
              onTap: (){
                Navigator.push(
                   context, 
                   MaterialPageRoute(
                     builder: (context) => QuizzPage()
                    )
                  );
              },
            ),

            GestureDetector(
              child: BotonGenerico( texto: 'Salir', color: Color(0xFFA20CBE)  ),
              onTap: (){
                Navigator.push(
                   context, 
                   MaterialPageRoute(
                     builder: (context) => HomePage()
                    )
                  );
              },
            ),

          ],
        ),
      )
    );
  }
}