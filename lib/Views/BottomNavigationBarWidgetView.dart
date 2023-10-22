import 'package:flutter/material.dart';
import 'package:itu_dev/Controllers/BottomNavigationBarWidgetController.dart';
import 'package:itu_dev/Views/TipsPageView.dart';
import 'package:itu_dev/Views/MainPageView.dart';
import 'package:itu_dev/Views/BalancePageView.dart';
import 'package:itu_dev/Views/GoalsPageView.dart';
import 'package:itu_dev/Views/DebtPageView.dart';




class BottomNavigationBarWidgetView extends StatelessWidget{
  BottomNavigationBarWidgetView({super.key});
  final BottomNavigationBarWidgetController _controller = BottomNavigationBarWidgetController();

  Image _getImage(path){

    return Image.asset(
      path,
      width: 45,
      height: 45,
    );
  }

  @override
  Widget build(BuildContext context){
    return BottomAppBar(
      height: 90,
      color: const Color.fromARGB(255, 95, 168, 211),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              icon: _getImage('images/tips.png'),
              iconSize: 55,
              onPressed: (){
               _controller.changePage(const TipsPageView(title: "My Financial advice"), context);
              }
          ), //tips button
          IconButton(
              icon: _getImage('images/balance.png'),
              iconSize: 55,
              onPressed: (){
                _controller.changePage(const BalancePageView(title: 'My Balance'), context);
              }
          ),//balance button
          Container(
            width: 67,
            height: 67,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 231, 245, 255),
            ),
            child: InkWell(
              onTap: () {
                _controller.changePage(const MainPageView(title: 'Hello,\nUser!'), context);
              },
              child: const Icon(
                Icons.home,
                size: 60,
                color: Colors.black,
              ),
            ),
          ),// Main button
          IconButton(
              icon: _getImage('images/goal.png'),
              iconSize: 55,
              onPressed: (){
                _controller.changePage(const GoalsPageView(title: 'My Goals'), context);
              }
          ),// goals button
          IconButton(
              icon: _getImage('images/debt.png'),
              iconSize: 55,
              onPressed: (){
                _controller.changePage(const DebtPageView(title: 'My Debt'), context);
              }
          ), // debt button
        ],
      ),
    );
  }
}