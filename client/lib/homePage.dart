import 'package:flutter/material.dart';
import 'package:client/widgets/roundedButton.dart';
import 'widgets/cardWidget.dart';
import 'widgets/transferHistoryWidget.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

enum Menu { itemOne, itemTwo, itemThree }

class _HomePageState extends State<HomePage> {
  final sonrBalance = 86.67;
  final attBalance = 72.39;
  // showPopupMenu() {
  //   showMenu<String>(
  //     context: context,
  //     position: RelativeRect.fromLTRB(5.0, 5.0, 0.0,
  //         0.0), //position where you want to show the menu on screen
  //     items: [
  //       PopupMenuItem<String>(child: const Text('Your Info'), value: '1'),
  //     ],
  //     elevation: 8.0,
  //   ).then<void>((String itemSelected) {
  //     if (itemSelected == null) return;

  //     if (itemSelected == "Your Info") {
  //       //code here
  //     } else {
  //       //code here
  //     }
  //   });
  // }

  @override
  String _selectedMenu = '';
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131313),
      appBar: AppBar(
        backgroundColor: Color(0xFF131313),
        elevation: 0.0,
        actions: <Widget>[
          PopupMenuButton<Menu>(
              // Callback that sets the selected popup menu item.
              onSelected: (Menu item) {
                setState(() {
                  _selectedMenu = item.name;
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                    const PopupMenuItem<Menu>(
                      value: Menu.itemOne,
                      child: Text('Your Info'),
                    ),
                    const PopupMenuItem<Menu>(
                      value: Menu.itemTwo,
                      child: Text('Ads Dashboard'),
                    ),
                    const PopupMenuItem<Menu>(
                      value: Menu.itemThree,
                      child: Text('Permissions'),
                    ),
                  ]),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, top: 20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'BALANCE',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "\$" + "${sonrBalance + attBalance}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    CardWidget(
                      gradientBegin: Alignment.topLeft,
                      gradiendEnd: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 235, 137, 147),
                        Color.fromARGB(255, 137, 85, 157)
                      ],
                      text: "Sonr Tokens",
                      coins: "23.6 SNR",
                      dollars: "\$" + "${sonrBalance}",
                    ),
                    SizedBox(width: 10.0),
                    CardWidget(
                      gradientBegin: Alignment.topLeft,
                      gradiendEnd: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(255, 84, 210, 168),
                        Color.fromARGB(255, 11, 109, 90)
                      ],
                      text: "AttCoin",
                      coins: "79.05 ACN",
                      dollars: "\$" + "${attBalance}",
                    )
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RoundedButton(
                      iconData: LineAwesomeIcons.download,
                      color: Colors.green[300],
                    ),
                    // SizedBox(width: 20.0),
                    RoundedButton(
                      iconData: LineAwesomeIcons.upload,
                      color: Colors.pink[300],
                    ),
                    // SizedBox(width: 20.0),
                    RoundedButton(
                      iconData: LineAwesomeIcons.credit_card,
                      color: Colors.white,
                    ),
                    // SizedBox(width: 20.0),
                    RoundedButton(
                      iconData: LineAwesomeIcons.undo,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                "TRANSFER HISTORY",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TransterHistorWidget(
                      iconData: LineAwesomeIcons.download,
                      text: "Received",
                      date: "15 Sept",
                      coins: "0.52 SNR",
                      dollars: "\$3.48",
                      color: Colors.green[400]),
                  SizedBox(height: 20.0),
                  TransterHistorWidget(
                    iconData: LineAwesomeIcons.upload,
                    text: "Sent",
                    date: "13 Sept",
                    coins: "-0.09 ACN",
                    dollars: "-\$1.14",
                    color: Colors.pink[400],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
