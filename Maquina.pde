class Maquina{
  ArrayList<Vec2> puntos;
  ArrayList<Pin> pines;
  ArrayList<MotorPico> motoresPico;
  ArrayList<Base> paredes;
  
  float ancho;
  int tipo;

  Maquina(float anchoP, int tipoP){
    ancho = anchoP;
    tipo = tipoP;
    
    puntos = new ArrayList();
    pines = new ArrayList();
    motoresPico = new ArrayList();
    paredes = new ArrayList();
    
    BodyDef bodyDef = new BodyDef();
    bodyDef.position = new Vec2();
    Body body = box2d.createBody(bodyDef);
    
    puntos.add(new Vec2((width - ancho) / 2 + 100, 0));
    puntos.add(new Vec2((width - ancho) / 2, 120));
    puntos.add(new Vec2((width - ancho) / 2, height));
    
    puntos.add(new Vec2((width - ancho) / 2 + ancho - 30, height));
    puntos.add(new Vec2((width - ancho) / 2 + ancho - 30, 135));
    
    puntos.add(new Vec2((width - ancho) / 2 + ancho - 100, 50));
    puntos.add(new Vec2((width - ancho) / 2 + ancho - 30, 135));
    
    puntos.add(new Vec2((width - ancho) / 2 + ancho - 30, height));
    puntos.add(new Vec2((width - ancho) / 2 + ancho, height));
    
    puntos.add(new Vec2((width - ancho) / 2 + ancho, 120));
    puntos.add(new Vec2((width - ancho) / 2 + ancho - 100, 0));
    puntos.add(new Vec2((width - ancho) / 2 + 100, 0));
    
    Vec2[] puntosMaquina = new Vec2[puntos.size()];
    for(int i = 0; i < puntos.size(); i++){
      puntosMaquina[i] = box2d.coordPixelsToWorld(puntos.get(i));
    }
    ChainShape chainShape = new ChainShape();
    chainShape.createChain(puntosMaquina, puntosMaquina.length);
    body.createFixture(chainShape, 1);
     
    colocarPines();
    colocarMotores();
    colocarParedes();
  }
  
  
  
  void display(){
    stroke(255);
    strokeWeight(5);
    for(int i = 0; i < puntos.size() - 1; i++){
      Vec2 v1 = puntos.get(i);
      Vec2 v2 = puntos.get(i + 1);
      line (v1.x, v1.y, v2.x, v2.y);
    }
    
    for(Pin p : pines){
      p.display();
    }
    
    for(MotorPico mp : motoresPico){
      mp.display();
    }
    
    for(Base p : paredes){
      p.display(); 
    }
    
    fill(#0027F7);
    strokeWeight(0);
    rectMode(CORNER);
    
    if(tipo == 1){
      rect((width - ancho) / 2 + 205, height - 20, 80, 20);
    }
  }
  
  void colocarPines(){
    ArrayList<Vec2> puntosPines = new ArrayList();
   
    if(tipo == 1){
      puntosPines = pinesMaquina1();
    }
    
    for(Vec2 v : puntosPines){
       pines.add(new Pin(5, v.x, v.y));
    }
  }
  
  void colocarMotores(){
    if(tipo == 1){
      //Vertices del Pico
      ArrayList<Vec2> vertices = new ArrayList();
      vertices.add(new Vec2(0, -135));
      vertices.add(new Vec2(10, 5));
      vertices.add(new Vec2(-10, 5));
      
      float alto = 250;
      
      //Creacion Pico 1
      float x = (width - ancho) / 2 + 200;
      float y = height;
      
      Base base1 = new Base(x, y - alto / 2, 10, alto);
      Pico pico1 = new Pico(x, y - alto + 5, vertices);
      motoresPico.add(new MotorPico(x, y, -1, alto, base1, pico1, -90, -45));
      
      //Creacion Pico 2
      x = (width - ancho) / 2 + ancho - 30 - 200;
      
      Base base2 = new Base(x, y - alto / 2, 10, alto);
      Pico pico2 = new Pico(x, y - alto + 5, vertices);
      motoresPico.add(new MotorPico(x, height, 1, alto, base2, pico2, 45, 90));
    }
  }
  
  void colocarParedes(){
    if(tipo == 1){
      float espacio = ((width - ancho) / 2 + ancho - 30 - 200) - ((width - ancho) / 2 + 200);
      paredes.add(new Base(((width - ancho) / 2 + 200) + espacio / 3, height, 10, 400));
      paredes.add(new Base(((width - ancho) / 2 + 200) + (espacio / 3 * 2), height, 10, 400));
    }
  }
  
  ArrayList<Vec2> pinesMaquina1(){
    ArrayList<Vec2> puntos = new ArrayList();
    
    int vuelta = 1;
    float y = 70;
    float x;
    float inicioMaquina = ((width - ancho) / 2 + 20); 
    while(y < height / 2){
      x = inicioMaquina;
      if (vuelta > 0){
        x += 45; 
      }
      while(x < ((width - ancho) / 2 + ancho - 40)){
        puntos.add(new Vec2(x, y));
        x += 90;
      }
      y += 54;
      vuelta *= -1;
    }
    
    x = inicioMaquina + 45;
    while(x < ((width - ancho) / 2 + ancho - 40)){
      if (x != (225 + inicioMaquina) && x != (315 + inicioMaquina) && x != (405 + inicioMaquina)){
        puntos.add(new Vec2(x, y));
      }
      x += 90;
    }
    
    y += 54;
    while(y < height){
      x = inicioMaquina + 90;
      while(x < ((width - ancho) / 2 + ancho - 40)){
        if(x != (180 + inicioMaquina) && x != (270 + inicioMaquina) && x != (360 + inicioMaquina) && x != (450 + inicioMaquina) && x != (630 + inicioMaquina)){
          puntos.add(new Vec2(x, y));
        }
        x += 90;
      }
      y += 54;
    } 
    return puntos;
  }
}
