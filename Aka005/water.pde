

class Water{
  //store a reference to a box2d body
  Body body;
  
  float w;
  
  Water(float x, float y){
    w = random(3,6);
    makebody(x, y);
  }
  
  void makebody(float x, float y){
  //build the body
  BodyDef bd = new BodyDef();
  bd.type = BodyType.DYNAMIC;
  bd.position.set(box2d.coordPixelsToWorld(x,y));
  body = box2d.createBody(bd);
  
  //define the body
  PolygonShape sd = new PolygonShape();
  float box2dW = box2d.scalarPixelsToWorld(w/2);
  float box2dH = box2d.scalarPixelsToWorld(w/2);
  sd.setAsBox(box2dW, box2dH);
  
  //define a fixture
  FixtureDef fd = new FixtureDef();
  fd.shape = sd;
  
  fd.density = 10;
  fd.friction = 0;
  fd.restitution = 0.0;//friction
  
  //attach fixture to body
  body.createFixture(fd);
  }
  
  void killBody() {
    box2d.destroyBody(body);
  }
  
  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
   if(pos.y > height || pos.x >width || pos.y<0 || pos.x<0){
      killBody();
      makebody(width*2/3, 0);
      //body.setTransform(box2d.coordPixelsToWorld(150, y1a-40), hand_pitchL*PI/180);
      //body.setTransform(box2d.coordPixelsToWorld(width*2/3, 100), hand_pitchR*PI/180);
    }
    //need the body location and angle (very important)
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    //fill(random(70,150),random(100,170),random(170,225));
    fill(0,0,random(200,255));
    noStroke();
    rectMode(CENTER);
    ellipse(0,0,w,w);
    popMatrix();
  }
  
boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height || pos.x > height || pos.x < 0) {
      box2d.destroyBody(body);
      return true;
    }
    return false;
}
  
}
