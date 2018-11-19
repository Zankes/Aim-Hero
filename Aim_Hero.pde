import java.awt.*;
import java.awt.event.*;
import com.jogamp.newt.opengl.GLWindow;

Robot robot;

float theta, rho, epsilon, deltaX, deltaY;

int x = 0;
int y = 0;
int sizeX = 20;
int sizeY = 20;
int time = 0;
int score = 0;
PVector look;
PVector camera_pos;

void setup() {
  size(displayWidth,displayHeight,P3D);
  
  theta = 0;
  rho = 0;
  epsilon = PI / 4;  
  camera_pos = new PVector(0,0,500);
  
    look = new PVector (cos(theta), tan(rho),sin(theta));

}

void draw() {
  clear();
  
  pushMatrix();
  translate(camera_pos.x + 100*look.x, camera_pos.y + 100*look.y, camera_pos.z+ 100*look.z);
  fill(255);
  noCursor();
  sphere(.5);
  popMatrix();
  strokeWeight(5);
  time = time++;
 
  target();
  walls();
  drawAxes();
  moveX();
  moveY();
  
  look = new PVector (cos(theta), tan(rho),sin(theta));
  
  PVector result = new PVector();
  PVector.mult(look, 6, result);
  PVector.add(look, camera_pos, result);
  //println(result);
  
  camera(camera_pos.x,camera_pos.y,camera_pos.z,
    look.x + camera_pos.x, look.y + camera_pos.y,look.z + camera_pos.z,
    0,-1,0);
  fill(255);
  //box(10);  
  
  strokeWeight(2);
  stroke(0,255,0);
  beginShape(LINES);
  //line(cos(theta)+15, tan(rho)+5, sin(theta),cos(theta)+15, tan(rho)-5, sin(theta));
  //line(cos(theta)+15+5, tan(rho), sin(theta),cos(theta)+15-5, tan(rho), sin(theta));
  endShape();
  
  
  pushMatrix();
  textSize(20);
  text(score,0,0,0);
  
  popMatrix();
}

void drawAxes() {
  //stroke(255,0,0);
  //line(0,0,0,1000,0,0);
  
  //stroke(0,255,0);
  //line(0,0,0,0,1000,0);
  
  //stroke(0,0,255);
  //line(0,0,0,0,0,1000);
}

int j = 2;
int k =2;

void target() {
  stroke(255,0,0);
  ellipse(x,y,sizeX,sizeY);
  ellipse(x,y,sizeX/2,sizeY/2);
  ellipse(x,y,sizeX/8,sizeY/8);
  
   x= x+j;
  y= y+k;
  
  if (x == 230) {
   j=j*-1;
   k=k*1;
  }
  
  if(y == 170) {
    j=j*1;
    k=k*-1;
  }
  
  if(x == -230) {
    j=j*-1;
    k=k*1;
  }
  
  if(y == -170) {
    j=j*1;
    k=k*-1;
  }
 
}

void mouseClicked() {
    
 
 PVector target = new PVector(x - 0, y - 0, 0 - 500);
 target.normalize();  // turns target into unit vector ;)


 //PVector eye = new PVector(cos(theta), 0, sin(theta)); // where theta was the result of all that shitty math in the beginning of the draw function lol
  
 if (PVector.angleBetween(target, look) < PI / 100) {
   score = score + 1;
   println("Score:", score);
}
}

void moveX() {
    if (mouseX == pmouseX && pmouseX < 5)
    deltaX += PI * 2 / 180;
    
  if (mouseX == pmouseX && pmouseX > width-5)
    deltaX -= PI * 2 / 180;
  
  theta = map(mouseX, 0, width, deltaX + epsilon, deltaX - epsilon);
  
}

void moveY() {
   if (mouseY == pmouseY && pmouseY < 0)
    deltaY += PI * 2 / 500;
    
  if (mouseY == pmouseY && pmouseY > height-0)
    deltaY -= PI * 2 / 500;
  
  rho = map(mouseY, 0, height, deltaY + epsilon, deltaY - epsilon);
  
}

void walls() {
  stroke(0,0,255);
  fill(235);
  
  translate(0,0,-50);
  box(500,500,20);
  
  fill(50);
  translate(0,0,10);
  box(500,400,5);
  
  fill(235);
  translate(0,-500,50);
  box(10000,10,10000);
  
  translate(300,500,0);
  box(100,500,300);
  
  translate(-600,0,0);
  box(100,500,300);
}