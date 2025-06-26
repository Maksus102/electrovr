int val = 0;
#define POT_PIN A0

void setup() {
  Serial.begin(9600);
  pinMode(POT_PIN, INPUT);

}

void loop() {

  val = analogRead(POT_PIN);
  Serial.println(val);
  delay(100);
}
