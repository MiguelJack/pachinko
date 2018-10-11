class Pico{
  Body body;
  ArrayList<Vec2> vertices;
  
  Pico(float x, float y){
    vertices = new ArrayList();
    vertices.add(new Vec2(0, -130));
    vertices.add(new Vec2(10, 5));
    vertices.add(new Vec2(-10, 5));
    
    PolygonShape polygonShape = new PolygonShape();
    Vec2[] puntosPico = new Vec2[vertices.size()];
    for(int i = 0; i < vertices.size(); i++){
       puntosPico[i] = box2d.vectorPixelsToWorld(vertices.get(i));
    }
    polygonShape.set(puntosPico, puntosPico.length);
    
    FixtureDef fixtureDef = new FixtureDef();
    fixtureDef.setShape(polygonShape);
    fixtureDef.setDensity(1000);
    fixtureDef.setRestitution(0);
    fixtureDef.setFriction(0);
    
    BodyDef bodyDef = new BodyDef();
    bodyDef.position = box2d.coordPixelsToWorld(x, y);
    bodyDef.type = BodyType.DYNAMIC;
    body = box2d.createBody(bodyDef);
    body.createFixture(fixtureDef);
  }
  
  void display(){
    Vec2 posicion = box2d.getBodyPixelCoord(body);
    PolygonShape polygonShape = (PolygonShape) body.getFixtureList().getShape();
    float angulo = body.getAngle();
    rectMode(CENTER);
    stroke(#FF7C00);
    strokeWeight(2);
    pushMatrix();
    translate(posicion.x, posicion.y);
    rotate(-angulo);
    fill(#D66800);
    beginShape();
    for (int i = 0; i < polygonShape.getVertexCount(); i++) {
      Vec2 v = box2d.vectorWorldToPixels(polygonShape.getVertex(i));
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    popMatrix();
  }
  
  Body getBody(){
    return body; 
  }
}
