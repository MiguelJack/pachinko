class MotorPico{
  Pico pico;
  Base base;
  RevoluteJoint joint;
  int lado;
  float lAngle;
  float uAngle;
  
  MotorPico(float x, float y, int ladoP, Base baseP, Pico picoP, float lAngleP, float uAngleP){
    base = baseP; 
    pico = picoP;
    lado = ladoP;
    lAngle = lAngleP;
    uAngle = uAngleP;
    
    RevoluteJointDef revoluteJointDef = new RevoluteJointDef();
    revoluteJointDef.initialize(base.body, pico.body, pico.body.getTransform().p);
    revoluteJointDef.motorSpeed = PI/2 * lado;
    revoluteJointDef.maxMotorTorque = 500000000;
    revoluteJointDef.referenceAngle = 0;
    
    revoluteJointDef.lowerAngle = radians(lAngle); 
    revoluteJointDef.upperAngle = radians(uAngle); 
    revoluteJointDef.enableMotor = true;
    revoluteJointDef.enableLimit = true;
    
    joint = (RevoluteJoint) box2d.world.createJoint(revoluteJointDef);
  }
  
  void display(){
    int mult = 1;
    if (lado > 0){
      mult = -1;
    }
    if(joint.getJointAngle() <= joint.getLowerLimit()){
      joint.setMotorSpeed(PI/2 * -lado * mult); 
    }
    if(joint.getJointAngle() >= joint.getUpperLimit()){
      joint.setMotorSpeed(PI/2 * lado * mult); 
    }
    base.display();
    pico.display();
  }
}
