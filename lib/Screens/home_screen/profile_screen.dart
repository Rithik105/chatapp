import 'package:chatapp/Widgets/clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  ClipPath(
                    clipper: CustomCurve(),
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter,
                              colors: [
                            Color.fromARGB(255, 0, 238, 255),
                            Color.fromARGB(255, 255, 255, 255)
                          ])),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://p.kindpng.com/picc/s/24-248729_stockvader-predicted-adig-user-profile-image-png-transparent.png")),
                ),
              ),
            ],
          ),
          Text("data")
        ],
      ),
    );
  }
}
