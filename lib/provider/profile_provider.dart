
import 'package:flutter/material.dart';
import 'package:library_onlile/model/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel profile = ProfileModel(
    name: 'Suy Senghour',
    email: 'suysenghour@gmail.com',
    phone: '012 345 678',
    address: 'Phnom Penh, Cambodia',
    profileImage: 'https://i.pinimg.com/736x/ee/f8/c5/eef8c566bdc5309007361a44c68e13d1.jpg',
  );

  void updateProfile({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) {
    profile.name = name;
    profile.email = email;
    profile.phone = phone;
    profile.address = address;

    notifyListeners();
  }
}

