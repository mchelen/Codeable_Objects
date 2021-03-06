double stemWidth = 200;
double stemHeight=20;

double leafSize=0.5;
double leftLeafRotation=30;
double rightLeafRotation=30;

double flowerSize=1;
double flowerRotation=60;
int petalNum=5;

double rowWidth=105;

void generateVines() {

  Polygon clip =getClip();
  Pattern masterPattern = new Pattern();

  double scarfWidth=clip.getWidth();
  double scarfHeight=clip.getHeight();
  int numOfStems=floor((float)(scarfWidth/stemWidth));
  int numOfRows=ceil((float)(scarfHeight/rowWidth));

  for (int j=0;j<numOfRows;j++) {
    int lastPos=0;
    for (int i=0;i<numOfStems;i++) {
      Pattern leaves = makeLeaves(i);

      leaves.moveBy(j*rowWidth, lastPos);
      lastPos+=stemWidth;
      masterPattern.addCopy(leaves);
    }
  }


  masterPattern.addToScreen();
  masterPattern.setStrokeWeight(2);
  masterPattern.rotate(90);
  masterPattern.centerOrigin();
  clip.centerOrigin();
  clip.moveTo(width/2,height/2);
  masterPattern.moveTo(width/2,height/2);
  masterPattern.clipTo(clip);
 masterPattern.addCopy(clip);
  sc.setZoom(-300);
}


Polygon rLeaf() {
  Pattern pattern = new Pattern();


  Polygon curvePolygon= new Polygon();

  Curve polyCurve = new Curve(0, 0, -11, 150, 50, 75);

  curvePolygon.addCopy(polyCurve);

  curvePolygon.closePoly();
  curvePolygon.setOrigin(curvePolygon.getExtremeBottomPoint());

  return curvePolygon;
}

Polygon lLeaf() {
  Pattern pattern = new Pattern();


  Polygon curvePolygon= new Polygon();

  Curve polyCurve = new Curve(0, 0, 11, 150, -50, 75);

  curvePolygon.addCopy(polyCurve);

  curvePolygon.closePoly();
  curvePolygon.setOrigin(curvePolygon.getExtremeBottomPoint());

  return curvePolygon;
}

Pattern makeFlower(int leafNum) {

  Pattern flower= new Pattern();

  for (int i=0;i<leafNum;i++) {
    Polygon leafR = new Polygon();
    Polygon leafL = new Polygon();


    leafR = rLeaf(); 
    leafR.rotate((10*(i)));

    leafL = lLeaf();      
    leafL.rotate(0-(10*(i)));



    flower.addCopy(leafL);
    flower.addCopy(leafR);
  }


  return flower;
}

Pattern makeLeaves(int direction) {

  Pattern leaves= new Pattern();


  Polygon leftLeaf =  lLeaf();
  Polygon rightLeaf = rLeaf();
  Curve stem= null;
  
  Pattern flower = makeFlower(petalNum);
  if(petalNum>0){
  
  flower.scaleX(0.5);
  flower.scaleY(0.5);

  flower.scaleX(flowerSize);
  flower.scaleY(flowerSize);
  
  flower.setOrigin(0, flower.getHeight()-5);
  }
  if (Geom.isEven(direction)) {
    stem = new Curve(0, 0, 0, stemWidth, 0-stemHeight, stemWidth/2);
    if(petalNum>0){
      flower.rotate(0-flowerRotation);
    }
  }
  else {
    stem = new Curve(0, 0, 0, stemWidth, stemHeight, stemWidth/2);
    if(petalNum>0){
      flower.rotate(flowerRotation);
    }
  }

  rightLeaf.scaleX(leafSize);
  rightLeaf.scaleY(leafSize);

  leftLeaf.scaleX(leafSize);
  leftLeaf.scaleY(leafSize);

  leftLeaf.setOrigin(leftLeaf.getExtremeBottomPoint());
  rightLeaf.setOrigin(rightLeaf.getExtremeBottomPoint());

  rightLeaf.moveTo(stem.getLineAt(10).start);
  leftLeaf.moveTo(stem.getLineAt(10).end);

  flower.moveTo(stem.getLineAt(0).start);

  leftLeaf.rotate(0-leftLeafRotation);
  rightLeaf.rotate(rightLeafRotation);


  leaves.addCopy(rightLeaf);
  leaves.addCopy(leftLeaf);
  leaves.addCopy(stem);
 if(petalNum>0){
  leaves.addCopy(flower);
 }

  return leaves;
}

boolean polygonsLoaded = false; //boolean to verify that the svg was loaded
String filepath= "scarf_template.svg"; //filepath of target svg file
Vector<Polygon>polygons; //list to hold the polygons generated from the svg
Vector<Point> points = new Vector();

Polygon getClip() {


    SVGReader svgReader = new SVGReader(); //initialize the svg reader

    if ( svgReader.readSVGFile( filepath ) ) { //load in the file
    polygons = svgReader.getPolygons();
    polygonsLoaded = true;
    println("Got " + polygons.size() + " polygons from the SVG file");
  }
  else {
    println("ERROR: Failed to parse the SVG file");
  }

  return polygons.get(0); //add the first polygon found to the screen
}

