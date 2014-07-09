part of stagexl_isometric;

class SimpleSceneLayoutRenderer implements SceneLayoutRendererBase {

  /**
   * Array of propert names to sort scene's children by.  The default value is <code>["y", "x", "z"]</code>.
   */
  List sortOnProps = ["y", "x", "z"];

  ////////////////////////////////////////////////////
  //      RENDER SCENE
  ////////////////////////////////////////////////////

  void renderScene (IsoSceneBase scene) {

    var children = new List.from(scene.displayListChildren);
    //children.sortOn(sortOnProps, Array.NUMERIC);

    // ToDo: implement "sortOn" method workaround

    int i = 0;
    var m = children.length;
    while (i < m) {
      var child = children[i] as IsoDisplayObjectBase;
      if (child.depth != i) {
        scene.setChildIndex(child, i);
      }
      i++;
    }
  }

  /////////////////////////////////////////////////////////////////
  //      COLLISION DETECTION
  /////////////////////////////////////////////////////////////////

  dynamic _collisionDetectionFunc = null;

  dynamic get collisionDetection => _collisionDetectionFunc;

  set collisionDetection (dynamic value) {
    _collisionDetectionFunc = value;
  }
}