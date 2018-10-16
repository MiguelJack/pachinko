class Rueda{
  float radio;
  Body body;
  
  Rueda(float x, float y, float radioP){
    radio = radioP;
    BodyDef bodyDef = new BodyDef();
    bodyDef.position = box2d.coordPixelsToWorld(x, y);
    bodyDef.type = BodyType.DYNAMIC;
    body = box2d.createBody(bodyDef);
    
    CircleShape circleShape = new CircleShape();
    circleShape.setRadius(box2d.scalarPixelsToWorld(radio));
    
    FixtureDef fixtureDef = new FixtureDef();
    fixtureDef.shape = circleShape;
    fixtureDef.density = 0.1;
    fixtureDef.friction = 0.1;
    fixtureDef.restitution = 0.8;
    
    body.createFixture(fixtureDef);
  }
  
  void display(){
    Vec2 posicion = box2d.getBodyPixelCoord(body);
    float angulo = body.getAngle();
    pushMatrix();
    translate(posicion.x, posicion.y);
    rotate(-angulo);
    fill(#0011BC);
    stroke(#0319FF);
    strokeWeight(2);
    ellipse(0, 0, radio * 2, radio * 2);
    line(-radio, 0, radio, 0);
    line(0, -radio, 0, radio);
    popMatrix();
  }
}
