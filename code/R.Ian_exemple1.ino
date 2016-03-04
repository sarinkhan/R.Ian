#include <Pushbutton.h>

/*
 * Squelette du programme de base
 */
 #define LEFT_SERVO 9
 #define RIGHT_SERVO 10
 #define SENSOR_SERVO 11
 #define LEFT_SWITCH 2
 #define RIGHT_SWITCH 3
 Servo leftServo,rightServo,sensorServo;
 
// Ces valeurs sont dans des constantes, car elle ne changeront pas pendant l'exécution.
// elles permettent de définir  les broches utilisées
const int analogInPin = A0;  //Broche du capteur de distance
const int ledPin = 13;       //Broche de la LED

int speed01=30;             //Vitesse du robot

int dureeClignLed=250;
int etatLeds=0;
long int dernierChangementLed=0;

int dureeMoteurs=250;
long int dernierCHangementMoteurs=0;

Pushbutton leftButton(LEFT_SWITCH);  //permet d'utiliser le contacteur gauche via button.isPressed()
Pushbutton rightButton(RIGHT_SWITCH);//permet d'utiliser le contacteur droit  via button.isPressed()

/**
 * Cette fonction fait avancer le robot jusqu'à nouvel ordre
 */
void avancer()
{
  leftServo.write(92+speed01);
  rightServo.write(94-speed01);
}

/**
 * Cette fonction fait reculer le robot jusqu'à nouvel ordre
 */
void reculer()
{
  leftServo.write(92-speed01);
  rightServo.write(94+speed01);
}

/**
 * Cette fonction fait tourner le robot à gauche jusqu'à nouvel ordre
 */
void gauche()
{
  leftServo.write(92-speed01);
  rightServo.write(94-speed01);
}

/**
 * Cette fonction fait tourner le robot à droite jusqu'à nouvel ordre
 */
void droite()
{
  leftServo.write(92+speed01);
  rightServo.write(94+speed01);
}

/**
 * Cette fonction arrete immediatement les moteurs.
 */
void arret()
{
  leftServo.write(92);
  rightServo.write(94);
}


/**
 * Cette fonction mesure la distance et retourne une valeur enntre 0 et 10
 */
float lireDistance()
{
  int i=0;
  float d=0;
  int s=0;
  for(i=0;i<10;i++)
  {
    int d0=analogRead(analogInPin);
    s=s+d0;
  }
  d=s/10.0;
  d=600/d;
  d=d-1;
  if(d<0)
  {
    d=0;
  }
  else if(d>10)
  {
    d=10;
  }
  return d;
}


/**
 * fonction exécutée une fois au démarrage du robot
 */
void setup()
{
  leftServo.attach(LEFT_SERVO);
  rightServo.attach(RIGHT_SERVO);
  sensorServo.attach(SENSOR_SERVO);

  pinMode(ledPin, OUTPUT);    //configure la broche de la LED comme une broche de sortie
  Serial.begin(9600);         //permet d'utiliser le moniteur série pour faire des affichages

  dernierChangementLed=millis();
  sensorServo.write(90);
}

  
  
/**
 * Fonction principale, qui est une boucle infinie
 */
void loop()
{
	float d=lireDistance();
	Serial.print("distance=");
	Serial.println(d);

	if(leftButton.isPressed())
	{
	  Serial.println("left");
	  reculer();
	  delay(50);
	  droite();
	  delay(200);
	}
	else if(rightButton.isPressed())
	{
	  Serial.println("right");
		reculer();
	  delay(50);
	  gauche();
	  delay(200);
	}
	else
	{
	  avancer();
	}

} 
