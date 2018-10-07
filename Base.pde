class Base{
  Body body;
  float ancho, alto;
  
  Base(float x, float y, float anchoP, float altoP){
    ancho = anchoP;
    alto = altoP;
    BodyDef bodyDef = new BodyDef();
    bodyDef.position = box2d.coordPixelsToWorld(x, y);
    bodyDef.type = BodyType.STATIC;
    body = box2d.world.createBody(bodyDef);
 
    PolygonShape polygonShape = new PolygonShape();  
    polygonShape.setAsBox(box2d.scalarPixelsToWorld(ancho / 2), box2d.scalarPixelsToWorld(alto / 2));
 
    FixtureDef fixtureDef = new FixtureDef();
    fixtureDef.shape = polygonShape;
    fixtureDef.density = 1;
    fixtureDef.friction = 0.01;
    fixtureDef.restitution = 0.5;
 
    body.createFixture(fixtureDef);
  }
  
  void display(){
    Vec2 posicion = box2d.getBodyPixelCoord(body);
    float angulo = body.getAngle();
    pushMatrix();
    translate(posicion.x, posicion.y);
    rotate(-angulo);
    fill(#D66800);
    stroke(#FF7C00);
    strokeWeight(2);
    rectMode(CENTER);
    rect(0, 0, ancho, alto);
    popMatrix();
  }
}
