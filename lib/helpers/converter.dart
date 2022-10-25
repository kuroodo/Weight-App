class Converter {
  static double poundToKg(double pounds) {
    return pounds * 0.45359237;
  }

  static double kgToPound(double kg) {
    return kg * 2.20462262185;
  }

  static double inchToCm(double inches) {
    return inches * 2.54;
  }

  static double cmToInch(double cm) {
    return cm / 2.54;
  }

  static double cmtoMeter(double cm) {
    return cm * 0.01;
  }

  static double meterTocm(double m) {
    return m / 0.01;
  }
}
