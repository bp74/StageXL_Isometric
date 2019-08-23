part of stagexl_isometric;

/// IsoSprite is the base class in which visual assets may be attached to be presented in 3D isometric space.
/// Since visual assets may not clearly define a volume in 3D isometric space, the developer is responsible for establishing the width, length and height properties.
class IsoSprite extends IsoDisplayObject {
  ////////////////////////////////////////////////////////////
  //      CONSTRUCTOR
  ////////////////////////////////////////////////////////////

  IsoSprite([Map descriptor = null]) : super(descriptor);

  ////////////////////////////////////////////////////////////
  //      SKINS
  ////////////////////////////////////////////////////////////

  List _spritesArray = List(); // protected

  List get sprites => _spritesArray;

  /// An array of visual assets to be attached.
  /// Elements in the array are expected be of type DisplayObject or BitmapData.
  set sprites(List value) {
    if (_spritesArray != value) {
      _spritesArray = value;
      _bSpritesInvalidated = true;
    }
  }

  List _actualSpriteObjects = []; // protected

  List get actualSprites => List.from(_actualSpriteObjects);

  ////////////////////////////////////////////////////////////
  //      INVALIDATION
  ////////////////////////////////////////////////////////////

  bool _bSpritesInvalidated = false;

  /// This method has been deprecated.  Use invalidateSprites instead.
  invalidateSkins() {
    _bSpritesInvalidated = true;
  }

  /// Flags the IsoSprite for invalidation reflecting changes of the spite objects contained in <code>sprites</code>.
  invalidateSprites() {
    _bSpritesInvalidated = true;
  }

  bool get isInvalidated => _bPositionInvalidated || _bSpritesInvalidated;

  ////////////////////////////////////////////////////////////
  //      RENDER
  ////////////////////////////////////////////////////////////

  /// @inheritDoc
  _renderLogic([bool recursive = true]) {
    // protected

    if (_bSpritesInvalidated) {
      _renderSprites();
      _bSpritesInvalidated = false;
    }

    super._renderLogic(recursive);
  }

  _renderSprites() {
    // protected

    //remove all previous skins
    _actualSpriteObjects = [];

    while (_mainContainer.numChildren > 0) _mainContainer.removeChildAt(0);

    for (var spriteObj in _spritesArray) {
      if (spriteObj is BitmapData) {
        var b = Bitmap(spriteObj);
        _mainContainer.addChild(b);
        _actualSpriteObjects.add(b);
      } else if (spriteObj is DisplayObject) {
        _mainContainer.addChild(spriteObj);
        _actualSpriteObjects.add(spriteObj);
      } else {
        throw ArgumentError(
            "skin asset is not of the following types: BitmapData, DisplayObject");
      }
    }
  }

  _createChildren() {
    // protected

    super._createChildren();

    //this is redundant
    //_mainContainer = new Sprite();
    //_attachMainContainerEventListeners();
  }
}
