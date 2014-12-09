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
PImage open, live, die;

//call the Aka class
ArrayList<Aka> akachan;

//create the Box2D world
Box2DProcessing box2d;

Wall wall1;
Wall wall2;
Box box;
Bar bar1, bar2, bar3, bar4, bar5;
Bar bar6, bar7, bar8, bar9, bar10;

//for hand
float mx, my;
float x1, y1;
float x1a, y1a;
float x1b, y1b;

float hand_pitch;
float hand_pitchL;
float hand_pitchR;

//left hand
PVector l1, l2, l3, l4, l5;
PVector r1, r2, r3, r4, r5;

void setup(){
  size(1000,800, P2D);
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
  //fingers
  l1 = new PVector(0,0);
  l2 = new PVector(0,0);
  l3 = new PVector(0,0);
  l4 = new PVector(0,0);
  l5 = new PVector(0,0);
  r1 = new PVector(0,0);
  r2 = new PVector(0,0);
  r3 = new PVector(0,0);
  r4 = new PVector(0,0);
  r5 = new PVector(0,0);
  
  box2d.setGravity(0,-100);
  
  bar1 = new Bar(l1.x, l1.y, true, 0);
  bar2 = new Bar(l2.x, l2.y, true, 0);
  bar3 = new Bar(l3.x, l3.y, true, 0);
  bar4 = new Bar(l4.x, l4.y, true, 0);
  bar5 = new Bar(l5.x, l5.y, true, 0);
  bar6 = new Bar(r1.x, r1.y, true, 0);
  bar7 = new Bar(r2.x, r2.y, true, 0);
  bar8 = new Bar(r3.x, r3.y, true, 0);
  bar9 = new Bar(r4.x, r4.y, true, 0);
  bar10 = new Bar(r5.x, r5.y, true, 0);
  
  akachan = new ArrayList<Aka>();
  wall1 = new Wall(width/2-80, height);
  wall2 = new Wall(width/2+80, height);
  box = new Box(width/2, height, 160, 3, true);
  
  open = loadImage("004.jpg");
  live = loadImage("live.jpg");
  die = loadImage("die.jpg");
  
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
  // LEFT FINGERS
  if(lefty){
  for(Finger finger : hand.getFingers()){
          switch(finger.getType()){
        case 0:
        l1=finger.getPosition().get();
          break;
        case 1:
        l2=finger.getPosition().get();
          break;
        case 2:
        l3=finger.getPosition().get();
          break;
        case 3:
        l4=finger.getPosition().get();
          break;
        case 4:
        l5=finger.getPosition().get();
          break;
      }
  }
  }
  //RIGHT FINGER
  if(righty){
  for(Finger finger : hand.getFingers()){
          switch(finger.getType()){
        case 0:
        r1=finger.getPosition().get();
          break;
        case 1:
        r2=finger.getPosition().get();
          break;
        case 2:
        r3=finger.getPosition().get();
          break;
        case 3:
        r4=finger.getPosition().get();
          break;
        case 4:
        r5=finger.getPosition().get();
          break;
      }
  }
  }
  }
  
  //wall
  wall1.display();
  wall2.display();
  box.display();
  //bar
  bar1.display(l1.x, l1.y);
  bar2.display(l2.x, l2.y);
  bar3.display(l3.x, l3.y);
  bar4.display(l4.x, l4.y);
  bar5.display(l5.x, l5.y);
  bar6.display(r1.x, r1.y);
  bar7.display(r2.x, r2.y);
  bar8.display(r3.x, r3.y);
  bar9.display(r4.x, r4.y);
  bar10.display(r5.x, r5.y);
  
  //aka
  for(Aka b: akachan){
    b.display();
  }
  //generate aka
  if(millis()>3500 && millis()<3520){
  Aka p = new Aka(120,0);
  akachan.add(p);
  }
  //delete aka and generate a new one each time
  for (int i = akachan.size()-1; i >= 0; i--) {
    Aka b = akachan.get(i);
    if (b.done()) {
      akachan.remove(i);
      Aka p = new Aka(random(100, 130), 0);
      akachan.add(p);
    }
  }
  
  if(millis()<3400){
    image(open,0,0, width, height);
  }
  
}
