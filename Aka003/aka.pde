

class Aka{
  //store a reference to a box2d body
  Body body;
  
  float w, h;
  
  Aka(float x, float y){
    w = 15;
    h = 15;
  
  //build the body
  BodyDef bd = new BodyDef();
  bd.type = BodyType.DYNAMIC;
  bd.position.set(box2d.coordPixelsToWorld(x,y));
  body = box2d.createBody(bd);
  
  //define the body
  PolygonShape sd = new PolygonShape();
  float box2dW = box2d.scalarPixelsToWorld(w/2);
  float box2dH = box2d.scalarPixelsToWorld(h/2);
  sd.setAsBox(box2dW, box2dH);
  
  //define a fixture
  FixtureDef fd = new FixtureDef();
  fd.shape = sd;
  
  fd.density = 0.1;
  fd.friction = 0;
  fd.restitution = 0.6;
  
  //attach fixture to body
  body.createFixture(fd);
  }
  
  void display(){
    //need the body location and angle (very important)
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(255,0,0);
    noStroke();
    rectMode(CENTER);
    ellipse(0,0,w,h);
    popMatrix();
    
    Aka_Live = box2d.getBodyPixelCoord(body);
  }
  
boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+w*h || pos.x > height+w*h || pos.x < 0) {
      box2d.destroyBody(body);
      return true;
    }
    return false;
}
  
}
