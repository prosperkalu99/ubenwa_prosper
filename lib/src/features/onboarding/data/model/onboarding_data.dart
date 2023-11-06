import 'package:flutter/material.dart';

class OnboardingData {
  final String title;
  final String body;
  final String image;

  const OnboardingData({required this.title, required this.body, required this.image});
}

class BabyImageData {
  final String image;
  Color color;

  BabyImageData({required this.image, required this.color});
}