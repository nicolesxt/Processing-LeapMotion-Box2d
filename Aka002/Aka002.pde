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

Obstacles obstacle1;
float w, h, r;
MovingBar01 movingbar01;
MovingBar02 movingbar02;
Wall wall1, wall2, wall3;

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
  
  
  box2d.setGravity(0,-100);
  
  w = 200;
  h = 10;
  r = -PI/8;
  akachan = new ArrayList<Aka>();
  
  //joints of the obstacle
  obstacle1 = new Obstacles(w*sqrt(3)/4, height-60, w, h, true,r);
  
  movingbar01 = new MovingBar01(width*3/4, height-50, true, hand_pitchR);
  movingbar02 = new MovingBar02(width/2, y1a, true, 0);
  
  wall1 = new Wall(width/2-40,-100);
  wall2 = new Wall(width/2+40,-120);
  wall3 = new Wall(width*3/4, height+200);
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
  //wall
  wall1.display();
  wall2.display();
  wall3.display();
  //obstacle1
  obstacle1.display();
  //bar
  movingbar01.display();
  movingbar02.display();
  
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
