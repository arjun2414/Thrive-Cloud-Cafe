import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  // void setupLoginPage() async {
  //   WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
  //   await instance.getTime();
  //   Navigator.pushReplacementNamed(context, '/home', arguments: {
  //     'location': instance.location,
  //     'flag': instance.flag,
  //     'time': instance.time
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF800000),
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 80.0,
          controller: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 700)),
        ),
      ),
    );
  }
}
