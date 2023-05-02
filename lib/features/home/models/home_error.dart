import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HomeError extends Equatable {
  final IconData icon;
  final String message;

  const HomeError(this.icon, this.message);

  @override
  List<Object?> get props => [icon, message];
}
