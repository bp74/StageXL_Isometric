part of stagexl_isometric;

/**
 * IsoDisplayObject is the base class that all primitive and complex isometric display objects should extend.
 * Developers should not instantiate this class but rather extend it.
 */

class IsoDisplayObject extends IsoContainer implements IsoDisplayObjectBase {


  /////////////////////////////////////////////////////////
  //      CONSTRUCTOR
  /////////////////////////////////////////////////////////

  IsoDisplayObject([Map descriptor = null]) : super() {
    if (descriptor != null ) {
      _createObjectFromDescriptor( descriptor );
    }
  }

  void _createObjectFromDescriptor(Map descriptor) {
    // ToDo
    throw new Error();
    /*
          var prop:String;
          for ( prop in descriptor )
          {
                  if ( this.hasOwnProperty( prop ) )
                          this[ prop ] = descriptor[ prop ];
          }
    */
  }


  //////////////////////////////////////////////////////////////////
  //      GET RENDER DATA
  //////////////////////////////////////////////////////////////////

  RenderData _cachedRenderData;

  RenderData getRenderData() {

    var r = _mainContainer.getBounds(_mainContainer);

    if (isInvalidated || _cachedRenderData == null ) {

      var flag = _bRenderAsOrphan; //set to allow for rendering regardless of hierarchy
      _bRenderAsOrphan = true;

      isoRender(true);

      var bd = new BitmapData( r.width + 1, r.height + 1, true, 0x000000 );
      bd.draw(_mainContainer, new Matrix( 1, 0, 0, 1, -r.left, -r.top ) );

      var renderData = new RenderData();
      renderData.x = _mainContainer.x + r.left;
      renderData.y = _mainContainer.y + r.top;
      renderData.bitmapData = bd;

      _cachedRenderData = renderData;
      _bRenderAsOrphan = flag; //set back to original

    } else {
      _cachedRenderData.x = _mainContainer.x + r.left;
      _cachedRenderData.y = _mainContainer.y + r.top;
    }

    return _cachedRenderData;
  }

  ////////////////////////////////////////////////////////////////////////
  //      IS ANIMATED
  ////////////////////////////////////////////////////////////////////////

  bool _isAnimated = false;

  get isAnimated => _isAnimated;

  set isAnimated(bool value) {
    _isAnimated = value;
  }

  ////////////////////////////////////////////////////////////////////////
  //      BOUNDS
  ////////////////////////////////////////////////////////////////////////

  BoundsBase _isoBoundsObject;  // protected

  BoundsBase get isoBounds {

    if (_isoBoundsObject == null || isInvalidated) {
      _isoBoundsObject = new PrimitiveBounds(this);
    }

    return _isoBoundsObject;
  }

  Rectangle get screenBounds {

    var screenBounds = _mainContainer.getBounds( _mainContainer );
    screenBounds.x += _mainContainer.x;
    screenBounds.y += _mainContainer.y;

    return screenBounds;
  }

  Rectangle getBounds(DisplayObject targetCoordinateSpace) {

    var rect = screenBounds;
    var pt = new Point( rect.x, rect.y );
    pt = (parent as IsoContainerBase).container.localToGlobal(pt);
    pt = targetCoordinateSpace.globalToLocal(pt);

    rect.x = pt.x;
    rect.y = pt.y;

    return rect;
  }

  num get inverseOriginX {
    return IsoMath.isoToScreen( new Pt( x + width, y + length, z ) ).x;
  }

  num get inverseOriginY {
    return IsoMath.isoToScreen( new Pt( x + width, y + length, z ) ).y;
  }

  /////////////////////////////////////////////////////////
  //      POSITION
  /////////////////////////////////////////////////////////

  ////////////////////////////////////////////////////////////////////////
  //      X, Y, Z
  ////////////////////////////////////////////////////////////////////////

