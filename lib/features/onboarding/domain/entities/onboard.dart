import 'dart:ui';

import 'package:equatable/equatable.dart';

class Onboard extends Equatable {
  final String title;
  final String description;
  final String imageUrl;
  final Color color;

  const Onboard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.color,
  });

  @override
  List<Object?> get props => [title, description, imageUrl, color];
}
