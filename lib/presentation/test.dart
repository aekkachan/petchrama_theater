import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _verticalList(),
      ),
    );
  }

  Widget _horizontalList() => ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          width: 100,
          height: 100,
          color: Colors.amber,
        ),
      );

  Widget _verticalList() => ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          if (index % 2 == 0)
            return Container(
              height: 100,
              child: _horizontalList(),
            );
          else
            return Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              width: 100,
              height: 100,
              color: Colors.green,
            );
        },
      );
}
