import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import java.util.ListIterator;
import org.jbox2d.dynamics.joints.*;
Box2DProcessing box2d;
import controlP5.*;
import processing.sound.*;
SoundFile file;
String audioName;

ArrayList<Bolita> bolitas;
Maquina maquina;
ControlP5 cp5;
float radioBolitas = 8;
float anchoMaquina;
int tipoMaquina = 0;
int modoJuego = 1;
float x1, x2;
int tipo;
int velocidad = 80;
int numeroBolitas;
int bolitasInicial = 500;
int puntaje = 0;
int numeroBolitasOut;

color c;
float densidad;
float fuerzaRebote;
float friccion;
boolean metal;

int pantallaActual = 0;

Boton botonMaquinaConf1;
Boton botonMaquinaConf2;
Boton textoInicio;
Boton botonModo1;
Boton botonModo2;
Boton textoModo;

PImage jotaro;
PImage glasses;

Slider sliderGravedad;
Slider sliderVelocidad;

void setup(){
  size(1200, 650);  
  initControls();
  numeroBolitasOut = bolitasInicial;
  numeroBolitas = bolitasInicial;
  
  music();
}

void music(){
  int r = (int)random(0, 5);
  switch(r){
     case 0:
       audioName = "data\\Song 1.mp3";
       break;
     case 1:
       audioName = "data\\Song 2.mp3";
       break;
     case 2:
       audioName = "data\\Song 3.mp3";
       break;
     case 3:
       audioName = "data\\Song 4.mp3";
       break;
     case 4:
       audioName = "data\\Song 5.mp3";
       break;
     default:
       break;
  }
  
  String path = sketchPath(audioName);
  file = new SoundFile(this, path);
  file.play();
}

void draw(){
  background(0);
  if (pantallaActual == 0){
    pantallaInicio();
  }else if(pantallaActual == 1){
    pantallaModo();
  }else if(pantallaActual == 2){
    pantallaJuego();
  }else if(pantallaActual == 3){
    pantallaVictoria();
  }else if(pantallaActual == 4){
    pantallaPerder();
  }else if(pantallaActual == 5){
    pantallaPuntaje();
  }
  
  if(numeroBolitasOut == 0){
     if(modoJuego == 1){
       pantallaActual = 4;
     }else if(modoJuego == 2){
       pantallaActual = 5; 
     }
  }
}

void pantallaVictoria()
{
  sliderGravedad.setVisible(false);
  sliderVelocidad.setVisible(false);
  image(jotaro, 0, 0);
  PFont f = createFont("Georgia", 64);
  String victoria = "Has ganado!";
  textFont(f);
  textSize(64);
  text(victoria, 800, 200);
}

void pantallaPerder()
{
  sliderGravedad.setVisible(false);
  sliderVelocidad.setVisible(false);
  image(jotaro, 0, 0);
  PFont f = createFont("Georgia", 64);
  String perder = "Has Perdido!";
  textFont(f);
  textSize(64);
  text(perder, 800, 200);
}

void pantallaPuntaje()
{
  sliderGravedad.setVisible(false);
  sliderVelocidad.setVisible(false);
  image(jotaro, 0, 0);
  PFont f = createFont("Georgia", 64);
  String spuntaje = "Tu puntaje: "+ puntaje;
  textFont(f);
  textSize(64);
  text(spuntaje, 800, 200);
}

void pantallaInicio(){
  background(0);
  textoInicio = new Boton("Seleccione el tipo de maquina", 820, 200, 300, 50);
  botonMaquinaConf1 = new Boton("Tipo 1", 800, 400, 100, 50);
  botonMaquinaConf2 = new Boton("Tipo 2", 1050, 400, 100, 50);
  jotaro = loadImage("jotaro.png");
  textoInicio.dibujar();
  botonMaquinaConf1.dibujar();
  botonMaquinaConf2.dibujar();
  
  sliderGravedad.hide();
  sliderVelocidad.hide();
  
  image(jotaro, 0, 0);
  
  if (mousePressed){ 
    if (botonMaquinaConf1.mouseEncima()){
      tipoMaquina = 1;
      pantallaActual = 1;
      eliminarElementosPantallaInicio();
      //configurarPantallaJuego();
    }else if (botonMaquinaConf2.mouseEncima()){
      tipoMaquina = 2;
      pantallaActual = 1;
      eliminarElementosPantallaInicio();
      //configurarPantallaJuego();
    }
  }
}

