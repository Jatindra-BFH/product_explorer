import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_explorer/utilities/layout_type.dart';

class LayoutUtilitiesProvider extends ChangeNotifier{
  LayoutType _layoutType = LayoutType.grid;
  LayoutType get layoutType => _layoutType;
  TextTheme _textTheme = GoogleFonts.merriweatherTextTheme();
  TextTheme get textTheme => _textTheme;
  int _gridSize = 8;
  int get gridSize => _gridSize;
  int _textSize = 20;
  int get textSize => _textSize;

  void setGridSize(int? newGridSize){
    if(newGridSize==null){ 
      _gridSize++;
    }
    else{ 
      _gridSize = newGridSize;
    }
    notifyListeners();
  }
  void setLayoutType(LayoutType layoutType){
    _layoutType = layoutType;
    notifyListeners();
  }
  void setTextTheme(TextTheme textTheme){
    _textTheme = textTheme;
    notifyListeners();
  }
  void setColorScheme(ColorScheme _colorScheme){

  }
  void setTextSize(int textSize){
    _textSize = textSize;
    notifyListeners();
  }
}