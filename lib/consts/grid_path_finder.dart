import 'dart:collection';
import 'dart:convert';

import 'package:test_work/data/models/cell.dart';

class GridPathFinder {
  List<List<String>> grid;
  Cell start;
  Cell end;

  GridPathFinder(this.grid, this.start, this.end);

  List<Cell> findShortestPath() {
    List<List<bool>> visited = List.generate(grid.length, (index) => List.filled(grid[index].length, false));
    List<List<Cell?>> previous =
        List.generate(grid.length, (index) => List.filled(grid[index].length, Cell(-1, -1)));

    List<Cell> directions = [
      Cell(1, 0),
      Cell(-1, 0),
      Cell(0, 1),
      Cell(0, -1),
      Cell(1, 1),
      Cell(-1, -1),
      Cell(-1, 1),
      Cell(1, -1),
    ];

    Queue<Cell> queue = Queue();
    queue.add(start);
    visited[start.y][start.x] = true;

    while (queue.isNotEmpty) {
      Cell current = queue.removeFirst();

      if (current.x == end.x && current.y == end.y) {
        List<Cell> path = [];
        while (current != start) {
          path.add(current);
          current = previous[current.y][current.x]!;
        }
        path.add(start);
        path = path.reversed.toList();
        return path;
      }

      for (var dir in directions) {
        int newX = current.x + dir.x;
        int newY = current.y + dir.y;

        if (newX >= 0 &&
            newX < grid[0].length &&
            newY >= 0 &&
            newY < grid.length &&
            grid[newY][newX] != 'X' &&
            !visited[newY][newX]) {
          Cell next = Cell(newX, newY);
          queue.add(next);
          visited[newY][newX] = true;
          previous[newY][newX] = current;
        }
      }
    }
    return [];
  }
}

String findShortestPaths(List<Map<String, dynamic>> data) {
  List<Map<String, dynamic>> result = [];

  for (var item in data) {
    List<List<String>> grid = (item['field'] as List).map((row) => (row as String).split('')).toList();
    Cell start = Cell(item['start']['x'], item['start']['y']);
    Cell end = Cell(item['end']['x'], item['end']['y']);

    GridPathFinder pathFinder = GridPathFinder(grid, start, end);
    List<Cell> path = pathFinder.findShortestPath();

    List<Map<String, String>> steps =
        path.map((cell) => {'x': cell.x.toString(), 'y': cell.y.toString()}).toList();

    String pathString = path.map((cell) => '(${cell.x},${cell.y})').join('->');

    result.add({
      'id': item['id'],
      'result': {
        'steps': steps,
        'path': pathString,
      },
    });
  }

  return jsonEncode(result);
}
