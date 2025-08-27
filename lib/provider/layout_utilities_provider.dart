import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_explorer/utilities/layout_type.dart';

class LayoutUtilitiesProvider extends ChangeNotifier{
  LayoutType _layoutType = LayoutType.grid;
  LayoutType get layoutType => _layoutType;
  TextStyle _textStyle = GoogleFonts.merriweather();
  TextStyle get textStyle => _textStyle;
  int _gridSize = 6;
  int get gridSize => _gridSize;
  double _textSize = 12.5;
  double get textSize => _textSize;

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
  void setTextStyle(TextStyle textStyle){
    _textStyle = textStyle;
    notifyListeners();
  }
  void setTextSize(double textSize){
    _textSize = textSize;
    notifyListeners();
  }
}