import 'package:flutter/material.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';

class TipsPageView extends StatefulWidget {
  const TipsPageView({super.key, required this.title});

  final String title;

  @override
  State<TipsPageView> createState() => _TipsPageViewState();
}

class _TipsPageViewState extends State<TipsPageView>{
  final double _wightBubble = 372.0;
  final double _hightBubble = 101.0;
  final Color _colorBubble = Color.fromARGB(255, 62, 210, 94);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.lightBlue.shade50,
        title: Text(widget.title, style: const TextStyle(fontSize: 28)),
      ),
      body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => const TipsTextPage(title: "My Financial advice",textTitle: "Maintain a budget", text: "Set a monthly budget and track expenses. "
            //               "Define financial goals and priorities to allocate funds properly. "
            //               "Develop a detailed budget, including housing, food, debt, and savings. "
            //               "Ensure your income covers these expenses. "
            //               "Regularly monitor spending and make adjustments if needed to manage your money effectively and achieve financial goals.")),
            //         );
            //       },
            //       child: Container(
            //         height: _hightBubble,
            //         width: _wightBubble,
            //         decoration: BoxDecoration(
            //           color: _colorBubble,
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: const Center(
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: <Widget>[
            //               Text(
            //                 'Maintain a budget',
            //                 style: TextStyle(
            //                   fontSize: 16, // Размер текста
            //                 ),
            //               ),
            //               Text(
            //                 '1-2 hours per month',
            //                 style: TextStyle(
            //                   color: Color.fromARGB(150, 78, 77, 77),
            //                   fontSize: 12, // Размер текста
            //                 ),
            //               ),
            //               // Другие виджеты с текстом или элементы интерфейса
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(height: 7),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => const TipsTextPage(title: "My Financial advice",textTitle: "Create an emergency fund", text: "Building an emergency fund is vital for financial stability. "
            //               "It serves as a safety net during unexpected situations like medical emergencies or job loss. "
            //               "Aim to save three to six months' worth of living expenses. "
            //               "Set a realistic goal, create a separate savings account, cut unnecessary expenses, and automate monthly contributions. "
            //               "Financial security starts with planning – start your emergency fund today.")),
            //         );
            //       },
            //       child: Container(
            //         height: _hightBubble,
            //         width: _wightBubble,
            //         decoration: BoxDecoration(
            //           color: _colorBubble,
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: const Center(
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: <Widget>[
            //               Text(
            //                 'Create an emergency fund',
            //                 style: TextStyle(
            //                   fontSize: 16, // Размер текста
            //                 ),
            //               ),
            //               Text(
            //                 '1-2 hours ',
            //                 style: TextStyle(
            //                   color: Color.fromARGB(150, 78, 77, 77),
            //                   fontSize: 12, // Размер текста
            //                 ),
            //               ),
            //               // Другие виджеты с текстом или элементы интерфейса
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(height: 7),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => const TipsTextPage(title: "My Financial advice",textTitle: "Analyze your spending", text: "Analyzing spending is essential for financial stability. "
            //               "Track all expenses, use budgeting tools, and categorize spending. "
            //               "Review statements, identify patterns, and cut costs. Set clear goals, create a budget, and prioritize savings. "
            //               "Be mindful of expenses, avoid impulse buying, and adjust habits as needed. "
            //               "This approach enables informed financial decisions and goal achievement.")),
            //         );
            //       },
            //       child:     Container(
            //         height: _hightBubble,
            //         width: _wightBubble,
            //         decoration: BoxDecoration(
            //           color: _colorBubble,
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: const Center(
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: <Widget>[
            //               Text(
            //                 'Analyze your spending',
            //                 style: TextStyle(
            //                   fontSize: 16, // Размер текста
            //                 ),
            //               ),
            //               Text(
            //                 '2-4 hours',
            //                 style: TextStyle(
            //                   color: Color.fromARGB(150, 78, 77, 77),
            //                   fontSize: 12, // Размер текста
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(height: 7),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => const TipsTextPage(title: "My Financial advice",textTitle: "Maintain a budget", text: "Maintaining a budget is fundamental for financial control. "
            //               "Track income and expenses, categorize spending, and allocate funds wisely. "
            //               "Regularly review and adjust the budget based on changing financial circumstances. "
            //               "Prioritize essential expenses, save for emergencies, and limit discretionary spending. "
            //               "Adhering to a budget promotes financial stability, helps achieve goals, and ensures a secure financial future.")),
            //         );
            //       },
            //       child: Container(
            //         height: _hightBubble,
            //         width: _wightBubble,
            //         decoration: BoxDecoration(
            //           color: _colorBubble,
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: const Center(
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: <Widget>[
            //               Text(
            //                 'Maintain a budget',
            //                 style: TextStyle(
            //                   fontSize: 16, // Размер текста
            //                 ),
            //               ),
            //               Text(
            //                 '3-4 hours per day',
            //                 style: TextStyle(
            //                   color: Color.fromARGB(150, 78, 77, 77),
            //                   fontSize: 12, // Размер текста
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(height: 7),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => const TipsTextPage(title: "My Financial advice",textTitle: "Invest Wisely for the Future", text: "Invest your money wisely to make it work for you. "
            //               "Understand different investment options such as stocks, bonds, and mutual funds. "
            //               "Diversify your investments to spread the risk. "
            //               "Consider consulting a financial advisor to make informed decisions.")),
            //         );
            //       },
            //       child: Container(
            //         height: _hightBubble,
            //         width: _wightBubble,
            //         decoration: BoxDecoration(
            //           color: _colorBubble,
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: const Center(
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: <Widget>[
            //               Text(
            //                 'Invest Wisely for the Future',
            //                 style: TextStyle(
            //                   fontSize: 16, // Размер текста
            //                 ),
            //               ),
            //               Text(
            //                 '1-2 hours per month',
            //                 style: TextStyle(
            //                   color: Color.fromARGB(150, 78, 77, 77),
            //                   fontSize: 12, // Размер текста
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(height: 7),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => const TipsTextPage(title: "My Financial advice",textTitle: "Eliminate High-Interest Debt", text: "High-interest debt, like credit card balances, can drain your finances. "
            //               "Create a plan to pay off these debts as quickly as possible. "
            //               "Prioritize high-interest debts while making minimum payments on others. "
            //               "This strategy saves money in the long run and.")),
            //         );
            //       },
            //       child: Container(
            //         height: _hightBubble,
            //         width: _wightBubble,
            //         decoration: BoxDecoration(
            //           color: _colorBubble,
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: const Center(
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: <Widget>[
            //               Text(
            //                 'Eliminate High-Interest Debt',
            //                 style: TextStyle(
            //                   fontSize: 16, // Размер текста
            //                 ),
            //               ),
            //               Text(
            //                 ' 1-2 hours',
            //                 style: TextStyle(
            //                   color: Color.fromARGB(150, 78, 77, 77),
            //                   fontSize: 12, // Размер текста
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(height: 7),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => const TipsTextPage(title: "My Financial advice",textTitle: "Live Below Your Means", text: "Avoid lifestyle inflation by living below your means. "
            //               "Assess your needs versus wants and make conscious spending choices. Budget carefully, distinguishing between essential and non-essential expenses. "
            //               "By spending less than you earn, you'll have more resources for saving, investing, and handling unexpected expenses.")),
            //         );
            //       },
            //       child: Container(
            //         height: _hightBubble,
            //         width: _wightBubble,
            //         decoration: BoxDecoration(
            //           color: _colorBubble,
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: const Center(
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: <Widget>[
            //               Text(
            //                 'Live Below Your Means',
            //                 style: TextStyle(
            //                   fontSize: 16, // Размер текста
            //                 ),
            //               ),
            //               Text(
            //                 '2-3 hours',
            //                 style: TextStyle(
            //                   color: Color.fromARGB(150, 78, 77, 77),
            //                   fontSize: 12, // Размер текста
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(height: 7),
            //   ],
            // ),
          )
      ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}
