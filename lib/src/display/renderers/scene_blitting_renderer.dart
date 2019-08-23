part of stagexl_isometric;

class SceneBlittingRenderer implements SceneRendererBase {
  ////////////////////////////////////////////////////
  //      TARGET BITMAP OBJECT
  ////////////////////////////////////////////////////

  Bitmap _targetBitmap;
  dynamic _targetObject;

  dynamic get target => _targetObject;

  set target(dynamic value) {
    if (_targetObject != value) {
      _targetObject = value;

      if (_targetObject is Bitmap) {
        _targetBitmap = _targetObject as Bitmap;
      } /*else if (_targetObject.hasOwnProperty("bitmap")) {
        _targetBitmap = _targetObject.bitmap as Bitmap;
      } */
      else {
        throw IsoError("");
      }
    }
  }

  IsoViewBase view;

  ////////////////////////////////////////////////////
  //      RENDER SCENE
  ////////////////////////////////////////////////////

  void renderScene(IsoSceneBase scene) {
    if (_targetBitmap == null) return;

    var sortedChildren = List.from(scene.displayListChildren);
    sortedChildren
        .sort(_isoDepthSort); //perform a secondary sort for any hittests

    int i = 0;
    int m = sortedChildren.length;

    while (i < m) {
      var child = sortedChildren[i] as IsoDisplayObjectBase;
      if (child.depth != i) scene.setChildIndex(child, i);
      i++;
    }

    var offsetMatrix = Matrix(1, 0, 0, 0, view.width / 2 - view.currentX,
        view.height / 2 - view.currentY);

    var sceneBitmapData = BitmapData(view.width, view.height, 0);
    sceneBitmapData.draw(scene.container, offsetMatrix);

    _targetBitmap.bitmapData = sceneBitmapData;
  }

  ////////////////////////////////////////////////////
  //      SORT
  ////////////////////////////////////////////////////

  int _isoDepthSort(dynamic childA, dynamic childB) {
    var boundsA = childA.isoBounds;
    var boundsB = childB.isoBounds;

    if (boundsA.right <= boundsB.left) return -1;
    if (boundsA.left >= boundsB.right) return 1;
    if (boundsA.front <= boundsB.back) return -1;
    if (boundsA.back >= boundsB.front) return 1;
    if (boundsA.top <= boundsB.bottom) return -1;
    if (boundsA.bottom >= boundsB.top) return 1;
    return 0;
  }
}
