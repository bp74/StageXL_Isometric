part of stagexl_isometric;

class IsoHexGrid extends IsoGrid {

  IsoHexGrid([Map descriptor = null]) : super(descriptor);

  void _drawGeometry() {  // protected

    Graphics g = _mainContainer.graphics;
    g.clear();

    var stroke = strokes[0] as StrokeBase;
    if (stroke != null) stroke.apply(g);

    var pts = _generatePts();
    for (var pt in pts)
      _drawHexagon(pt, g);
  }

  List _generatePts() {

    List pts = [];
    num xOffset = cellSize * cos(PI / 3);
    num yOffset = cellSize * sin(PI / 3);

    int i,j;
    int m = gridSize[0];
    int n = gridSize[1];

    while (j < n) {
      i = 0;
      while (i < m) {
        var pt = new Pt();
        pt.x = i * (cellSize + xOffset);
        pt.y = j * yOffset * 2;
        if (i % 2 > 0) pt.y += yOffset;
        pts.add(pt);
        i++;
      }
      j++;
    }

    return pts;
  }

  void _drawHexagon (Pt startPt, Graphics g) {

    var pt0 = startPt.clone();
    var pt1 = Pt.polar(pt0, cellSize, 0);
    var pt2 = Pt.polar(pt1, cellSize, PI / 3);
    var pt3 = Pt.polar(pt2, cellSize, 2 * PI / 3);
    var pt4 = Pt.polar(pt3, cellSize, PI);
    var pt5 = Pt.polar(pt4, cellSize, 4 * PI / 3);

    var pts = [pt0, pt1, pt2, pt3, pt4, pt5];

    for (var pt in pts) {
      IsoMath.isoToScreen(pt);
    }

    var random = new Random();

    g.beginPath();
    g.moveTo(pt0.x, pt0.y);
    g.lineTo(pt1.x, pt1.y);
    g.lineTo(pt2.x, pt2.y);
    g.lineTo(pt3.x, pt3.y);
    g.lineTo(pt4.x, pt4.y);
    g.lineTo(pt5.x, pt5.y);
    g.lineTo(pt0.x, pt0.y);
    g.fillColor(0xFF000000 + random.nextInt(0xFFFFFF));
  }
}