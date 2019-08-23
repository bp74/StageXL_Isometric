part of stagexl_isometric;

/// The DefaultSceneLayoutRenderer is the default renderer responsible for performing the isometric position-based depth sorting on the child objects of the target IIsoScene.
class DefaultSceneLayoutRenderer implements SceneLayoutRendererBase {
  // It's faster to make class variables & a method, rather than to do a local function closure
  int _depth;
  Map _visited = Map();
  IsoSceneBase _scene;
  Map _dependency;

  ////////////////////////////////////////////////////
  //      RENDER SCENE
  ////////////////////////////////////////////////////

  void renderScene(IsoSceneBase scene) {
    _scene = scene;
    //int var startTime:uint = getTimer();

    // Rewrite #2 by David Holz, dependency version (naive for now)

    // TODO - cache dependencies between frames, only adjust invalidated objects, keeping old ordering as best as possible
    // IIsoDisplayObject -> [obj that should be behind the key]
    _dependency = Map();

    // For now, use the non-rearranging display list so that the dependency sort will tend to create similar output each pass
    List children = scene.displayListChildren;

    // Full naive cartesian scan, see what objects are behind child[i]
    // TODO - screen space subdivision to limit dependency scan

    int max = children.length;

    for (var i = 0; i < max; ++i) {
      var behind = [];
      var objA = children[i];

      // TODO - direct access ("public var isoX" instead of "function get x") of the object's fields is a TON faster.
      //   Even "final function get" doesn't inline it to direct access, yielding the same speed as plain "function get".
      //   use namespaces to provide raw access?
      //   rename interface class = IsoDisplayObject, concrete class = IsoDisplayObject_impl with public fields?

      //var rightA:Number = objA.isoX + objA.isoWidth;
      //var frontA:Number = objA.isoY + objA.isoLength;
      //var topA:Number = objA.isoZ + objA.isoHeight;

      // TODO - getting bounds objects REALLY slows us down, too.  It creates a new one every time you ask for it!
      var rightA = objA.x + objA.width;
      var frontA = objA.y + objA.length;
      var topA = objA.z + objA.height;

      for (int j = 0; j < max; ++j) {
        var objB = children[j];

        if (_collisionDetectionFunc != null)
          _collisionDetectionFunc.call(null, objA, objB);

        // See if B should go behind A
        // simplest possible check, interpenetrations also count as "behind", which does do a bit more work later, but the inner loop tradeoff for a faster check makes up for it
        if ((objB.x < rightA) &&
            (objB.y < frontA) &&
            (objB.z < topA) &&
            (i != j)) {
          behind.add(objB);
        }
      }

      _dependency[objA] = behind;
    }

    //trace("dependency scan time", getTimer() - startTime, "ms");

    // TODO - set the invalidated children first, then do a rescan to make sure everything
    // else is where it needs to be, too?  probably need to order the invalidated children sets from low to high index

    // Set the childrens' depth, using dependency ordering
    _depth = 0;
    for (var obj in children) {
      if (_visited[obj] == null) {
        place(obj);
      }
    }

    // Clear out temporary dictionary so we're not retaining memory between calls
    _visited = Map();

    // DEBUG OUTPUT

    //trace("--------------------");
    //for (i = 0; i < max; ++i)
    //      trace(dumpBounds(sortedChildren[i].isoBounds), dependency[sortedChildren[i]].length);

    //trace("scene layout render time", getTimer() - startTime, "ms (manual sort)");
  }

  /// Dependency-ordered depth placement of the given objects and its dependencies.
  place(IsoDisplayObject obj) {
    _visited[obj] = true;

    for (var inner in _dependency[obj]) {
      if (_visited[inner] == null) {
        place(inner);
      }
    }

    if (_depth != obj.depth) {
      _scene.setChildIndex(obj, _depth);
      //trace(".");
    }

    ++_depth;
  }

  /////////////////////////////////////////////////////////////////
  //      COLLISION DETECTION
  /////////////////////////////////////////////////////////////////

  // ToDO: make typedef

  dynamic _collisionDetectionFunc = null;

  dynamic get collisionDetection => _collisionDetectionFunc;

  set collisionDetection(dynamic value) {
    _collisionDetectionFunc = value;
  }
}
