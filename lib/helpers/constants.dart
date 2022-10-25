const double caloriePound = 3500;

enum Gender { male, female }

enum Measurement {
  imperial("in", "lbs"),
  metric("cm", "kg");

  final String heightText;
  final String weightText;
  const Measurement(this.heightText, this.weightText);
}

enum Activity {
  couchPotato(1.2, "You live life on the couch, not much activity"),
  lightExercise(1.375, "Light exercise 1-3 times a week"),
  moderateExercise(1.55, "Moderate exercise 3-5 times a week"),
  activeExercise(
      1.725, "Intense excersie 6-7 times a week, and or very active"),
  athleticExercise(1.9, "You have an atheltic exercise/training regiment");

  final double points;
  final String text;
  const Activity(this.points, this.text);
}
