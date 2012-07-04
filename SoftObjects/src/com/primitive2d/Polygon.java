package com.primitive2d;

import java.util.Vector;

import processing.core.PApplet;

import com.datatype.DCFace;
import com.datatype.DCHalfEdge;
import com.datatype.Point;
import com.math.Geom;

public class Polygon extends LineCollection{

	public Polygon(){
		super();
		
	}
	
	//polygon add point method that automatically links up points into lines
	@Override
	public void addPoint(double x,double y){
		Point point = new Point(x,y);
		
		int numLines = this.getAllLines().size();
		int numPoints = this.getAllPoints().size();
		if(numLines>0){
			Point start = this.getLineAt(numLines-1).end;
			Line line = new Line(start,point);
			addLine(line);
		}
		else if(numPoints>0){
			Line line = new Line(getPointAt(0),point);
			addLine(line);
		}
		
		this.addPoint(point);
	}
	
	@Override
	public Polygon copy(){
		Polygon poly = new Polygon();
		
		Vector<Line> lines = this.getAllLines();
		for(int i=0;i<lines.size();i++){
			Line line = lines.get(i).copy();
			poly.addLine(line);
		}
		poly.setOrigin(this.origin.copy());
		return poly;
	}

}
