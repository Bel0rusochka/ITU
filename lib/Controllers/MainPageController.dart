import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:itu_dev/Models/MainPageModel.dart';

class MainPageController extends ControllerMVC{

  factory MainPageController(){
    if(_this == null) _this = MainPageController._();
    return _this;
  }

  static MainPageController _this = MainPageController._();
  MainPageController._();

  void tapNotification(){
    print("бац");
  }

}