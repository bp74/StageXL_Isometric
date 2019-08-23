library example01;

import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_isometric/stagexl_isometric.dart';

void main() {
  StageXL.stageOptions.renderEngine = RenderEngine.Canvas2D;
  StageXL.stageOptions.backgroundColor = Color.AntiqueWhite;

  var canvas = html.querySelector('#stage');
  var stage = Stage(canvas);
  var renderLoop = RenderLoop();
  renderLoop.addStage(stage);

  var background = Bitmap(BitmapData(800, 600, 0x869ca7));
  stage.addChild(background);

  //var app = new IsoApplication1();
  //var app = new IsoApplication2();
  var app = IsoApplication3();
  app.x = 400;
  app.y = 200;
  stage.addChild(app);
}

class IsoApplication1 extends Sprite {
  IsoApplication1() {
    var box = IsoBox();
    box.setSize(25, 25, 25);
    box.moveTo(0, 0, 0);

    var grid = IsoGrid();
    grid.showOrigin = true;
    grid.setGridSize(10, 10);
    grid.moveTo(0, 0, 0);

    var scene = IsoScene();
    scene.hostContainer = this;
    scene.addChild(box);
    scene.addChild(grid);
    scene.isoRender();
  }
}

class IsoApplication2 extends Sprite {
  IsoApplication2() {
    var box = IsoBox();
    box.styleType = RenderStyleType.SHADED;
    box.fills = [
      SolidColorFill(0xff0000, .5),
      SolidColorFill(0x00ff00, .5),
      SolidColorFill(0x0000ff, .5),
      SolidColorFill(0xff0000, .5),
      SolidColorFill(0x00ff00, .5),
      SolidColorFill(0x0000ff, .5)
    ];
    box.setSize(25, 50, 40);
    box.moveTo(0, 0, 0);

    var grid = IsoGrid();
    grid.showOrigin = true;
    grid.setGridSize(10, 10);
    grid.moveTo(0, 0, 0);

    var scene = IsoScene();
    scene.hostContainer = this;
    scene.addChild(grid);
    scene.addChild(box);
    scene.isoRender();
  }
}

class IsoApplication3 extends Sprite {
  IsoApplication3() {
    var box = IsoBox();
    box.setSize(25, 25, 25);
    box.fills = [
      SolidColorFill(0xff00ff, 1),
      SolidColorFill(0xff00ff, 1),
      SolidColorFill(0xff00ff, 1),
      SolidColorFill(0xff00ff, 1),
      SolidColorFill(0xff00ff, 1),
      SolidColorFill(0xff00ff, 1)
    ];
    box.moveTo(0, 25, 0);

    var box2 = IsoBox();
    box2.setSize(25, 25, 25);
    box2.fills = [
      SolidColorFill(0xffff00, 1),
      SolidColorFill(0xffff00, 1),
      SolidColorFill(0xffff00, 1),
      SolidColorFill(0xffff00, 1),
      SolidColorFill(0xffff00, 1),
      SolidColorFill(0xffff00, 1)
    ];
    box2.moveTo(25, 25, 0);

    var box3 = IsoBox();
    box3.setSize(25, 25, 25);
    box3.moveTo(25, 0, 0);

    var grid = IsoGrid();
    grid.showOrigin = true;
    grid.setGridSize(10, 10);
    grid.moveTo(0, 0, 0);

    var scene = IsoScene();
    scene.hostContainer = this;
    scene.addChild(grid);

    scene.addChild(box2);
    scene.addChild(box);
    scene.addChild(box3);
    scene.layoutEnabled = true;
    scene.isoRender();
  }
}
