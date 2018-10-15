class Atractores{
  color c;
  Float x,y;
  
  Atractores (float x, float y) {
    this.x = x;
    this.y = y;
    c = color(#FCF742);
  }
  
  void draw(){
    noStroke();
    fill(c);
    ellipse(x,y,15,15);
  }
  
}
