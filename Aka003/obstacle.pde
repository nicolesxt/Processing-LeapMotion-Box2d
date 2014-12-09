class Obstacles{
  Body body;
  float w, h;
  Obstacles(float x, float y,float _w, float _h, boolean lock,float r){
    w = _w;
    h = _h;
    makeBody(x, y, w, h, lock,r);
  }
  void makeBody(float x, float y, float _w, float _h, boolean lock,float r){
    w = _w;
    h = _h;
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    if(lock) bd.type = BodyType.STATIC;
    else bd.type = BodyType.DYNAMIC;
    bd.angle = r;
    body = box2d.createBody(bd);
    
    PolygonShape sd = new PolygonShape();
    Vec2[] vertices = new Vec2[4];
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(-w/2-60, -3));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(-w/2-60, 3));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(w/2+60, -3));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(w/2+60, 3));
    sd.set(vertices, vertices.length);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density=5;
    fd.friction=1;
    fd.restitution=0.5;
    body.createFixture(fd);

  }
  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    Fixture f = body.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();
    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(0);
    noStroke();
    beginShape();
    for (int i = 0; i < ps.getVertexCount(); i++) {
      Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    popMatrix();
    
    
  }
  
  
  
}
