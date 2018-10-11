class Motor{
  Pico pico;
  Base base;
  RevoluteJoint joint;
  float alto = 280;
  int lado;
  
  Motor(float x, float y, int ladoP){
    base = new Base(x, y - alto / 2, 10, alto); 
    pico = new Pico(x, y - alto + 5);
    lado = ladoP;
    
    RevoluteJointDef revoluteJointDef = new RevoluteJointDef();
    revoluteJointDef.initialize(base.body, pico.body, pico.body.getTransform().p);
    revoluteJointDef.motorSpeed = PI * lado;
    revoluteJointDef.maxMotorTorque = 500000000;
    revoluteJointDef.referenceAngle = 0;
    
    revoluteJointDef.lowerAngle = radians(-90 * -lado); 
    revoluteJointDef.upperAngle = radians(-45 * -lado); 
    revoluteJointDef.enableMotor = true;
    revoluteJointDef.enableLimit = true;
    
    joint = (RevoluteJoint) box2d.world.createJoint(revoluteJointDef);
  }
  
  void display(){
    if(joint.getJointAngle() <= joint.getLowerLimit()){
      joint.setMotorSpeed(PI * -lado); 
    }
    if(joint.getJointAngle() >= joint.getUpperLimit()){
      joint.setMotorSpeed(PI * lado); 
    }
    base.display();
    pico.display();
  }
}
