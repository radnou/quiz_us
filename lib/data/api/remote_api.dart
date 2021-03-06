import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_us/core/failure.dart';
import 'package:quiz_us/data/models/request/question_request.dart';
import 'package:quiz_us/data/models/response/question_response.dart';
import 'package:dio/dio.dart';

//creation du provider
final remoteApiProvider = Provider<RemoteApi>((ref) => RemoteApi());

class RemoteApi {
  static const String url = 'https://opentdb.com/api.php';

  //méthode d'appel de web Service en asynchrone
  // paramètre QuestionRequest
  // retourne une liste de questions
  Future<List<QuestionResponse>> getQuestions(QuestionRequest request) async {
    // appel web Service
    try {
      final response = await Dio().get(url, queryParameters: request.toMap());
      print(response.realUri);
      // Récupération de la réponse

      if (response.statusCode == 200) {
        //conversion du json en map String et dynamic(int, string )
        final data = Map<String, dynamic>.from(response.data);

        // récupération des questions et réponses
        final results = List<Map<String, dynamic>>.from(data['results']);

        if (results.isNotEmpty) {
          List<QuestionResponse> questions;
          // retourne une liste de questionResponse en utilisant la factory de Question Response
          
          return results.map((e) => QuestionResponse.fromMap(e)).toList();
        }
      }
      return [];
      // Gestion des erreurs
    } on DioError catch (err) {
      print(err);
      throw Failure(
          message: err.response?.statusMessage ?? "Something went wrong");
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: "Please check your connection");
    }
  }
}