  void moveTo(num x, num y, num z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  void moveBy(num x, num y, num z) {
    this.x += x;
    this.y += y;
    this.z += z;
  }

  ////////////////////////////////////////////////////////////////////////
  //      USE PRECISE VALUES
  ////////////////////////////////////////////////////////////////////////

  /**
   * Flag indicating if positional and dimensional values are rounded to the nearest whole number or not.
   */
  bool usePreciseValues = false;

  ////////////////////////////////////////////////////////////////////////
  //      X
  ////////////////////////////////////////////////////////////////////////

  num _isoX = 0;
  num _oldX = 0;    // protected

  num get x => _isoX;

  set x(num value) {

    if (usePreciseValues == false) {
      value = value.round();
    }

    if (_isoX != value ) {
      _oldX = _isoX;
      _isoX = value;
      invalidatePosition();
      if (autoUpdate) isoRender();
    }
  }

  num get screenX  => IsoMath.isoToScreen( new Pt( x, y, z ) ).x;

  ////////////////////////////////////////////////////////////////////////
  //      Y
  ////////////////////////////////////////////////////////////////////////

  num _isoY = 0;
  num _oldY = 0;  // protected

  num get y => _isoY;

  set y(num value) {

    if (usePreciseValues == false) {
      value =  value.round();
    }

    if (_isoY != value ) {
      _oldY = _isoY;
      _isoY = value;
      invalidatePosition();
      if (autoUpdate) isoRender();
    }
  }

  num get screenY => IsoMath.isoToScreen( new Pt( x, y, z ) ).y;

  ////////////////////////////////////////////////////////////////////////
  //      Z
  ////////////////////////////////////////////////////////////////////////

  num _isoZ = 0;
  num _oldZ = 0;  // protected

  num get z => _isoZ;

  set z(num value) {

    if (usePreciseValues == false) {
      value = value.round();
    }

    if (_isoZ != value ) {
      _oldZ = _isoZ;
      _isoZ = value;
      invalidatePosition();
      if (autoUpdate) isoRender();
    }
  }

  ////////////////////////////////////////////////////////////////////////
  //      WIDTH
  ////////////////////////////////////////////////////////////////////////

  num _dist;

  num get distance => _dist;

  set distance(num value) {
    _dist = value;
  }

  /////////////////////////////////////////////////////////
  //      GEOMETRY
  /////////////////////////////////////////////////////////

  void setSize(num width, num length, num height) {
    this.width = width;
    this.length = length;
    this.height = height;
  }

  ////////////////////////////////////////////////////////////////////////
  //      WIDTH
  ////////////////////////////////////////////////////////////////////////

  num _isoWidth = 0;
  num _oldWidth = 0;  // protected

  num get width => _isoWidth;

  set width(num value) {

    if (usePreciseValues == false) {
      value = value.round();
    }

    value = value.abs();

    if (_isoWidth != value ) {
      _oldWidth = _isoWidth;
      _isoWidth = value;
      invalidateSize();
      if (autoUpdate) isoRender();
    }
  }

  ////////////////////////////////////////////////////////////////////////
  //      LENGTH
  ////////////////////////////////////////////////////////////////////////

  num _isoLength = 0;
  num _oldLength = 0; // protected

  num get length => _isoLength;

  set length(num value) {

    if (usePreciseValues == false) {
      value = value.round();
    }

    value = value.abs();

    if (_isoLength != value ) {
      _oldLength = _isoLength;
      _isoLength = value;
      invalidateSize();
      if (autoUpdate) isoRender();
    }
  }

  ////////////////////////////////////////////////////////////////////////
  //      HEIGHT
  ////////////////////////////////////////////////////////////////////////

  num _isoHeight = 0;
  num _oldHeight = 0; // protected

  num get height => _isoHeight;

  set height(num value) {

    if (usePreciseValues == false) {
      value = value.round();
    }

    value = value.abs();

    if (_isoHeight != value ) {
      _oldHeight = _isoHeight;
      _isoHeight = value;
      invalidateSize();
      if (autoUpdate) isoRender();
    }
  }

  /////////////////////////////////////////////////////////
  //      RENDER AS ORPHAN
  /////////////////////////////////////////////////////////

  bool _bRenderAsOrphan = false;

  bool get renderAsOrphan => _bRenderAsOrphan;

  set renderAsOrphan(bool value) {
    _bRenderAsOrphan = value;
  }

  /////////////////////////////////////////////////////////
  //      RENDERING
  /////////////////////////////////////////////////////////

  /**
   * Flag indicating whether a property change will automatically trigger a render phase.
   */
  bool autoUpdate = false;

  _renderLogic([bool recursive = true]) {   // // protected

    if (!hasParent && !renderAsOrphan) return;

    if (_bPositionInvalidated) {
      _validatePosition();
      _bPositionInvalidated = false;
    }

    if (_bSizeInvalidated) {
      _validateSize();
      _bSizeInvalidated = false;
    }

    //set the flag back for the next time we invalidate the object
    _bInvalidateEventDispatched = false;

    super._renderLogic( recursive );
  }

  ////////////////////////////////////////////////////////////////////////
  //      INCLUDE LAYOUT
  ////////////////////////////////////////////////////////////////////////

  /**
   * @inheritDoc
   */
  /* override public function set includeInLayout (value:Boolean):void
     {
     super.includeInLayout = value;
     if (includeInLayoutChanged)
     {
     if (!bInvalidateEventDispatched)
     {
     dispatchEvent(new IsoEvent(IsoEvent.INVALIDATE));
     bInvalidateEventDispatched = true;
     }
     }
   } */

  /////////////////////////////////////////////////////////
  //      VALIDATION
  /////////////////////////////////////////////////////////

  /**
   * Takes the given 3D isometric coordinates and positions them in cartesian coordinates relative to the parent container.
   */
  _validatePosition() { // protected

    var pt = new Pt( x, y, z );
    IsoMath.isoToScreen( pt );

    _mainContainer.x = pt.x;
    _mainContainer.y = pt.y;

    var evt = new IsoEvent( IsoEvent.MOVE, true );
    evt.propName = "position";
    evt.oldValue = { "x" : _oldX, "y" : _oldY, "z" : _oldZ };
    evt.newValue = { "x" : _isoX, "y" : _isoY, "z" : _isoZ };
    dispatchEvent(evt);
  }

  /**
   * Takes the given 3D isometric sizes and performs the necessary rendering logic.
   */
  _validateSize() {  // protected
    var evt = new IsoEvent( IsoEvent.RESIZE, true );
    evt.propName = "size";
    evt.oldValue = { "width" : _oldWidth, "length" : _oldLength, "height" : _oldHeight };
    evt.newValue = { "width" : _isoWidth, "length" : _isoLength, "height" : _isoHeight };
    dispatchEvent( evt );
  }

  /////////////////////////////////////////////////////////
  //      INVALIDATION
  /////////////////////////////////////////////////////////

  /**
   *
   * Flag indicated that an IsoEvent.INVALIDATE has already been dispatched, negating the need to dispatch another.
   */
  bool _bInvalidateEventDispatched = false;

  bool _bPositionInvalidated = false;
  bool _bSizeInvalidated = false;

  void invalidatePosition() {

    _bPositionInvalidated = true;

    if (_bInvalidateEventDispatched == false) {
      dispatchEvent( new IsoEvent( IsoEvent.INVALIDATE ) );
      _bInvalidateEventDispatched = true;
    }
  }

  void invalidateSize() {

    _bSizeInvalidated = true;

    if (_bInvalidateEventDispatched == false) {
      dispatchEvent( new IsoEvent( IsoEvent.INVALIDATE ) );
      _bInvalidateEventDispatched = true;
    }
  }

  bool get isInvalidated => _bPositionInvalidated || _bSizeInvalidated;

  /////////////////////////////////////////////////////////
  //      CREATE CHILDREN
  /////////////////////////////////////////////////////////

  _createChildren() {   // protected
    super._createChildren();
    //_mainContainer.cacheAsBitmap = _isAnimated;
  }

  /////////////////////////////////////////////////////////
  //      CLONE
  /////////////////////////////////////////////////////////

  dynamic clone() {
    // ToDo

    throw new Error();
    /*
    var CloneClass:Class = getDefinitionByName( getQualifiedClassName( this ) ) as Class;
    var cloneInstance:IIsoDisplayObject = new CloneClass();
    cloneInstance.setSize( isoWidth, isoLength, isoHeight );
    return cloneInstance;
    */
  }

}