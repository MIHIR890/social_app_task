// domain/entities/user_entity.dart

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String fullName;
  final String image;
  final int age;
  final String city;
  final String country;

  const UserEntity({
    required this.fullName,
    required this.image,
    required this.age,
    required this.city,
    required this.country,
  });

  @override
  List<Object?> get props => [
    fullName,
    image,
    age,
    city,
    country,
  ];
}