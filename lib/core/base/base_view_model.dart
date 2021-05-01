import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

abstract class BaseViewModel {
  late BuildContext context;

  Logger logger = Logger();

  void setContext(BuildContext context);

  void init();
}
