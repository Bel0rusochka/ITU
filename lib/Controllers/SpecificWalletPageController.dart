import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:itu_dev/Views/SpecificWalletView.dart';
import 'package:itu_dev/Models/SpecificWalletPageModel.dart';

class WalletPageController extends ControllerMVC {
  final IncomePageModel _model = IncomePageModel();

  factory WalletPageController(){
    _this ??= WalletPageController();
    return _this;
  }

  static WalletPageController _this = WalletPageController._();

  WalletPageController._();

  void gotoPage(pageObj, context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => pageObj),
    );
  }
}