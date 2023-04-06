import processing.serial.*;

Serial port;
int distance;
float servoAngle = 0;
void setup() {
  size(600, 600);
  port = new Serial(this, "COM5", 9600);
}
void draw() {
  background(255);
  stroke(0);
  noFill();
  ellipse(width/2, height/2, 400, 400);
  fill(255, 0, 0);
  float r = map(distance, 0, 200, 0, 200);
  float x = r * cos(radians(servoAngle));
  float y = r * sin(radians(servoAngle));
  ellipse(width/2 + x, height/2 + y, 10, 10);
  stroke(0, 0, 255);
  float angle = 0;
  for (int i = 0; i < 12; i++) {
    line(width/2, height/2, width/2 + 200 * cos(radians(angle)), height/2 + 200 * sin(radians(angle)));
    angle += 30;
  }
  stroke(255, 0, 0);
  line(width/2, height/2, width/2 + 200 * cos(radians(servoAngle)), height/2 + 200 * sin(radians(servoAngle)));
  textSize(20);
  text("Distancia: " + distance + " cm", 20, 40);
}
void serialEvent(Serial port) {
  String data = port.readStringUntil('\n');
  if (data != null) {
    distance = Integer.parseInt(data.trim());
  }
  servoAngle = (servoAngle + 1) % 360;
}
