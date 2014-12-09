
class Wall {
  Body body;
  float w, h;
  Wall(float x, float y) {
    w = 2;
    h = height;
    makeBody(x, y);
  }

  void makeBody(float x, float y) {
    //build the body
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    bd.type = BodyType.STATIC;
    body = box2d.createBody(bd);
    
    //define the shape
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);

    //define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;

    fd.density = 10;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    //attach fixture to body
    body.createFixture(fd);
  }

  void display() {
    //need the body location and angle (very important)
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(0);
    noStroke();
    rect(0,0,w,h);
    popMatrix();
  }
}

