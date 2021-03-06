Pattern makeRorsch(int pathLength, double distance){

Pattern turtlePattern = new Pattern(); //initializing a pattern primitive
 
 Vector< Point > path = new Vector< Point >();

 int minAngleRange = 5;
 int maxAngleRange = 150;
 for(int i=0; i<pathLength; i++){
   double angle = random(-map(i,0,pathLength,minAngleRange,maxAngleRange),map(i,0,pathLength,minAngleRange,maxAngleRange));
   turtlePattern.forward( distance ); //drawing with a turtle in a pattern (you can also draw with the turtle in a polygon)
   turtlePattern.right( angle );
   path.add( new Point(distance,angle) );
  
 }
 
 
 
 for(int i=0; i<pathLength; i++){
   Point p = path.get(pathLength-1-i);
   distance = p.getX();
   double angle = p.getY();
   turtlePattern.forward( distance ); //drawing with a turtle in a pattern (you can also draw with the turtle in a polygon)
   turtlePattern.right( angle );
 }

 turtlePattern.centerOrigin(); // moves the origin to the center of the primitive


 
 turtlePattern.moveTo(width/2,height/2); //moves the pattern to the center of the screen
 
 
 
 turtlePattern.setStrokeColor(255,0,0); //sets the color of the pattern to red
 
 Pattern turtlePattern2 = turtlePattern.copy();
 
 turtlePattern2.rotate(180);
// turtlePattern2.addToScreen();
 turtlePattern2.setOrigin(turtlePattern2.getLineAt(0).start);
 turtlePattern2.moveTo(turtlePattern.getLineAt(turtlePattern.getAllLines().size()-1).end);
 turtlePattern.addCopy(turtlePattern2);
 
 turtlePattern.centerOrigin(); // moves the origin to the center of the primitive
 turtlePattern.moveTo(width/2,height/2); //moves the pattern to the center of the screen
 
 Point quarterPoint = turtlePattern.getPointAt(turtlePattern.getAllPoints().size()/4);
 
 double xDiff = quarterPoint.getX() - turtlePattern.getOrigin().getX();
  double yDiff =quarterPoint.getY() - turtlePattern.getOrigin().getY();
  double  angle =Geom.cartToPolar(xDiff,yDiff)[1];
  println(angle);
 turtlePattern.rotate(0.0-angle);
 
  return turtlePattern;

}
