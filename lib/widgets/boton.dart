import 'package:flutter/material.dart';


class BotonGenerico extends StatelessWidget {

  final String texto;
  final Color color;

  const BotonGenerico({Key? key, required this.texto,  required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only( top: size.height * 0.025 ),
      height: size.height * 0.07,
      width: size.width * 0.7,
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Center( 
        child: Text( 
          this.texto,
          style: TextStyle( fontSize: 35, color: Colors.white ),
          ),
        ),
    );
  }
}