void pantallaModo(){
  background(0);
  textoModo = new Boton("Seleccione el modo de juego", 820, 200, 300, 50);
  botonModo1 = new Boton("Modo 1", 800, 400, 100, 50);
  botonModo2 = new Boton("Modo 2", 1050, 400, 100, 50);
  jotaro = loadImage("jotaro.png");
  textoModo.dibujar();
  botonModo1.dibujar();
  botonModo2.dibujar();
  
  sliderGravedad.hide();
  sliderVelocidad.hide();
  
  image(jotaro, 0, 0);
  
  if (mousePressed){ 
    if (botonModo1.mouseEncima()){
      modoJuego = 1;
      pantallaActual = 2;
      eliminarElementosPantallaModo();
      configurarPantallaJuego();
    }else if (botonModo2.mouseEncima()){
      modoJuego = 2;
      pantallaActual = 2;
      eliminarElementosPantallaModo();
      configurarPantallaJuego();
    }
  }
}

void eliminarElementosPantallaInicio()
{
  textoInicio = null;
  botonMaquinaConf1 = null;
  botonMaquinaConf2 = null;
}

void eliminarElementosPantallaModo()
{
  textoModo = null;
  botonModo1 = null;
  botonModo2 = null;
}

void eliminarComponentesMaquina()
{
  maquina = null;
}

void configurarPantallaJuego()
{
  bolitas = new ArrayList();
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  switch (tipoMaquina){
    case 1:
      anchoMaquina = 700;
      x1 = (width - anchoMaquina) / 2 + 205;
      x2 = (width - anchoMaquina) / 2 + 285;
      break;
    case 2:
      anchoMaquina = 700;
      x1 = (width - anchoMaquina) / 2 + 273;
      x2 = (width - anchoMaquina) / 2 + 330;  
      break;
  }
  maquina = new Maquina(anchoMaquina, tipoMaquina);
}

void pantallaJuego(){
  background(0);
  Boton lanzar = new Boton("Lanzar",1050,500,100,100);
  lanzar.dibujar();
  Boton regresar = new Boton("Regresar",1050,50,100,50);
  regresar.dibujar();
  sliderGravedad.show();
  sliderVelocidad.show();
  fill(255);
  text("Bolitas restantes: " + numeroBolitas,100,height-50);
  if(modoJuego == 2){
    text("Puntaje: " + puntaje,100, height - 100);
  }
  
  if(mousePressed){
    if(lanzar.mouseEncima()){
       float i = random(1,10);
       if(numeroBolitas > 0){
         if(i < 5){
        bolitas.add(new Bolita(fuerzaRebote, radioBolitas, (width - anchoMaquina) / 2 + anchoMaquina - radioBolitas - 5, height,densidad,c,friccion,metal, velocidad)); 
        numeroBolitas--;
      }
    }
    }
    else if(regresar.mouseEncima()){
      pantallaActual = 0;
      numeroBolitas = bolitasInicial;
      numeroBolitasOut = bolitasInicial;
      puntaje = 0;
    }
  }
  
  box2d.step();
  
  maquina.display();
  
  for (Bolita b : bolitas){
    b.display();
    //Atraccion y repeledores con cada bolita
   if(b.metal){
     for(Atractores a : maquina.atractores){
        b.attract(a.x,a.y);
     } 
     for(Repeledores r : maquina.repeledores){
        b.repel(r.x,r.y);
     }
   }
  }
  
  ListIterator<Bolita> pennywise = bolitas.listIterator();
  while(pennywise.hasNext()){
    Bolita b = pennywise.next();
    if(b.salio(anchoMaquina)){
      if(b.gano(x1, x2)){
        if(modoJuego == 1){
          pantallaActual = 3;
          eliminarComponentesMaquina();
        }else{
          if(modoJuego == 2){
            puntaje += 100;
          }
        }
      }
      pennywise.remove();
      numeroBolitasOut -= 1;
    }
  }
}

void initControls(){
  cp5 = new ControlP5(this);
  sliderGravedad = cp5.addSlider("setGravedad")
    .setPosition(10, 10)
    .setSize(200, 20)
    .setRange(1, 3)
    .setCaptionLabel("Tipo de bolita")
    .setColorBackground(color(255))
    .setColorActive(color(255, 0, 0))
    .setValue(tipo)
    .setColorCaptionLabel(color(255, 255, 255));
    
  sliderVelocidad = cp5.addSlider("setVelocidad")
    .setPosition(10, 40)
    .setSize(200, 20)
    .setRange(80, 180)
    .setCaptionLabel("Velocidad")
    .setColorBackground(color(255))
    .setColorActive(color(255, 0, 0))
    .setValue(tipo)
    .setColorCaptionLabel(color(255, 255, 255));

}
void setGravedad(int value){
  tipo = value;
  if (value ==1){
    densidad = 3;
    fuerzaRebote = 0.9;
    friccion = 1;
    c = color(255,0,255);
    metal = false;
  }
  if (value ==2){
    densidad = 5;
    fuerzaRebote = 0.6;
    friccion = 3;
    c = color(0,0,255);
    metal = false;
  }
  if (value ==3){
    densidad = 0.5;
    fuerzaRebote = 0.01;
    friccion = 0.5;
    c = color(255,255,0);
    metal = true;
  }
}
void setVelocidad(int value){
  velocidad = value;
}
