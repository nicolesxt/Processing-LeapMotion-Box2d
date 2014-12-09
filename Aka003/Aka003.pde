import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

import de.voidplus.leapmotion.*;

LeapMotion leap;


//call the Aka class
ArrayList<Aka> akachan;

//create the Box2D world
Box2DProcessing box2d;

  ArrayList<Water> water;
  Obstacles obstacle1, obstacle2, obstacle3;
  Bar bar;
  MovingBar03 movingbar03;
  MovingBar04 movingbar04;
  float newX1a;

//for hand
float mx, my;
float x1, y1;
float x1a, y1a;
float x1b, y1b;

float hand_pitch;
float hand_pitchL;
float hand_pitchR;

void setup(){
  size(600, 500, P3D);
  smooth();
  
  leap = new LeapMotion(this);
  leap = new LeapMotion(this).withGestures();
  //initialize box2d workd
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();

  hand_pitch = 0;
  hand_pitchL = 0;
  hand_pitchR = 0;
  
  
  box2d.setGravity(0,-40);
  
  newX1a = map(x1a, 0,500,150,height-50);
  
  akachan = new ArrayList<Aka>();
  water = new ArrayList<Water>();
  movingbar03 = new MovingBar03(newX1a,100,true,0);
  movingbar04 = new MovingBar04(width*2/3, 100, true, hand_pitchR);
  obstacle1 = new Obstacles(30*sqrt(3),height-160, 120, 10, true, -PI/6);
  obstacle2 = new Obstacles(width,height-140,40,5,true,PI/2);
  obstacle3 = new Obstacles(width-50,height-80,50,10,true,-PI/8);
}

void draw(){
  background(255);
  box2d.step();

  for(Hand hand : leap.getHands()){
    PVector hand_position    = hand.getStabilizedPosition();
    x1 = hand_position.x;
    y1 = hand_position.y;
    hand_pitch = -hand.getPitch();
    boolean lefty = hand.isLeft();
    boolean righty = hand.isRight();
    
    if(lefty){
      x1a = hand_position.x;
      y1a = hand_position.y;
      hand_pitchL = -hand.getPitch();
    }
    if(righty){
      x1b = hand_position.x;
      y1b = hand_position.y;
      hand_pitchR = -hand.getPitch();
    }

  }
  movingbar03.display();
  movingbar04.display();
  obstacle1.display();
  obstacle2.display();
  obstacle3.display();
  
  //waterfall
  for(Water b1: water){
    b1.display();
  }
  Water p1 = new Water(width*2/3,0);
  water.add(p1);
  for(int i = water.size()-1; i>=0; i--){
    Water b1 = water.get(i);
    if(b1.done()){
      water.remove(i);
      //Water p2 = new Water(width*2/3,0);
      //water.add(p1);
    }
  }
  
  //aka
  for(Aka b: akachan){
    b.display();
  }
  //generate aka
  if(millis()>3000 && millis()<3020){
  Aka p = new Aka(50,0);
  akachan.add(p);
  }
  //delete aka and generate a new one each time
  for (int i = akachan.size()-1; i >= 0; i--) {
    Aka b = akachan.get(i);
    if (b.done()) {
      akachan.remove(i);
      Aka p = new Aka(random(25, 70), 0);
      akachan.add(p);
    }
  }

}
