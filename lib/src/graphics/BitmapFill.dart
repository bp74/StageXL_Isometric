part of stagexl_isometric;

class BitmapFill implements BitmapFillBase {

  ///////////////////////////////////////////////////////////
  //      CONSTRUCTOR
  ///////////////////////////////////////////////////////////

  /**
   * Constructor
   *
   * @param source The target that serves as the context for the fill. Any assignment to a BitmapData, DisplayObject, Class, and String (as a fully qualified class path) are valid.
   * @param orientation The expect orientation of the fill.  Valid values relate to the IsoOrientation constants.
   * @param matrix A user defined matrix for custom transformations.
   * @param colorTransform Used to assign additional custom color transformations to the fill.
   * @param repeat Flag indicating whether to repeat the fill.  If this is false, then the fill will be stretched.
   * @param smooth Flag indicating whether to smooth the fill.
   */
  BitmapFill (dynamic source, [dynamic orientation = null, Matrix matrix = null,
      ColorTransform colorTransform = null, bool repeat = true]) {

    this.source = source;
    this.orientation = orientation;

    if (matrix != null) this.matrix = matrix;

    this.colorTransform = colorTransform;
    this.repeat = repeat;
  }

  ///////////////////////////////////////////////////////////
  //      SOURCE
  ///////////////////////////////////////////////////////////

  BitmapData _bitmapData;
  BitmapDrawable _sourceObject;

  BitmapDrawable get source => _sourceObject;

  /**
   * The source object for the bitmap fill.
   */
  set source(BitmapDrawable value) {

    _sourceObject = value;

    if (value is BitmapData) {
      _bitmapData = value;
    } else if (value is Bitmap) {
      _bitmapData = (value as Bitmap).bitmapData;
    } else if (value is DisplayObject) {
      var bounds = (value as DisplayObject).getBounds(value).align();
      _bitmapData = new BitmapData(bounds.right, bounds.bottom, true, 0);
      _bitmapData.draw(value);
    } else {
      throw new ArgumentError();
    }

    if (_cTransform != null) {
      var rect = new Rectangle(0, 0, _bitmapData.width, _bitmapData.height);
      _bitmapData.colorTransform(rect, _cTransform);
    }
  }

  ///////////////////////////////////////////////////////////
  //      ORIENTATION
  ///////////////////////////////////////////////////////////

  dynamic _orientation = null;
  Matrix _orientationMatrix = null;

  dynamic get orientation => _orientation;

  /**
    * The planar orientation of fill relative to an isometric face.  This can either be a string value enumerated in the IsoOrientation or a matrix.
    */
  set orientation (dynamic value) {

    _orientation = value;
    if (value == null) return;

    if (value is String) {
      if (value == IsoOrientation.XY || value == IsoOrientation.XZ || value == IsoOrientation.YZ) {
        _orientationMatrix = IsoDrawingUtil.getIsoMatrix(value as String);
      } else {
        _orientationMatrix = null;
      }
    } else if (value is Matrix) {
      _orientationMatrix = value;
    } else {
      throw new ArgumentError("value is not of type String or Matrix");
    }
  }

  ///////////////////////////////////////////////////////////
  //      props
  ///////////////////////////////////////////////////////////

  ColorTransform _cTransform = null;

  ColorTransform get colorTransform => _cTransform;

  /**
   * A color transformation applied to the source object.
   */
  set colorTransform (ColorTransform value) {
    _cTransform = value;

    if (_bitmapData != null && _cTransform != null) {
      var rect = new Rectangle(0, 0, _bitmapData.width, _bitmapData.height);
      _bitmapData.colorTransform(rect, _cTransform);
    }
  }

  Matrix _matrixObject;

  /**
   * The transformation matrix applied to the source relative to the isometric face.  This matrix is applied before the orientation adjustments.
   */
  Matrix get matrix => _matrixObject;

  set matrix (Matrix value) {
    _matrixObject = value;
  }

  bool _bRepeat;

  /**
   * A flag indicating whether the bitmap is repeated to fill the area.
   */
  bool get repeat => _bRepeat;

  set repeat (bool value) {
    _bRepeat = value;
  }


  ///////////////////////////////////////////////////////////
  //      IFILL
  ///////////////////////////////////////////////////////////

  var _beginFillBitmapData;
  var _beginFillMatrix;
  var _beginFillRepeat;

  void begin (Graphics target) {

    var m = new Matrix.fromIdentity();

    if (_orientationMatrix != null) {
      m.concat(_orientationMatrix);
    }

    if (matrix != null) {
      m.concat(matrix);
    }

    _beginFillBitmapData = _bitmapData;
    _beginFillMatrix = m;
    _beginFillRepeat = repeat;
  }

  void end (Graphics target) {

    var pattern = _beginFillRepeat
        ? new GraphicsPattern.repeat(_beginFillBitmapData, _beginFillMatrix)
        : new GraphicsPattern.noRepeat(_beginFillBitmapData, _beginFillMatrix);

    target.fillPattern(pattern);
  }

  FillBase clone () {
    return new BitmapFill(source, orientation, matrix, colorTransform, repeat);
  }

}