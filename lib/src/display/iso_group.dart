part of stagexl_isometric;

class IsoGroup extends IsoDisplayObject implements IsoSceneBase {

  ///////////////////////////////////////////////////////////////////////
  //      CONSTRUCTOR
  ///////////////////////////////////////////////////////////////////////

  IsoGroup([Map descriptor = null]): super(descriptor);

  ///////////////////////////////////////////////////////////////////////
  //      I ISO SCENE
  ///////////////////////////////////////////////////////////////////////

  DisplayObjectContainer get hostContainer => null;

  set hostContainer(DisplayObjectContainer value) {
    //do nothing
  }

  List get invalidatedChildren {
    var a = new List();

    for (NodeBase child in children) {
      if (child is InvalidationBase && (child as InvalidationBase).isInvalidated) {
        a.add(child);
      }
    }

    return a;
  }

  BoundsBase get isoBounds {
    return _bSizeSetExplicitly ? new PrimitiveBounds(this) : new SceneBounds(this);
  }

  ///////////////////////////////////////////////////////////////////////
  //      WIDTH LENGTH HEIGHT
  ///////////////////////////////////////////////////////////////////////

  bool _bSizeSetExplicitly = false;

  void set width(num value) {
    super.width = value;
    _bSizeSetExplicitly = !value.isNaN;
  }

  set length(num value) {
    super.length = value;
    _bSizeSetExplicitly = !value.isNaN;
  }

  set height(num  value) {
    super.height = value;
    _bSizeSetExplicitly = value.isNaN;
  }

  ///////////////////////////////////////////////////////////////////////
  //      ISO GROUP
  ///////////////////////////////////////////////////////////////////////

  SceneLayoutRendererBase renderer = new SimpleSceneLayoutRenderer();

  _renderLogic([bool recursive = true]) { // protected
    super._renderLogic( recursive );

    if (_bIsInvalidated) {
      if (_bSizeSetExplicitly == false) {
        _calculateSizeFromChildren();
      }

      if (renderer == null) {
        renderer = new SimpleSceneLayoutRenderer();
      }

      renderer.renderScene( this );
      _bIsInvalidated = false;
    }
  }

  _calculateSizeFromChildren() { // protected
      var b = new SceneBounds( this );

      _isoWidth = b.width;
      _isoLength = b.length;
      _isoHeight = b.height;
  }
}