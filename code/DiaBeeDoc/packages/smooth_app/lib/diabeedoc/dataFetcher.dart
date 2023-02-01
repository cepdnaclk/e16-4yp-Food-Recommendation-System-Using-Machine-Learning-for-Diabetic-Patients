import 'dart:convert';
import 'package:openfoodfacts/model/Product.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/model/Nutrient.dart';
import 'package:openfoodfacts/model/PerSize.dart';
import 'package:http/http.dart' as http;

Future<PredictionResult> fetchPredictData(Product product) async {
  final url = "https://foodtesting.centralus.inference.ml.azure.com/score";
  final _token = "dgtqpN3fW7tB0sSsjgC2dOsSqMtLb3KS";
  final headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $_token",
    'azureml-model-deployment': 'default',
  };
  final RequestData body = RequestData(product);
  final response =
      await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return PredictionResult.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load results');
  }
}

class RequestData {
  Product product;
  late Nutriments? nutritions;
  double? energry;
  double? proteins;
  double? fats;
  double? carbs;
  double? fiber;
  double? sugar;
  double? phosphorus;
  double? potassium;
  double? sodium;
  double? satFat;
  double? transFat;

  RequestData(this.product) {
    this.nutritions = this.product.nutriments;
    this.energry = this
            .nutritions
            ?.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams) ??
        0.0;
    this.proteins =
        this.nutritions?.getValue(Nutrient.proteins, PerSize.oneHundredGrams) ??
            0.0;
    this.fats =
        this.nutritions?.getValue(Nutrient.fat, PerSize.oneHundredGrams) ?? 0.0;
    ;
    this.carbs = this
            .nutritions
            ?.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams) ??
        0.0;
    this.fiber =
        this.nutritions?.getValue(Nutrient.fiber, PerSize.oneHundredGrams) ??
            0.0;
    this.sugar =
        this.nutritions?.getValue(Nutrient.sugars, PerSize.oneHundredGrams) ??
            0.0;
    this.phosphorus = this
            .nutritions
            ?.getValue(Nutrient.phosphorus, PerSize.oneHundredGrams) ??
        0.0;
    this.potassium = this
            .nutritions
            ?.getValue(Nutrient.potassium, PerSize.oneHundredGrams) ??
        0.0;
    this.sodium =
        this.nutritions?.getValue(Nutrient.sodium, PerSize.oneHundredGrams) ??
            0.0;
    this.satFat = this
            .nutritions
            ?.getValue(Nutrient.saturatedFat, PerSize.oneHundredGrams) ??
        0.0;
    this.transFat =
        this.nutritions?.getValue(Nutrient.transFat, PerSize.oneHundredGrams) ??
            0.0;
  }
  Map toJson() => {
        'data': [
          this.energry,
          this.proteins,
          this.fats,
          this.carbs,
          this.fiber,
          this.sugar,
          this.phosphorus,
          this.potassium,
          this.sodium,
          this.satFat,
          this.transFat
        ]
      };
}

class PredictionResult {
  final int response;
  const PredictionResult({required this.response});

  factory PredictionResult.fromJson(List<dynamic> json) {
    return PredictionResult(
      response: json[0],
    );
  }
}