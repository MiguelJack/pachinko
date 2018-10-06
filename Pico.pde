class Pico{
  Body body;
  ArrayList<Vec2> vertices;
  
  Pico(float x, float y){
    vertices = new ArrayList();
    BodyDef bodyDef = new BodyDef();
    bodyDef.position = box2d.coordPixelsToWorld(x, y);
    bodyDef.type = BodyType.DYNAMIC;
    bodyDef.angle = random(PI);
    body = box2d.createBody(bodyDef);
    
    vertices.add(new Vec2(0, -70));
    vertices.add(new Vec2(10, 5));
    vertices.add(new Vec2(-10, 5));
    vertices.add(new Vec2(0, -70));
    
    Vec2[] puntosPico = new Vec2[vertices.size()];
    for(int i = 0; i < vertices.size(); i++){
       puntosPico[i] = box2d.coordPixelsToWorld(vertices.get(i));
    }
    PolygonShape polygonShape = new PolygonShape();
    polygonShape.set(puntosPico, puntosPico.length);
    
    FixtureDef fixtureDef = new FixtureDef();
    fixtureDef.shape = polygonShape;
    fixtureDef.density = 1;
    fixtureDef.restitution = 0.8;
    fixtureDef.friction = 0;
    
    body.createFixture(fixtureDef);
    
    body.setAngularVelocity(5);
  }
  
  void display(){
    Vec2 posicion = box2d.getBodyPixelCoord(body);
    float angulo = body.getAngle();
    pushMatrix();
    //translate(posicion.x, posicion.y);
    rotate(-angulo);
    fill(#D66800);
    stroke(#FF7C00);
    strokeWeight(2);
    beginShape();
    for(Vec2 v : vertices){
      vertex(v.x, v.y); 
    }
    endShape(CLOSE);
    popMatrix();
  }
}
