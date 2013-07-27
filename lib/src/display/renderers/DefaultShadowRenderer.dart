part of stagexl_isometric;

/**
 * The DefaultShadowRenderer class is the default renderer for applying basic shadowing on child objects of an IIsoScene.
 * This is intended to be an iterative renderer meaning the <code>target</code> is expected to be a child object rather than the parent scene.
 */
class DefaultShadowRenderer implements SceneRendererBase {

  ////////////////////////////////////////////////////
  //      STYLES
  ////////////////////////////////////////////////////

  /**
   * If a child's z <= 0 and drawAll = true the shadow will still be renderered.
   */
  bool drawAll = false;

  /**
   * The color of the shadow.
   */
  int shadowColor = 0x000000;

  /**
   * The alpha level of the drawn shadow.
   */
  num shadowAlpha = 0.15;

  ////////////////////////////////////////////////////
  //      RENDER SCENE
  ////////////////////////////////////////////////////

  renderScene (IsoSceneBase scene) {

    _g = scene.container.graphics;
    //g.clear(); - do not clear, may be overwriting other IIsoRenderer's efforts.  Do so in the scene.

    var shadowChildren = scene.displayListChildren;

    for (var child in shadowChildren) {

      if (drawAll) {
        _g.beginPath();
        //g.beginFill(shadowColor, shadowAlpha);
        _drawChildShadow(child);
      } else {
        if (child.z > 0) {
          _g.beginPath();
          //g.beginFill(shadowColor, shadowAlpha);
          _drawChildShadow(child);
        }
      }

      // ToDo: ShadowColor + ShadowAlpha
      _g.fillColor(0x40000000);
    }
  }

  Graphics _g;

  _drawChildShadow (IsoDisplayObject child) {
    var b = child.isoBounds;
    var pt;

    pt = IsoMath.isoToScreen(new Pt(b.left, b.back, 0));
    _g.moveTo(pt.x, pt.y);

    pt = IsoMath.isoToScreen(new Pt(b.right, b.back, 0));
    _g.lineTo(pt.x, pt.y);

    pt = IsoMath.isoToScreen(new Pt(b.right, b.front, 0));
    _g.lineTo(pt.x, pt.y);

    pt = IsoMath.isoToScreen(new Pt(b.left, b.front, 0));
    _g.lineTo(pt.x, pt.y);

    pt = IsoMath.isoToScreen(new Pt(b.left, b.back, 0));
    _g.lineTo(pt.x, pt.y);
  }
}
