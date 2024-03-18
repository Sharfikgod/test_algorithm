// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortest_path_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortestPathDTO _$ShortestPathDTOFromJson(Map<String, dynamic> json) =>
    ShortestPathDTO(
      id: json['id'] as String,
      field: (json['field'] as List<dynamic>).map((e) => e as String).toList(),
      start: Map<String, int>.from(json['start'] as Map),
      end: Map<String, int>.from(json['end'] as Map),
    );

Map<String, dynamic> _$ShortestPathDTOToJson(ShortestPathDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'field': instance.field,
      'start': instance.start,
      'end': instance.end,
    };

PointsDTO _$PointsDTOFromJson(Map<String, dynamic> json) => PointsDTO(
      x: json['x'] as String,
      y: json['y'] as String,
    );

Map<String, dynamic> _$PointsDTOToJson(PointsDTO instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };
