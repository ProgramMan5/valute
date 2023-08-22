// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestData _$RequestDataFromJson(Map<String, dynamic> json) => RequestData(
      date: json['Date'] as String,
      previousDate: json['PreviousDate'] as String,
      previousURL: json['PreviousURL'] as String,
      timestamp: json['Timestamp'] as String,
      valute: (json['Valute'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, CurrencyData.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$RequestDataToJson(RequestData instance) =>
    <String, dynamic>{
      'Date': instance.date,
      'PreviousDate': instance.previousDate,
      'PreviousURL': instance.previousURL,
      'Timestamp': instance.timestamp,
      'Valute': instance.valute.map((k, e) => MapEntry(k, e.toJson())),
    };