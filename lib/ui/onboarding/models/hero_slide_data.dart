import 'package:flutter/material.dart';

class HeroSlideData {
  const HeroSlideData({
    required this.headline,
    required this.highlight,
    required this.background,
  });

  final String headline;
  final String highlight;
  final Gradient background;
}
