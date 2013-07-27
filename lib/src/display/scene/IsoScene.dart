part of stagexl_isometric;

/**
 * IsoScene is a base class for grouping and rendering IIsoDisplayObject children according to their isometric position-based depth.
 */
 class IsoScene extends IsoContainer implements IsoSceneBase {

   ///////////////////////////////////////////////////////////////////////////////
   //      CONSTRUCTOR
   ///////////////////////////////////////////////////////////////////////////////

   /**
    * Constructor
    */
   IsoScene ():super() {
     _layoutObject = new ClassFactory(() => new DefaultSceneLayoutRenderer());
   }

   ///////////////////////////////////////////////////////////////////////////////
  //      BOUNDS
  ///////////////////////////////////////////////////////////////////////////////

  BoundsBase _isoBounds;

  BoundsBase get isoBounds {
    /* if (!_isoBounds || isInvalidated)
            _isoBounds =  */

    return new SceneBounds(this);
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      HOST CONTAINER
  ///////////////////////////////////////////////////////////////////////////////

  DisplayObjectContainer _host; // protected

  DisplayObjectContainer get hostContainer => _host;

  set hostContainer(DisplayObjectContainer value) {

    if (value != null && _host != value) {
      if (_host != null && _host.contains(container)) {
        _host.removeChild(container);
        _ownerObject = null;
       } else if (hasParent) {
          parent.removeChild(this);
       }

      _host = value;
      if (_host != null) {
        _host.addChild(container);
        _ownerObject = _host;
        _parentNode = null;
      }
    }
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      INVALIDATE CHILDREN
  ///////////////////////////////////////////////////////////////////////////////

  /**
   * Array of invalidated children.  Each child dispatches an IsoEvent.INVALIDATION event which notifies
   * the scene that that particular child is invalidated and subsequentally the scene is also invalidated.
   */
  List _invalidatedChildrenArray = [];  // protected

  List get invalidatedChildren => _invalidatedChildrenArray;

  ///////////////////////////////////////////////////////////////////////////////
  //      OVERRIDES
  ///////////////////////////////////////////////////////////////////////////////

  void addChildAt (NodeBase child, int index) {

    if (child is! IsoDisplayObjectBase) {
      throw new ArgumentError ("parameter child is not of type IIsoDisplayObject");
    }

    super.addChildAt(child, index);
    child.addEventListener(IsoEvent.INVALIDATE, _child_invalidateHandler);
    _bIsInvalidated = true; //since the child most likely had fired an invalidation event prior to being added, manually invalidate the scene
  }

  void setChildIndex (NodeBase child, int index) {
    super.setChildIndex(child, index);
    _bIsInvalidated = true;
  }

  NodeBase removeChildByID (String id) {

    var child = super.removeChildByID(id);
    if (child != null) {
      child.removeEventListener(IsoEvent.INVALIDATE, _child_invalidateHandler);
      _bIsInvalidated = true;
    }

    return child;
  }

  void removeAllChildren() {

    for (var child in children) {
      child.removeEventListener(IsoEvent.INVALIDATE, _child_invalidateHandler);
    }

    super.removeAllChildren();
    _bIsInvalidated = true;
  }

  /**
   * Renders the scene as invalidated if a child object is invalidated.
   *
   * @param evt The IsoEvent dispatched from the invalidated child.
   */
  _child_invalidateHandler (IsoEvent evt) {
    var child = evt.target;

    if (_invalidatedChildrenArray.indexOf(child) == -1) {
        _invalidatedChildrenArray.add(child);
    }

    _bIsInvalidated = true;
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      LAYOUT RENDERER
  ///////////////////////////////////////////////////////////////////////////////

  /**
   * Flags the scene for possible layout rendering.
   * If false, child objects are sorted by the order they were added rather than by their isometric depth.
   */
  bool layoutEnabled = true;

  bool _bLayoutIsFactory = true; //flag telling us whether we decided to persist an ISceneLayoutRenderer or using a Factory each time.
  dynamic _layoutObject;

  /**
   * The object used to layout a scene's children.  This value can be either an IFactory or ISceneLayoutRenderer.
   * If the value is an IFactory, then a renderer is created and discarded on each render pass.
   * If the value is an ISceneLayoutRenderer, then a renderer is created and stored.
   * This option infrequently rendered scenes to free up memeory by releasing the factory instance.
   * If this IsoScene is expected be invalidated frequently, then persisting an instance in memory might provide better performance.
   */
  dynamic get layoutRenderer => _layoutObject;

  void _layoutRenderer (dynamic value) {

    if (value == null) {
      _layoutObject = new ClassFactory(() => new DefaultSceneLayoutRenderer());
      _bLayoutIsFactory = true;
      _bIsInvalidated = true;
    }

    if (value != null && _layoutObject != value) {
      if (value is FactoryBase) {
        _bLayoutIsFactory = true;
      } else  if (value is SceneLayoutRendererBase) {
        _bLayoutIsFactory = false;
      } else {
        throw new ArgumentError("value for layoutRenderer is not of type IFactory or ISceneLayoutRenderer");
      }

      _layoutObject = value;
      _bIsInvalidated = true;
    }
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      STYLE RENDERERS
  ///////////////////////////////////////////////////////////////////////////////

  /**
   * Flags the scene for possible style rendering.
   */
  bool stylingEnabled = true;

  List _styleRendererFactories = [];

  List get styleRenderers  => new List.from(_styleRendererFactories);

  /**
   * An array of IFactories whose class generators are ISceneRenderer.
   * If any value contained within the array is not of type IFactory, it will be ignored.
   */
  set styleRenderers (List value) {
    if (value != null) {
      _styleRendererFactories = new List.from(value);
    } else {
      _styleRendererFactories = null;
    }

    _bIsInvalidated = true;
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      INVALIDATION
  ///////////////////////////////////////////////////////////////////////////////

  /**
   * Flags the scene as invalidated during the rendering process
   */
  void invalidateScene () {
    _bIsInvalidated = true;
  }

  ///////////////////////////////////////////////////////////////////////////////
  //      RENDER
  ///////////////////////////////////////////////////////////////////////////////

  /**
   * @inheritDoc
   */
  void _renderLogic ([bool recursive = true]) { // protected

    super._renderLogic(recursive); //push individual changes thru, then sort based on new visible content of each child

    if (_bIsInvalidated) {

      //render the layout first
      if (layoutEnabled) {
        var sceneLayoutRenderer;
        if (_bLayoutIsFactory) {
          sceneLayoutRenderer = (_layoutObject as FactoryBase).newInstance();
        } else {
          sceneLayoutRenderer = _layoutObject as SceneLayoutRendererBase;
        }

        if (sceneLayoutRenderer != null) {
          sceneLayoutRenderer.renderScene(this);
        }
      }

      //fix for bug #20 - http://code.google.com/p/as3isolib/issues/detail?id=20
      if (stylingEnabled && _styleRendererFactories.length > 0) {
        _mainContainer.graphics.clear();
        for (var factory in _styleRendererFactories) {
          var sceneRenderer = factory.newInstance();
          if (sceneRenderer != null) {
            sceneRenderer.renderScene(this);
          }
        }
      }

      _bIsInvalidated = false;
    }
  }

  void _postRenderLogic() { // protected
    _invalidatedChildrenArray = [];

    super._postRenderLogic();
    // should we still call sceneRendered()?
    _sceneRendered();
  }

  /**
   * This function has been deprecated.  Please refer to postRenderLogic.
   */
  void _sceneRendered () { // protected
  }

}