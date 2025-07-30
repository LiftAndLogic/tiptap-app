import 'package:flutter/material.dart';

class TipSlider extends StatelessWidget {
  const TipSlider({
    super.key,
    required double tipPecentage, required this.onChanged,
  }) : _tipPecentage = tipPecentage;

  final double _tipPecentage;
  final ValueChanged <double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _tipPecentage, 
      onChanged: onChanged,
      min: 0,
      max: 0.5,
      divisions: 5,
      label: '${(_tipPecentage*100).round()}%',
    );
  }
}