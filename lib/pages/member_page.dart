import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Provide<Counter>(
          builder: (context, child, counter) {
            return Text('${counter.value}');
          },
        ),
      ),
    );
  }
}
