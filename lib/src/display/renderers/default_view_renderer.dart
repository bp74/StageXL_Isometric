part of stagexl_isometric;

/// The DefaultViewRenderer iterates through the target view's scene's child objects and determines if they reside within the visible area.
class DefaultViewRenderer implements ViewRendererBase {
  ////////////////////////////////////////////////////
  //      SCENES
  ////////////////////////////////////////////////////

  List _scenesArray = [];

  List get scenes => _scenesArray;

  /// An array of target scenes to be rendered.  If this value's length is 0, then the target view's scenes are used.
  set scenes(List value) {
    _scenesArray = value;
  }

  ////////////////////////////////////////////////////
  //      RENDER SCENE
  ////////////////////////////////////////////////////

  renderView(IsoViewBase view) {
    var targetScenes = (_scenesArray != null && _scenesArray.length >= 1)
        ? _scenesArray
        : view.scenes;
    if (targetScenes.length < 1) return;

    var v = view as Sprite;
    var rect = Rectangle(0, 0, v.width, v.height);
    var bounds;

    List children = [];

    //aggregate child objects
    for (var scene in targetScenes) {
      children.add(scene.children);
    }

    for (var child in children) {
      bounds = child.getBounds(v);
      bounds.width *= view.currentZoom;
      bounds.height *= view.currentZoom;

      //this may be causing run-time error out of bounds exceptions, moving to visible = internally on includeInLayout change
      child.includeInLayout = rect.intersects(bounds);
    }
  }
}
