import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:faker/faker.dart';

final faker = Faker();
final _random = Random();
const uuid = Uuid();

class Question {
  String id;

  Question({
    Key? key,
    this.id = '',
  });
}


