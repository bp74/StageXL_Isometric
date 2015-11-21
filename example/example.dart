library example01;

import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_isometric/stagexl_isometric.dart';

void main() {

  StageXL.stageOptions.renderEngine = RenderEngine.Canvas2D;
  StageXL.stageOptions.backgroundColor = Color.AntiqueWhite;

  var canvas = html.querySelector('#stage');
  var stage = new Stage(canvas);
  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  var background = new Bitmap(new BitmapData(800,600, 0x869ca7));
  stage.addChild(background);

  //var app = new IsoApplication1();
  var app = new IsoApplication2();
  app.x = 400;
  app.y = 200;
  stage.addChild(app);

}

class IsoApplication1 extends Sprite {
  IsoApplication1() {
    var box = new IsoBox();
    box.setSize(25, 25, 25);
    box.moveTo(0, 0, 0);

    var grid = new IsoGrid();
    grid.showOrigin = true;
    grid.setGridSize(10, 10);
    grid.moveTo(0, 0, 0);

    var scene = new IsoScene();
    scene.hostContainer = this;
    scene.addChild(box);
    scene.addChild(grid);
    scene.isoRender();
  }
}

class IsoApplication2 extends Sprite {
  IsoApplication2() {
    var box = new IsoBox();
    box.styleType = RenderStyleType.SHADED;
    box.fills = [
      new SolidColorFill(0xff0000, .5),
      new SolidColorFill(0x00ff00, .5),
      new SolidColorFill(0x0000ff, .5),
      new SolidColorFill(0xff0000, .5),
      new SolidColorFill(0x00ff00, .5),
      new SolidColorFill(0x0000ff, .5)];
    box.setSize(25, 50, 40);
    box.moveTo(0, 0, 0);

    var grid = new IsoGrid();
    grid.showOrigin = true;
    grid.setGridSize(10, 10);
    grid.moveTo(0, 0, 0);

    var scene = new IsoScene();
    scene.hostContainer = this;
    scene.addChild(grid);
    scene.addChild(box);
    scene.isoRender();
  }
}


