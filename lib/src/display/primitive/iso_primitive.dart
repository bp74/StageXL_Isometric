part of stagexl_isometric;

/**
 * IsoPrimitive is the base class for primitive-type classes that will make great use of Flash's drawing API.
 * Developers should not directly instantiate this class but rather extend it or one of the other primitive-type subclasses.
 */
class IsoPrimitive extends IsoDisplayObject implements IsoPrimitiveBase {

  ////////////////////////////////////////////////////////////
  //      CONSTRUCTOR
  ////////////////////////////////////////////////////////////

  IsoPrimitive ([Map descriptor = null]) : super(descriptor) {

    if (descriptor == null) {
      width = DEFAULT_WIDTH;
      length = DEFAULT_LENGTH;
      height = DEFAULT_HEIGHT;
    }
  }

  ////////////////////////////////////////////////////////////////////////
  //      CONSTANTS
  ////////////////////////////////////////////////////////////////////////

  static const num DEFAULT_WIDTH = 25;
  static const num DEFAULT_LENGTH = 25;
  static const num DEFAULT_HEIGHT = 25;

  //////////////////////////////////////////////////////
  // STYLES
  //////////////////////////////////////////////////////

  String _renderStyle = RenderStyleType.SOLID;

  String get styleType => _renderStyle;

  set styleType (String value) {
    if (_renderStyle != value) {
      _renderStyle = value;
      invalidateStyles();

      if (autoUpdate) isoRender();
    }
  }

  //////////////////////////////
  //      MATERIALS
  //////////////////////////////



  //      PROFILE STROKE
  //////////////////////////////

  StrokeBase _pStroke;

  StrokeBase get profileStroke => _pStroke;

  set profileStroke (StrokeBase value) {
    if (_pStroke != value) {
      _pStroke = value;
      invalidateStyles();

      if (autoUpdate) isoRender();
    }
  }

  //      MAIN FILL
  //////////////////////////////

  FillBase get fill => fills[0];

  set fill (FillBase value) {
    fills = [value, value, value, value, value, value];
  }

  //      FILLS
  //////////////////////////////

  static final FillBase DEFAULT_FILL = new SolidColorFill(0xFFFFFFFF, 1);

  List<FillBase> _fillsArray  = new List();

  List<FillBase> get fills => new List<FillBase>.from(_fillsArray);

  void set fills (List value) {
    if (value != null) {
      _fillsArray = new List<FillBase>.from(value);
    } else {
      _fillsArray = new List<FillBase>();
    }

    invalidateStyles();
    if (autoUpdate) isoRender();
  }

  //      MAIN STROKE
  //////////////////////////////

  StrokeBase get stroke => strokes[0];

  set stroke (StrokeBase value) {
    strokes = [value, value, value, value, value, value];
  }

  //      STROKES
  //////////////////////////////

  static final StrokeBase DEFAULT_STROKE = new Stroke(0, 0xFF000000);

  List<StrokeBase> _edgesArray = new List<StrokeBase>();

  List<StrokeBase> get strokes => new List<StrokeBase>.from(_edgesArray);

  set strokes (covariant List<StrokeBase> value) {

    if (value != null) {
      _edgesArray = new List<StrokeBase>.from(value);
    } else {
      _edgesArray = new List<StrokeBase>();
    }

    invalidateStyles();
    if (autoUpdate) isoRender();
  }

  /////////////////////////////////////////////////////////
  //      RENDER
  /////////////////////////////////////////////////////////

  _renderLogic ([bool recursive = true]) { // protected

    if (!hasParent && !renderAsOrphan) return;

    //we do this before calling super.isoRender() so as to only perform drawing logic for the size or style invalidation, not both.
    if (_bSizeInvalidated || _bSytlesInvalidated) {

      if (_validateGeometry() == false) {
        throw new ArgumentError("validation of geometry failed.");
      }

      _drawGeometry();
      _validateSize();

       _bSizeInvalidated = false;
       _bSytlesInvalidated = false;
    }

    super._renderLogic(recursive);
  }

  /////////////////////////////////////////////////////////
  //      VALIDATION
  /////////////////////////////////////////////////////////

  bool _validateGeometry() { // protected
    //overridden by subclasses
    return true;
  }

  void _drawGeometry()  { // protected
    //overridden by subclasses
  }

  ////////////////////////////////////////////////////////////
  //      INVALIDATION
  ////////////////////////////////////////////////////////////

  bool _bSytlesInvalidated = false;

  invalidateStyles() {
    _bSytlesInvalidated = true;

     if (_bInvalidateEventDispatched == false) {
      dispatchEvent(new IsoEvent(IsoEvent.INVALIDATE));
      _bInvalidateEventDispatched = true;
    }
  }

  bool get isInvalidated => (_bSizeInvalidated || _bPositionInvalidated || _bSytlesInvalidated);

  ////////////////////////////////////////////////////////////
  //      CLONE
  ////////////////////////////////////////////////////////////

  dynamic clone() {
    var cloneInstance = super.clone() as IsoPrimitiveBase;
    cloneInstance.fills = fills;
    cloneInstance.strokes = strokes;
    cloneInstance.styleType = styleType;

    return cloneInstance;
  }

}