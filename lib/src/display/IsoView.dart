part of stagexl_isometric;

/**
 * IsoView is a default view port that provides basic panning and zooming functionality on a given IIsoScene.
 */
class IsoView extends Sprite implements IsoViewBase {

  ///////////////////////////////////////////////////////////////////////////////
  //      CONSTRUCTOR
  ///////////////////////////////////////////////////////////////////////////////

  /**
   * Constructor
   */
  IsoView():super() {

    _sceneContainer = new Sprite();

    _mContainer = new Sprite();
    _mContainer.addChild( _sceneContainer );

    _zoomContainer = new Sprite();
    _zoomContainer.addChild(_mContainer );
    addChild( _zoomContainer );

    _maskShape = new Shape();
    addChild( _maskShape );

    _borderShape = new Shape();
    addChild(_borderShape);

    setSize( 400, 250 );
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      PRECISION
  ///////////////////////////////////////////////////////////////////////////////

  /**
   * Flag indicating if coordinate values are rounded to the nearest whole number or not.
   */
  bool usePreciseValues = false;

  ///////////////////////////////////////////////////////////////////////////////
  //      CURRENT PT
  ///////////////////////////////////////////////////////////////////////////////

  /**
   * @private
   *
   * The targeted point to perform calculations on.
   */
  Pt _targetScreenPt = new Pt(); // protected

  /**
   * @private
   */
  Pt _currentScreenPt = new Pt(); // protected

  /**
   * @inheritDoc
   */
  Pt get currentPt => _currentScreenPt.clone() as Pt;

  //      CURRENT X
  ///////////////////////////////////////////////////////////////////////////////

  num get currentX => _currentScreenPt.x;

  set currentX(num value) {

    if (_currentScreenPt.x != value ) {

      if (_targetScreenPt == null)
        _targetScreenPt = _currentScreenPt.clone() as Pt;

      _targetScreenPt.x = usePreciseValues ? value : value.round();
      _bPositionInvalidated = true;
      if (autoUpdate) isoRender();
    }
  }

  //      CURRENT Y
  ///////////////////////////////////////////////////////////////////////////////

  num get currentY => _currentScreenPt.y;

  set currentY(num value) {

    if (_currentScreenPt.y != value ) {

      if (_targetScreenPt == null)
        _targetScreenPt = _currentScreenPt.clone() as Pt;

      _targetScreenPt.y = usePreciseValues ? value : value.round();
      _bPositionInvalidated = true;

      if (autoUpdate) isoRender();
    }
  }

  Pt localToIso(Point localPt) {
    localPt = localToGlobal( localPt );
    localPt = _mContainer.globalToLocal( localPt );
    return IsoMath.screenToIso( new Pt( localPt.x, localPt.y, 0 ));
  }

  Point isoToLocal(Pt isoPt) {
    isoPt = IsoMath.isoToScreen( isoPt );
    var temp = new Point( isoPt.x, isoPt.y );
    temp = _mContainer.localToGlobal(temp);
    return globalToLocal(temp);
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      INVALIDATION
  ///////////////////////////////////////////////////////////////////////////////

  bool _bPositionInvalidated = false;

  /**
   * Flag indicating if the view is invalidated.  If true, validation will when explicity called.
   */
  bool get isInvalidated => _bPositionInvalidated;

  /**
   * Flags the view as needing validation.
   */
  invalidatePosition() {
    _bPositionInvalidated = true;
  }

  /**
   * Convenience method for determining which scenes are invalidated.
   */
  List getInvalidatedScenes() {
    var a = [];

    for (var scene in _scenesArray ) {
      if (scene.isInvalidated) {
        a.add( scene );
      }
    }

    return a;
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      VALIDATION
  ///////////////////////////////////////////////////////////////////////////////

  isoRender([bool recursive = false]) {
    _preRenderLogic();
    _renderLogic( recursive );
    _postRenderLogic();
  }

  /**
   * Performs any logic prior to executing actual rendering logic on the view.
   */
  _preRenderLogic() {// protected
    dispatchEvent( new IsoEvent( IsoEvent.RENDER ));
  }

  /**
   * Performs actual rendering logic on the view.
   *
   * @param recursive Flag indicating if child scenes render on the view's validation.  Default value is <code>false</code>.
   */
  _renderLogic([bool recursive = false]) { // protected

    if (_bPositionInvalidated) {
      _validatePosition();
      _bPositionInvalidated = false;
    }

    if (recursive) {
      for (var scene in _scenesArray) {
        scene.isoRender(recursive);
      }
    }

    if ( viewRenderers != null && numScenes > 0 ) {
      for(FactoryBase factory in _viewRendererFactories) {
        ViewRendererBase viewRenderer = factory.newInstance();
        viewRenderer.renderView( this );
      }
      
    }
  }

  /**
   * Performs any logic after executing actual rendering logic on the view.
   */
  _postRenderLogic() { // protected
    dispatchEvent( new IsoEvent( IsoEvent.RENDER_COMPLETE ));
  }

  /**
   * Calculates the positional changes and repositions the <code>container</code>.
   */
  _validatePosition() {    // protected
    var dx = _currentScreenPt.x - _targetScreenPt.x;
    var dy = _currentScreenPt.y - _targetScreenPt.y;

    if (limitRangeOfMotion && _romTarget ) {
      var ndx = 0;
      var ndy = 0;

      var rect = _romTarget.getBounds( this );
      var isROMBigger = !_romBoundsRect.containsRect(rect);

      if ( isROMBigger ) {
        if ( dx > 0 ) {
          ndx = min(dx, rect.left.abs());
        } else {
          ndx = -1 * min( dx.abs(), (rect.right - _romBoundsRect.right).abs());
        }

        if ( dy > 0 ) {
          ndy = min( dy, rect.top.abs());
        } else {
          ndy = -1 * min( dy.abs(), (rect.bottom - _romBoundsRect.bottom).abs());
        }
      }

      _targetScreenPt.x = _targetScreenPt.x + dx - ndx;
      _targetScreenPt.y = _targetScreenPt.y + dy - ndy;

      dx = ndx;
      dy = ndy;
    }

    _mContainer.x += dx;
    _mContainer.y += dy;

    var evt = new IsoEvent( IsoEvent.MOVE );
    evt.propName = "currentPt";
    evt.oldValue = _currentScreenPt;

    //store the new value now
    _currentScreenPt = _targetScreenPt.clone() as Pt;

    evt.newValue = _currentScreenPt;
    dispatchEvent(evt);
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      CENTER
  ///////////////////////////////////////////////////////////////////////////////

  /**
   * Flag indicating if property changes immediately trigger validation.
   */
  bool autoUpdate = false;

  void centerOnPt(Pt pt, [bool isIsometrc = true]) {

    var target = pt.clone() as Pt;
    if (isIsometrc) IsoMath.isoToScreen( target );

    if ( !usePreciseValues ) {
      target.x = target.x.round();
      target.y = target.y.round();
      target.z = target.z.round();
    }

    _targetScreenPt = target;
    _bPositionInvalidated = true;
    isoRender();
  }

  void centerOnIso(IsoDisplayObjectBase iso) {
    centerOnPt(iso.isoBounds.centerPt);
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      PAN
  ///////////////////////////////////////////////////////////////////////////////

  void panBy(num xBy, num yBy) {
    _targetScreenPt = _currentScreenPt.clone() as Pt;
    _targetScreenPt.x += xBy;
    _targetScreenPt.y += yBy;
    _bPositionInvalidated = true;
    isoRender();
  }

  void panTo(num xTo, num yTo) {
    _targetScreenPt = new Pt( xTo, yTo );
    _bPositionInvalidated = true;
    isoRender();
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      ZOOM
  ///////////////////////////////////////////////////////////////////////////////

  num get currentZoom => _zoomContainer.scaleX;

  set currentZoom(num value) {
    _zoomContainer.scaleX = _zoomContainer.scaleY = value;
  }

  void zoom(num zFactor) {
    _zoomContainer.scaleX = _zoomContainer.scaleY = zFactor;
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      RESET
  ///////////////////////////////////////////////////////////////////////////////

  void reset() {
    _zoomContainer.scaleX = _zoomContainer.scaleY = 1;
    setSize( _w, _h );

    _mContainer.x = 0;
    _mContainer.y = 0;

    _currentScreenPt = new Pt();
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      VIEW RENDERER
  ///////////////////////////////////////////////////////////////////////////////

  List _viewRendererFactories = [];

  /**
   * An array of view renderers to affect each scene during the render phase.
   */
  List get viewRenderers => _viewRendererFactories;

  set viewRenderers(List value) {
    if ( value != null) {
      var temp = [];

      for each (var obj in value ) {
        if (obj is FactoryBase) {
          temp.push( obj );
        }
      }

      _viewRendererFactories = temp;
      _bPositionInvalidated = true;

        if (autoUpdate) isoRender();

    } else {

      _viewRendererFactories = [];
    }
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      SCENE METHODS
  ///////////////////////////////////////////////////////////////////////////////

  List _scenesArray = []; // protected

  List get scenes => _scenesArray;

  int get numScenes => _scenesArray.length;

  /**
   * Adds a scene to the scene container.
   *
   * @param scene The scene to add.
   */
  void addScene(IsoSceneBase scene) {
    addSceneAt( scene, _scenesArray.length );
  }

  /**
   * Adds a scene to the scene container at the given index.
   *
   * @param scene The scene to add.
   * @param index The index which is assigned to the scene in the scene container.
   */
  void addSceneAt(IsoSceneBase scene, int index) {

    if (containsScene( scene ) == false) {
      _scenesArray.insert(index, scene);
      scene.hostContainer = null;
      _sceneContainer.addChildAt( scene.container, index );
    } else {
      throw new ArgumentError( "IsoView instance already contains parameter scene" );
    }
  }

  /**
   * Determines if a scene is contained within the scene container.
   *
   * @param scene The scene to check for.
   *
   * @return Boolean returns true if the scene is contained within the scene container, false otherwise.
   */
  bool containsScene(IsoSceneBase scene) {

    for (var childScene in _scenesArray ) {
      if ( scene == childScene ) return true;
    }

    return false;
  }

  /**
   * Finds a scene by the target's id.
   *
   * @param id The target scene's id.
   *
   * @return IIsoScene If the target scene is found it will be returned.
   */
  IsoSceneBase getSceneByID(String id) {

    for (var scene in _scenesArray) {
      if ( scene.id == id ) return scene;
    }

    return null;
  }

  /**
   * Removes a target scene from the scenes container.
   *
   * @param scene The target scene to remove.
   * @return IIsoScene If the target scene is successfully removed, it will be returned, otherwise null is returned.
   */
  IsoSceneBase removeScene(IsoSceneBase scene) {

    if (containsScene( scene )) {
      var i = _scenesArray.indexOf( scene );
      _scenesArray.removeAt(i);
      _sceneContainer.removeChild( scene.container );

      return scene;
    } else {

      return null;
    }
  }

  /**
   * Removes all scenes from the scenes container.
   */
  void removeAllScenes() {

    for (var scene in _scenesArray) {
      if (_sceneContainer.contains(scene.container)) {
        _sceneContainer.removeChild( scene.container );
        scene.hostContainer = null;
      }
    }

    _scenesArray = [];
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      SIZE
  ///////////////////////////////////////////////////////////////////////////////

  num _w;
  num _h;

  num get width => _w;
  num get height => _h;

  /**
   * The current size of the IsoView.
   * Returns a Point whose x corresponds to the width and y corresponds to the height.
   */
  Point get size {
    return new Point( _w, _h );
  }

  /**
   * Set the size of the IsoView and repositions child scene objects, masks and borders (where applicable).
   *
   * @param w The width to resize to.
   * @param h The height to resize to.
   */
  void setSize(num w, num h) {
    _w = w.round();
    _h = h.round();

    _romBoundsRect = new Rectangle( 0, 0, _w + 1, _h + 1 );

    // ToDO: scrollRect wird nicht unterstützt!
    //this.scrollRect = _clipContent ? _romBoundsRect : null;

    _zoomContainer.x = _w / 2;
    _zoomContainer.y = _h / 2;
    //_zoomContainer.mask = _clipContent ? _mask : null;

    /* _mask.graphics.clear();
       if (_clipContent)
       {
       _mask.graphics.beginFill(0);
       _mask.graphics.drawRect(0, 0, _w, _h);
       _mask.graphics.endFill();
     } */

     _drawBorder();

     //for testing only - adds crosshairs to view border
    /* _border.graphics.moveTo(0, 0);
       _border.graphics.lineTo(_w, _h);
       _border.graphics.moveTo(_w, 0);
     _border.graphics.lineTo(0, _h); */
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      CLIP CONTENT
  ///////////////////////////////////////////////////////////////////////////////

  bool _clipContent = true;

  bool get clipContent => _clipContent;

  /**
   * Flag indicating where to allow content to visibly extend beyond the boundries of this IsoView.
   */
  set clipContent(bool value) {
    if (_clipContent != value ) {
      _clipContent = value;
      reset();
    }
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      RANGE OF MOTION
  ///////////////////////////////////////////////////////////////////////////////

  DisplayObject _romTarget;    // protected
  Rectangle _romBoundsRect;  // protected

  DisplayObject get rangeOfMotionTarget => _romTarget;

  /**
   * The target used to determine the range of motion when moving the <code>container</code>.
   *
   * @see #limitRangeOfMotion
   */
  set rangeOfMotionTarget(DisplayObject  value) {
    _romTarget = value;
    limitRangeOfMotion = (_romTarget != null);
  }

  /**
   * Flag to limit the range of motion.
   *
   * @see #rangeOfMotionTarget
   */
  bool limitRangeOfMotion = true;

  ///////////////////////////////////////////////////////////////////////////////
  //      CONTAINER STRUCTURE
  ///////////////////////////////////////////////////////////////////////////////

  Sprite _zoomContainer;

  //      MAIN CONTAINER
  ///////////////////////////////////////////////////////////////////////////////

  Sprite _mContainer;  // protected

  /**
   * The main container whose children include the background container, the iso object container and the foreground container.
   *
   * An IsoView's container structure is as follows:
   * * IsoView
   *              * zoom container
   *                      * main container
   *                              * background container
   *                              * iso scenes container
   *                              * foreground container
   */
  Sprite get mainContainer => _mContainer;

  //      BACKGROUND CONTAINER
  ///////////////////////////////////////////////////////////////////////////////

  Sprite _bgContainer;

  /**
   * The container for background elements.
   */
  Sprite get backgroundContainer {

    if (_bgContainer == null) {
      _bgContainer = new Sprite();
      _mContainer.addChildAt(_bgContainer, 0 );
    }

    return _bgContainer;
  }

  //      FOREGROUND CONTAINER
  ///////////////////////////////////////////////////////////////////////////////

  Sprite _fgContainer;

  /**
   * The container for foreground elements.
   */
  Sprite get foregroundContainer {

    if (_fgContainer == null) {
      _fgContainer = new Sprite();
      _mContainer.addChild(_fgContainer);
    }

    return _fgContainer;
  }

  //      BOUNDS & SCENE CONTAINER
  ///////////////////////////////////////////////////////////////////////////////

  Sprite _sceneContainer;
  Shape _maskShape;
  Shape _borderShape;

  /////////////////////////////////////////////////////////////////
  //      SHOW BORDER
  /////////////////////////////////////////////////////////////////

  bool _showBorder = true;

  bool get showBorder => _showBorder;

  set showBorder(bool value) {

    if ( _showBorder != value ) {
      _showBorder = value;
      _drawBorder();
    }
  }

  _drawBorder() {    // protected

    var g = _borderShape.graphics;
    g.clear();

    if (_showBorder) {
      g.rect( 0, 0, _w, _h );
      g.strokeColor(Color.Black);
    }
  }

}