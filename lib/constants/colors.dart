import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

// Define color constants for clarity
const Color bluishColor = Color(0xFF4e5ae8);
const Color yellowColor = Color(0xFFFFB746);
const Color pinkColor = Color(0xFFff4667);
const Color whiteColor = Colors.white;
const Color primaryColor = bluishColor;
const Color darkGreyColor = Color(0xFF121212);
const Color darkHeaderColor = Color(0xFF424242);

const Color blueColor = Color(0xFF4e5ae8);

const Color greenColor = Color(0xFF2ed93d);
const Color grayColor = Colors.grey;


const Color lightGreyColor = Color(0xFF999999);

const Color blackColor = Color(0xFF000000);

const Color redColor = Color(0xFFFF0000);

const Color orangeColor = Color(0xFFFF9900);

const Color blueOreo = Color(0xFFBBDEFB); // 0xFFBBDEFB is the hexadecimal value for Colors.blue[100]


const Color turquoiseGlassColor = Color(0xFF61B4B4); // Combination of blue and green
const Color goldenGlassColor = Color(0xFFFFC300); // Combination of yellow and orange
const Color roseGlassColor = Color(0xFFE83E8C); // Combination of pink and red
const Color azureGlassColor = Color(0xFF5ED1FF); // Combination of blue and teal
const Color amethystGlassColor = Color(0xFF9B30FF); // Combination of purple and indigo
const Color tealColor = Color(0xFF00BCD4);
const Color purpleColor = Color(0xFF9C27B0);
const Color limeColor = Color(0xFFCDDC39);
const Color amberColor = Color(0xFFFFC107);
const Color indigoColor = Color(0xFF3F51B5);


// Define light and dark themes for the app
class Themes {
  static final light = ThemeData.light().copyWith(
    colorScheme: ColorScheme.light(
      background: Colors.white,
      primary: bluishColor,
    ),
  );

  static final dark = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.dark(
      background: darkGreyColor,
      primary: darkGreyColor,
    ),
  );
}

// Define text styles for consistency
TextStyle get subHeadings {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
      color: Get.isDarkMode ? whiteColor : Colors.black,
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Get.isDarkMode ? whiteColor : Colors.black,
    ),
  );
}

TextStyle get subtitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600],
    ),
  );
}
