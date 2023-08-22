import 'package:json_annotation/json_annotation.dart';
import 'package:valute/domain/currency_data/currency_data.dart';
part 'request_data.g.dart';


@JsonSerializable(explicitToJson: true)
class RequestData {
  @JsonKey(name: 'Date')
  final String date;
  @JsonKey(name: 'PreviousDate')
  final String previousDate;
  @JsonKey(name: 'PreviousURL')
  final String previousURL;
  @JsonKey(name: 'Timestamp')
  final String timestamp;
  @JsonKey(name: 'Valute')
  final Map<String,CurrencyData> valute;

  RequestData({
    required this.date,
    required this.previousDate,
    required this.previousURL,
    required this.timestamp,
    required this.valute,
  });
  factory RequestData.fromJson(Map<String, dynamic> json) => _$RequestDataFromJson(json);
}