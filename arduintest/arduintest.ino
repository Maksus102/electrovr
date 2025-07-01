int val = 0;
int incomingByte = 0;
#define POT_PIN A0

void setup() {
  Serial.begin(9600);
  pinMode(POT_PIN, INPUT);
}

void loop() {
  if (Serial.available() > 0) {  
    incomingByte = Serial.read();
    if (incomingByte == 1)
    {val = analogRead(POT_PIN);
    Serial.println(val);
    delay(100);}
}
}
