import 'dart:convert';

class ShortestPath {
  ShortestPath({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  final String id;
  final List<String> field;
  final Map<String, int> start;
  final Map<String, int> end;

  @override
  String toString() {
    return 'ShortestPath = { id:$id, field: ${field.map((e) => e.toString())}, start: ${json.encode(start)}, end: ${json.encode(end)}';
  }
}

class Points {
  Points({
    required this.x,
    required this.y,
  });
  final String x;
  final String y;
}
