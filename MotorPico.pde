class MotorPico{
  Pico pico;
  Base base;
  Joint joint;
  float alto = 280;
  
  MotorPico(float x, float y, int lado){
    base = new Base(x, y - alto / 2, 10, alto); 
    pico = new Pico(x, y - alto + 5);
    
    RevoluteJointDef revoluteJointDef = new RevoluteJointDef();
    revoluteJointDef.initialize(base.body, pico.body, pico.body.getTransform().p);
    revoluteJointDef.motorSpeed = PI * lado;
    revoluteJointDef.maxMotorTorque = 50000;
    revoluteJointDef.enableMotor = true;
    
    joint = box2d.world.createJoint(revoluteJointDef);
  }
  
  void display(){  
    base.display();
    pico.display();
  }
}
