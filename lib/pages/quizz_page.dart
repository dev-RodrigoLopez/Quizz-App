import 'dart:async';
import 'dart:convert';

import 'package:ff_quizz_app/models/preguntas_model.dart';
import 'package:ff_quizz_app/pages/resultado_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;


class QuizzPage extends StatefulWidget {

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}


class _QuizzPageState extends State<QuizzPage> {

  String apiURL = "https://opentdb.com/api.php?amount=10&category=18&difficulty=easy&type=multiple";
  PreguntasModel? preguntas;
  int indexPregunta = 0;
  int totalSeconds = 30;
  int elapsedSeconds = 0;
  int score = 0;
  late Timer timer;

  @override
  void initState() {
    GetAllQuiz();
    super.initState();
  }

  GetAllQuiz() async{

    final response = await http.get( Uri.parse( apiURL ) );
    final resp = jsonDecode( response.body );

    print(resp);

    setState(() {
      preguntas = PreguntasModel.fromJson( resp );
      preguntas!.results[indexPregunta].incorrectAnswers.add(
        preguntas!.results[indexPregunta].correctAnswer
      );  
      preguntas!.results[indexPregunta].incorrectAnswers.shuffle();
      initTimer();
    });
  }

  checkAnswer( answer ){
    String correctAnswer = preguntas!.results[indexPregunta].correctAnswer;
    if( correctAnswer == answer ){
      score += 1;
    }
    else{
      // print("Wrong");
    }
    changeQuestions();
  }

  changeQuestions(){
    timer.cancel(); 
    //Checar si ya es la ultima pregunta
    if( indexPregunta == preguntas!.results.length -1 ){

       Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => ResultadoPage( score: score )
        )
      );
    }
    else{
      setState(() {
        indexPregunta += 1;
      });

      preguntas!.results[indexPregunta].incorrectAnswers.add(
        preguntas!.results[indexPregunta].correctAnswer
      );  
      preguntas!.results[indexPregunta].incorrectAnswers.shuffle();
      initTimer();
    }
  }

  initTimer(){
    timer = Timer.periodic(Duration( 
      seconds: 1 ), 
      (timer) {
        if( timer.tick == totalSeconds ){
          print('Time completed');
          timer.cancel();
          changeQuestions();
        }else{
          setState(() {
            elapsedSeconds = timer.tick;
          });
        }
       }
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    if( preguntas != null ){
      return Scaffold(
      backgroundColor: Color(0xFF2D046E),


        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [

                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 60,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      SvgPicture.asset(
                        "assets/icons.svg",
                        width: 70,
                        height: 70,  
                      ),

                      Text(
                        " $elapsedSeconds S ", 
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 18
                        ),
                      ),

                    ],
                  ),
                ),

                Container( 
                  width: size.width * 0.9,
                  height: size.height * 0.21,
                  // color: Colors.red,
                  child: Text(
                    'Q. ${ preguntas!.results[indexPregunta].question } ',
                    style: TextStyle(
                      fontSize: ( preguntas!.results[indexPregunta].question.length < 50 ) ? 30 : 20, 
                      color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric( horizontal: 30, vertical: 40 ),
                  child: Column(
                    children: preguntas!.results[indexPregunta].incorrectAnswers.map((option){

                      return Container(
                        width:  MediaQuery.of(context).size.width,
                        height: 60,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8
                        ),
                        // padding: const EdgeInsets.symmetric( vertical: 20),

                        child: ElevatedButton(
                          onPressed: (){
                            checkAnswer(option);
                          },
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: ( option.length > 30) ? 20 : 30 
                            ),
                          ), 
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xFF511AA8)),
                            textStyle: MaterialStateProperty.all(const TextStyle( color: Colors.white ))),
                          ),
                      );


                    }).toList(),
                  ),
                )
                


              ],
            ),
          ),
        ),
        
      );
  
    }
    else{

      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );

    }
  }
}