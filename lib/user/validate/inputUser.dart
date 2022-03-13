import 'package:flutter/material.dart';

class Check
{
  static Pattern pattern =
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$';

// static Pattern phonePattern = r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]';
  static Pattern phonePattern = r'^[0-9]+$';

  // ignore: missing_return
  static String checkName(String value) {
    if (value.isEmpty) {
      return " user name can't empty";
    }
    if (value.contains(" ")) {
      return "user name can't contain space";
    }
    if (value.length < 2) {
      return "user name can't be\nless than two characters ";
    }
    if (value.length > 15) {
      return "user name can't be\nmore than 15 characters ";
    }
  }

  // ignore: missing_return
  static String checkPass(String value) {
    if (value.isEmpty) {
      return " password can't empty";
    }
    if (value.contains(" ")) {
      return "password can't contain space";
    }
    if (value.length < 6) {
      return "password can't be\nless than 5 characters ";
    }
    if (value.length > 20) {
      return "password can't be\nmore than 20 characters ";
    }
  }

  // ignore: missing_return
  static String checkMail(String value) {
    if (value.isEmpty) {
      return " Email can't empty";
    }
    if (value.contains(" ")) {
      return "Email can't contain space";
    }
    if (value.length < 10) {
      return "Email can't be\nless than 10 characters ";
    }
    if (value.length > 30) {
      return "Email can't be\nmore than 30 characters ";
    }
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Email address is invalid ";
    }
  }

  // ignore: missing_return
  static String checkPhone(String value) {
    if (value.isEmpty) {
      return " Phone can't empty";
    }
    if (value.contains(" ")) {
      return "Phone can't contain space";
    }
    if (value.length < 10) {
      return "Phone can't be\nless than 10 characters ";
    }
    if (value.length > 20) {
      return "Phone can't be\nmore than 30 characters ";
    }
    RegExp regex = RegExp(phonePattern);
    if (!regex.hasMatch(value)) {
      return "Phone Number is invalid ";
    }
  }

  // ignore: missing_return
  static String checkPrice(String value) {
    if (value.isEmpty) {
      return " Price can't empty";
    }
    if (value.contains(" ")) {
      return "Price can't contain space";
    }
    if (value.length > 30) {
      return "Price can't be\nmore than 30 characters ";
    }
    RegExp regex = RegExp(phonePattern);
    if (!regex.hasMatch(value)) {
      return "Price Number is invalid ";
    }
  }

  // ignore: missing_return
  static String checkArea(String value) {
    if (value.isEmpty) {
      return " Area can't empty";
    }
    if (value.contains(" ")) {
      return "Area can't contain space";
    }
    if (value.length > 30) {
      return "Area can't be\nmore than 30 characters ";
    }
    RegExp regex = RegExp(phonePattern);
    if (!regex.hasMatch(value)) {
      return "Area Number is invalid ";
    }
  }

  // ignore: missing_return
  static String checkKind(String value) {
    if (value.isEmpty) {
      return " Kind can't empty";
    }
    if (value.contains(" ")) {
      return "Kind can't contain space";
    }
    if (value != "rent" && value != "sale") {
      return "Kind must be ( sale OR rent)";
    }
  }
}
