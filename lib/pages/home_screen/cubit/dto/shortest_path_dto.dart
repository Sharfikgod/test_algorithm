import 'package:json_annotation/json_annotation.dart';
import 'package:test_work/data/models/shortest_path.dart';

part 'shortest_path_dto.g.dart';

@JsonSerializable()
class ShortestPathDTO {
  ShortestPathDTO({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  final String id;
  final List<String> field;
  final Map<String, int> start;
  final Map<String, int> end;

  Map<String, dynamic> toJson() => _$ShortestPathDTOToJson(this);

  factory ShortestPathDTO.fromJson(Map<String, dynamic> json) => _$ShortestPathDTOFromJson(json);

  ShortestPath toShortestPath() => ShortestPath(
        id: id,
        field: field,
        start: start,
        end: end,
      );
}

@JsonSerializable()
class PointsDTO {
  PointsDTO({
    required this.x,
    required this.y,
  });

  final String x;
  final String y;

  Map<String, dynamic> toJson() => _$PointsDTOToJson(this);

  factory PointsDTO.fromJson(Map<String, dynamic> json) => _$PointsDTOFromJson(json);

  Points toPoints() => Points(
        x: x,
        y: y,
      );
}
