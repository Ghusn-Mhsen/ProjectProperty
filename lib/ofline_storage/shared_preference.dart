import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StorageState {
  static const IMAGE_KEY = 'IMAGE_KEY';
  static SharedPreferences pref;

  static void setData(String id, String firstName, String lastName,
      String email, String token) async {
    pref = await SharedPreferences.getInstance();
    pref.setString("id", id);
    pref.setString("firstName", firstName);
    pref.setString("lastName", lastName);
    pref.setString("email", email);
    pref.setString("token", token);
  }

  static void removeData() async {
    pref = await SharedPreferences.getInstance();
    pref.remove("id");
    pref.remove("firstName");
    pref.remove("lastName");
    pref.remove("email");
    pref.remove("token");
  }

  static Future<String> getId() async {
    pref = await SharedPreferences.getInstance();
    return pref.getString("id");
  }

  static Future<String> getFirstName() async {
    pref = await SharedPreferences.getInstance();
    return pref.getString("firstName");
  }

  static Future<String> getLastName() async {
    pref = await SharedPreferences.getInstance();
    return pref.getString("lastName");
  }

  static Future<String> getEmail() async {
    pref = await SharedPreferences.getInstance();
    return pref.getString("email");
  }

  static Future<String> getToken() async {
    pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

  /************************************************************/


  static Future<bool> saveImageToPrefs(String value) async {
    pref = await SharedPreferences.getInstance();

    return await pref.setString(IMAGE_KEY, value);
  }

  static Future<bool> emptyPrefs() async {
    pref = await SharedPreferences.getInstance();

    return await pref.clear();
  }

  static Future<String> loadImageFromPrefs() async {
    pref = await SharedPreferences.getInstance();
    return pref.getString(IMAGE_KEY);
  }

  // encodes bytes list as string
  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  // decode bytes from a string
  static imageFrom64BaseString(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

}


