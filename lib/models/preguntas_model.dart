import 'package:ff_quizz_app/models/pregunta_model.dart';

class PreguntasModel {
  PreguntasModel({
    required this.responseCode,
    required this.results,
  });
  late final int responseCode;
  late final List<Results> results;
  
  PreguntasModel.fromJson(Map<String, dynamic> json){
    responseCode = json['response_code'];
    results = List.from(json['results']).map((e)=>Results.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['response_code'] = responseCode;
    _data['results'] = results.map((e)=>e.toJson()).toList();
    return _data;
  }
}
