class Cell {
  int x;
  int y;

  Cell(this.x, this.y);

  @override
  String toString() {
    return '{x: $x, y: $y}';
  }
}
