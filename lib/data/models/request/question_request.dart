import 'package:equatable/equatable.dart';

class QuestionRequest extends Equatable {
  final String type;
  final int amount;
  final int category;

  const QuestionRequest({
    required this.type,
    required this.amount,
    required this.category,
  });

  @override
  List<Object> get props => [type, amount, category];

  //pour les requêtes, besoin d'une map avec les paramètres dans l'url
  Map<String, dynamic> toMap() {
    final queryParameters = {
      'type': type,
      'amount': amount,
      'category': category,
    };
    return queryParameters;
  }
}
