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


ArrayList<Bolita> bolitas;
Maquina maquina;
ControlP5 cp5;
float radioBolitas = 8;
float anchoMaquina;
int tipoMaquina = 0;
float x1, x2;
int tipo;
int velocidad = 80;
int numeroBolitas = 100;

color c;
float densidad;
float fuerzaRebote;
float friccion;
boolean metal;

int pantallaActual = 0;

Boton textoInicio;
Boton botonMaquinaConf1;
Boton botonMaquinaConf2;

PImage jotaro;
PImage glasses;

Slider sliderGravedad;
Slider sliderVelocidad;





void setup(){
  size(1200, 650);
  textoInicio = new Boton("Seleccione el tipo de maquina", 820, 200, 300, 50);
  botonMaquinaConf1 = new Boton("Tipo 1", 800, 400, 100, 50);
  botonMaquinaConf2 = new Boton("Tipo 2", 1050, 400, 100, 50);
  jotaro = loadImage("jotaro.png");
  
  initControls();
}

void draw(){
  background(0);
  if (pantallaActual == 0)
  {
    pantallaInicio();
  }else if(pantallaActual == 1){
    pantallaJuego();
  }else{
    pantallaVictoria();
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

void pantallaInicio(){
  background(0);
  textoInicio.dibujar();
  botonMaquinaConf1.dibujar();
  botonMaquinaConf2.dibujar();
  
  sliderGravedad.hide();
  sliderVelocidad.hide();
  
  image(jotaro, 0, 0);
  
  if (mousePressed)
  { 
    if (botonMaquinaConf1.mouseEncima())
    {
      tipoMaquina = 1;
      pantallaActual = 1;
      eliminarElementosPantallaInicio();
      configurarPantallaJuego();
    }else if (botonMaquinaConf2.mouseEncima())
    {
      tipoMaquina = 2;
      pantallaActual = 1;
      eliminarElementosPantallaInicio();
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
      x1 = (width - anchoMaquina) / 2 + 205;
      x2 = (width - anchoMaquina) / 2 + 285;  
      break;
  }
  maquina = new Maquina(anchoMaquina, tipoMaquina);
}

void pantallaJuego(){
  background(0);
  sliderGravedad.show();
  sliderVelocidad.show();
  fill(255);
  text("Bolitas restantes:" + numeroBolitas,100,height-50);
  
  if(mousePressed&& (mouseButton == RIGHT)){
    float i = random(1,10);
    
    if(i < 5){
      bolitas.add(new Bolita(fuerzaRebote, radioBolitas, (width - anchoMaquina) / 2 + anchoMaquina - radioBolitas - 5, height,densidad,c,friccion,metal, velocidad)); 
      numeroBolitas--;
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
    if(b.gano(x1, x2)){
      pantallaActual = 2;
      eliminarComponentesMaquina();
      //stop(); 
    }else{
      if(b.salio(anchoMaquina)){
        pennywise.remove();
      }
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
