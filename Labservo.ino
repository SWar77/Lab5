#include <Servo.h>

Servo servoMotor; 
int servoPin = 9; 

int trigPin = 7; 
int echoPin = 6; 

long duration, distance; 

int buzzerPin = 5;

void setup() {
  servoMotor.attach(servoPin);
  pinMode(trigPin, OUTPUT); 
  pinMode(echoPin, INPUT); 
  pinMode(buzzerPin, OUTPUT);
  Serial.begin(9600); 
}

void loop() {
  for(int i=15; i<=165; i+=15) {
    servoMotor.write(i);
    delay(300);
    distance = calculateDistance();
    if(distance <100) {
      digitalWrite(buzzerPin, HIGH);
      Serial.println(distance);
    } else {
      digitalWrite(buzzerPin, LOW);
    }
  }
}

long calculateDistance() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  distance = (duration/2) / 29.1;
  return distance;
}