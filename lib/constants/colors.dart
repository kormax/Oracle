import 'dart:ui';


class Colors_ {

  const Colors_();

  // Primary color
  static const primaryNormal = Color(0xFF6367AD);
  static const primaryLight = Color(0xFFBABDF5);
  static const primaryLightest = Color(0xFFE5E7FF);


  static const primary = primaryNormal;


  // Grayscale
  static const grayscaleBlack = Color(0xFF242629);
  static const grayscaleDarkest = Color(0xFF2D2F33);
  static const grayscaleDark = Color(0xFF4B4D52);
  static const grayscaleNeutral = Color(0xFF939599);
  static const grayscaleLight = Color(0xFFECECEC);
  static const grayscaleLightest = Color(0xFFF6F6F6);
  static const grayscaleWhite = Color(0xFFFFFFFF);


  // Activeness colors
  static const disabledPrimary = grayscaleLight;
  static const enabledPrimary = primaryLightest;
  static const activePrimary = primaryLight;
  static const selectedPrimary = primaryNormal;

  static const disabledSecondary = grayscaleNeutral;
  static const enabledSecondary = primaryNormal;
  static const activeSecondary = grayscaleDarkest;
  static const selectedSecondary = grayscaleWhite;


  // Helper colors
  static const infoPrimary = Color(0xFF4163DA);
  static const successPrimary = Color(0xFF36BD3C);
  static const warningPrimary = Color(0xFFFFB03A);
  static const errorPrimary = Color(0xFFDA5D41);

  static const infoSecondary = Color(0xFFECEFFB);
  static const successSecondary = Color(0xFFEBF8EC);
  static const warningSecondary = Color(0xFFFFF5E6);
  static const errorSecondary = Color(0xFFFBEFEC);

}

