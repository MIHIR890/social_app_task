// data/models/user_model.dart

import 'package:ftfl_assignment/modules/home/domain/user_entity.dart';


class UserModel extends UserEntity {
  const UserModel({
    required super.fullName,
    required super.image,
    required super.age,
    required super.city,
    required super.country,
  });

  factory UserModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return UserModel(
      fullName:
      "${json['name']['first']} ${json['name']['last']}",
      image: json['picture']['large'],
      age: json['dob']['age'],
      city: json['location']['city'],
      country: json['location']['country'],
    );
  }
}