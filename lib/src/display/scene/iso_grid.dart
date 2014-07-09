part of stagexl_isometric;

/**
 * IsoGrid provides a display grid in the X-Y plane.
 */
class IsoGrid extends IsoPrimitive {

  ////////////////////////////////////////////////////
  //      CONSTRUCTOR
  ////////////////////////////////////////////////////

  IsoGrid ([Map descriptor = null]) : super(descriptor) {
    if (descriptor == null) {
      showOrigin = true;
      gridlines = new Stroke(0, 0xCCCCCC, 0.5);
      cellSize = 25;
      setGridSize(5, 5);
    }
  }

  ////////////////////////////////////////////////////
  //      GRID SIZE
  ////////////////////////////////////////////////////

  List _gSize = [0, 0, 0];

  /**
   * Returns an array containing the width and length of the grid.
   */
  List get gridSize => _gSize;

  /**
   * Sets the number of grid cells in each direction respectively.
   *
   * @param width The number of cells along the x-axis.
   * @param length The number of cells along the y-axis.
   * @param height The number of cells along the z-axis (currently not implemented).
   */
  void setGridSize (int width, int length, [int height = 0]) {
    if (_gSize[0] != width || _gSize[1] != length || _gSize[2] != height) {
      _gSize = [width, length, height];
      invalidateSize();
    }
  }

  ////////////////////////////////////////////////////
  //      CELL SIZE
  ////////////////////////////////////////////////////

  num _cSize = 0;

  num get cellSize => _cSize;

  /**
   * Represents the size of each grid cell.  This value sets both the width, length and height (where applicable) to the same size.
   */
  void set cellSize (num value) {
    if (value < 2) {
      throw new ArgumentError("cellSize must be a positive value greater than 2");
    }

    if (_cSize != value) {
      _cSize = value;
      invalidateSize();
    }
  }

  ////////////////////////////////////////////////////
  //      SHOW ORIGIN
  ////////////////////////////////////////////////////

  bool _bShowOrigin = false;
  bool _showOriginChanged = false;

  /**
   * The origin indicator located at 0, 0, 0.
   */
  IsoOrigin get origin {
    if (_origin == null) {
      _origin = new IsoOrigin();
    }

    return _origin;
  }

  bool get showOrigin => _bShowOrigin;

  /**
   * Flag determining if the origin is visible.
   */
  set showOrigin (bool value) {
    if (_bShowOrigin != value) {
      _bShowOrigin = value;
      _showOriginChanged = true;
      invalidateSize();
    }
  }

  ////////////////////////////////////////////////////
  //      GRID STYLES
  ////////////////////////////////////////////////////

  StrokeBase get gridlines {
    return strokes[0];
  }

  set gridlines (StrokeBase value) {
    strokes = [value];
  }


  IsoOrigin _origin;

  _renderLogic ([bool recursive = true]) { // protected

    if (_showOriginChanged) {
      if (showOrigin) {
        if (contains(origin) == false) {
          addChildAt(origin, 0);
        }
      } else {
        if (contains(origin)) {
          removeChild(origin);
        }
      }

      _showOriginChanged = false;
    }

    super._renderLogic(recursive);
  }

  _drawGeometry() { // protected

    Graphics g = _mainContainer.graphics;
    g.clear();

    var stroke = strokes[0];
    var pt = new Pt();

    int i = 0;
    int m = gridSize[0];
    while (i <= m) {
      pt = IsoMath.isoToScreen(new Pt(_cSize * i));
      g.moveTo(pt.x, pt.y);
      pt = IsoMath.isoToScreen(new Pt(_cSize * i, _cSize * gridSize[1]));
      g.lineTo(pt.x, pt.y);
      i++;
    }

    i = 0;
    m = gridSize[1];
    while (i <= m) {
      pt = IsoMath.isoToScreen(new Pt(0, _cSize * i));
      g.moveTo(pt.x, pt.y);
      pt = IsoMath.isoToScreen(new Pt(_cSize * gridSize[0], _cSize * i));
      g.lineTo(pt.x, pt.y);
      i++;
    }

    if (stroke != null) stroke.apply(g);

    //now add the invisible layer to receive mouse events
    pt = IsoMath.isoToScreen(new Pt(0, 0));
    g.moveTo(pt.x, pt.y);

    pt = IsoMath.isoToScreen(new Pt(_cSize * gridSize[0], 0));
    g.lineTo(pt.x, pt.y);

    pt = IsoMath.isoToScreen(new Pt(_cSize * gridSize[0], _cSize * gridSize[1]));
    g.lineTo(pt.x, pt.y);

    pt = IsoMath.isoToScreen(new Pt(0, _cSize * gridSize[1]));
    g.lineTo(pt.x, pt.y);

    pt = IsoMath.isoToScreen(new Pt(0, 0));
    g.lineTo(pt.x, pt.y);

   // g.fillColor(0x80FF0000);

  }
}