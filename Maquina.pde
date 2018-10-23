class Maquina{
  ArrayList<Vec2> puntos;
  ArrayList<Pin> pines;
  ArrayList<MotorPico> motoresPico;
  ArrayList<MotorRueda> motoresRueda;
  ArrayList<Base> paredes;
  ArrayList<Atractores> atractores;
  ArrayList<Repeledores> repeledores;
  pachinko pantalla;
  ControlP5 cp5;
  CheckBox checkbox;
  
  float ancho;
  int tipo;

  Maquina(float anchoP, int tipoP,pachinko pantalla){
    ancho = anchoP;
    tipo = tipoP;
    
    cp5 = new ControlP5(pantalla);
    puntos = new ArrayList();
    pines = new ArrayList();
    motoresPico = new ArrayList();
    motoresRueda = new ArrayList();
    paredes = new ArrayList();
    atractores = new ArrayList();
    repeledores = new ArrayList();
    
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
    colocarMotoresPico();
    colocarMotoresRueda();
    colocarParedes();
    colocarRepeledoresAtractores();
    colocarControl();
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
    
    for(MotorRueda mr : motoresRueda){
      mr.display();
    }
    
    for(Base p : paredes){
      p.display(); 
    }
    
    for (Atractores a : atractores){
      a.draw();
    }
    for (Repeledores r : repeledores){
      r.draw();
    }
    
    
    fill(#0027F7);
    strokeWeight(0);
    rectMode(CORNER);
    
    switch (tipo){
      case 1:
        rect((width - ancho) / 2 + 205, height - 20, 80, 20);
        break;
      default:
        break;
    }
  }
  
  void colocarPines(){
    ArrayList<Vec2> puntosPines = new ArrayList();
    
    switch (tipo){
      case 1:
        puntosPines = pinesMaquina1();
        break;
      case 2:
        puntosPines = pinesMaquina2();
      default:
        break;
    }
    
    for(Vec2 v : puntosPines){
       pines.add(new Pin(5, v.x, v.y));
    }
    
  }
  
  void colocarMotoresPico(){
    ArrayList<Vec2> vertices = new ArrayList();
    float alto, x;
    switch (tipo){
      case 1:
        //Vertices del Pico
        vertices.add(new Vec2(0, -135));
        vertices.add(new Vec2(10, 5));
        vertices.add(new Vec2(-10, 5));
        
        alto = 250;
        
        //Creacion Pico 1
        x = (width - ancho) / 2 + 200;
        
        Base base1m1 = new Base(x, height - alto / 2, 10, alto, 0);
        Pico pico1m1 = new Pico(x, height - alto + 5, vertices);
        motoresPico.add(new MotorPico(-1, base1m1, pico1m1, -90, -45, PI/2));
        
        //Creacion Pico 2
        x = (width - ancho) / 2 + ancho - 30 - 200;
        
        Base base2m1 = new Base(x, height - alto / 2, 10, alto, 0);
        Pico pico2m1 = new Pico(x, height - alto + 5, vertices);
        motoresPico.add(new MotorPico(1, base2m1, pico2m1, 45, 90, PI/2));
        break;
      case 2:
        vertices.add(new Vec2(0, -90));
        vertices.add(new Vec2(10, 5));
        vertices.add(new Vec2(-10, 5));
          
        alto = 350;
        
        x = (width - ancho) / 2 + 255; 
        Base base1m2 = new Base(x, height - alto, 10, 10, 0);
        Pico pico1m2 = new Pico(x, height - alto, vertices);
        motoresPico.add(new MotorPico(-1, base1m2, pico1m2, -55, -35, PI/3));
        
        x = (width - ancho) / 2 + ancho - 30 - 255;
        Base base2m2 = new Base(x, height - alto, 10, 10, 0);
        Pico pico2m2 = new Pico(x, height - alto, vertices);
        motoresPico.add(new MotorPico(-1, base2m2, pico2m2, 35, 55, PI/3));
      default:
        break;
    }
  }
  
  void colocarMotoresRueda(){
    float x, alto;
    switch (tipo){
      case 2:
        alto = 280;
        x = (width - ancho) / 2 + 90;
        Base base1m2 = new Base(x, height - alto, 10, 10, 0);
        Rueda rueda1m2 = new Rueda(x, height - alto, 40);
        motoresRueda.add(new MotorRueda(base1m2, rueda1m2));
        
        x = (width - ancho) / 2 + ancho - 30 - 90;
        Base base2m2 = new Base(x, height - alto, 10, 10, 0);
        Rueda rueda2m2 = new Rueda(x, height - alto, 40);
        motoresRueda.add(new MotorRueda(base2m2, rueda2m2));
        
        alto = 410;
        x = (width - ancho) / 2 + 180;
        Base base3m2 = new Base(x, height - alto, 10, 10, 0);
        Rueda rueda3m2 = new Rueda(x, height - alto, 30);
        motoresRueda.add(new MotorRueda(base3m2, rueda3m2));
        
        x = (width - ancho) / 2 + ancho - 30 - 180;
        Base base4m2 = new Base(x, height - alto, 10, 10, 0);
        Rueda rueda4m2 = new Rueda(x, height - alto, 30);
        motoresRueda.add(new MotorRueda(base4m2, rueda4m2));
        break;
      default:
        break;
    }
  }
  
  void colocarParedes(){
    float x, alto, espacio;
    switch (tipo){
      case 1:
        espacio = ((width - ancho) / 2 + ancho - 30 - 200) - ((width - ancho) / 2 + 200);
        paredes.add(new Base(((width - ancho) / 2 + 200) + espacio / 3, height, 10, 400, 0));
        paredes.add(new Base(((width - ancho) / 2 + 200) + (espacio / 3 * 2), height, 10, 400, 0));
        break;
      case 2:
        alto = 260;
        espacio = ((width - ancho) / 2 + ancho - 30 - 200) - ((width - ancho) / 2 + 200);
        
        x = (width - ancho) / 2 + 200;
        paredes.add(new Base(x, height - alto / 2, 10, alto, 0));
        paredes.add(new Base(x + (espacio / 2 - 15) / 2 - 5, height - alto - 9, espacio / 2 - 10, 10, radians(15)));
        
        x = (width - ancho) / 2 + ancho - 30 - 200;
        paredes.add(new Base(x, height - alto / 2, 10, alto, 0));
        paredes.add(new Base(x - (espacio / 2 - 15) / 2 + 5, height - alto - 9, espacio / 2 - 10, 10, radians(-15)));
        break;
      default:
        break;
    }
  }
  
  
  void colocarControl(){
    switch(tipo){
      case 1:
      checkbox = cp5.addCheckBox("Materiales")
                    .setPosition(100,500)
                    .setColorForeground(color(120))
                    .setColorActive(color(255))
                    .setColorLabel(color(255))
                    .setSize(20, 20)
                    .setItemsPerRow(1)
                    .setSpacingColumn(30)
                    .setSpacingRow(10)
                    .addItem("Material 1", 0)
                    .addItem("Material 2", 50)
                    .addItem("Material 3", 100)
                    .addItem("Material 4", 150)
                    .addItem("Material 5", 200);
             break;
      case 2:
              break;
    }
  }
  
  
  void colocarRepeledoresAtractores(){
    switch (tipo){
      case 1:
        atractores.add(new Atractores(width/2,height/3));
        atractores.add(new Atractores(width/2,height/4.5));
        repeledores.add(new Repeledores(width/3.5,height/4));
        repeledores.add(new Repeledores(width/1.5,height/4)); 
        break;
      case 2:
        //repeledores.add(new Repeledores((width - ancho) / 2 + 290, height - 280));
        //repeledores.add(new Repeledores((width - ancho) / 2 + ancho - 30 - 290, height - 280));
        break;
      default:
        break;
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
  
  ArrayList<Vec2> pinesMaquina2(){
    ArrayList<Vec2> puntos = new ArrayList();
    
    int vuelta = 1;
    float y = 70;
    float x;
    float inicioMaquina = ((width - ancho) / 2 + 20); 
    while(y < height / 4){
      x = inicioMaquina;
      if (vuelta > 0){
        x += 31; 
      }
      while(x < ((width - ancho) / 2 + ancho - 40)){
        if(y != 70 || x < (width - ancho) / 2 + ancho - 80){
          puntos.add(new Vec2(x, y));
        }
        x += 62;
      }
      y += 45;
      vuelta *= -1;
    }
    
    puntos.add(new Vec2(width / 2 - 44, y - 15));
    puntos.add(new Vec2(width / 2 + 6, y - 15));
    
    puntos.add(new Vec2((width - ancho) / 2 + 55, height - 345));
    puntos.add(new Vec2((width - ancho) / 2 + 45, height - 380));
    puntos.add(new Vec2((width - ancho) / 2 + 35, height - 415));
    
    puntos.add(new Vec2((width - ancho) / 2 + ancho - 30 - 55, height - 345));
    puntos.add(new Vec2((width - ancho) / 2 + ancho - 30 - 45, height - 380));
    puntos.add(new Vec2((width - ancho) / 2 + ancho - 30 - 35, height - 415));

    return puntos;
  }
  
  
  void poner_material(int i){
    switch(i){
      case 0: print("Material 1 true");
              break;
      case 1: print("Material 2 true");
              break;
      case 2: print("Material 3 true");
              break;
      case 3: print("Material 4 true");
              break; 
      case 4: print("Material 5 true");
              break;             
    }
  }
  
    void quitar_material(int i){
    switch(i){
      case 0: print("Material 1 false");
              break;
      case 1: print("Material 2 false");
              break;
      case 2: print("Material 3 false");
              break;
      case 3: print("Material 4 false");
              break; 
      case 4: print("Material 5 false");
              break;             
    }
  }
}
