part of stagexl_isometric;

/// ViewBoundsRenderer is used to draw bounding rectangles to a target graphics object based on the location of the IIsoView's scene's child object relative to the IIsoView.
class ViewBoundsRenderer implements ViewRendererBase {
  /// Flag indicating if all children or only those present in the display list has their bounds drawn.
  bool drawAll = true;

  /// The target graphics to draw the IIsoView's scene's child objects.  Default value is <code>null</code>.
  Graphics targetGraphics;

  /// The line thickness of the bounding rectangles being drawn.  Default value is 0.
  num lineThickness = 0;

  /// The line color of the bounding rectangles being drawn.  Default value is 0xFF0000.
  int lineColor = 0xff0000;

  /// The line alpha of the bounding rectangles being drawn.  Default value is 1.
  num lineAlpha = 1.0;

  ///
  List targetScenes;

  void renderView(IsoViewBase view) {
    if (targetScenes == null || targetScenes.length < 1)
      targetScenes = view.scenes;
    var v = view as Sprite;

    var g = (targetGraphics != null) ? targetGraphics : v.graphics;
    g.clear();

    var bounds;
    var children = [];

    //aggregate child objects
    for (var scene in targetScenes) {
      children.addAll(scene.children);
    }

    for (var child in children) {
      if (drawAll || child.includeInLayout) {
        bounds = child.getBounds(v);
        bounds.width *= view.currentZoom;
        bounds.height *= view.currentZoom;
        g.rect(bounds.x, bounds.y, bounds.width, bounds.height);
        g.strokeColor(lineColor, lineThickness);
      }
    }
  }
}
