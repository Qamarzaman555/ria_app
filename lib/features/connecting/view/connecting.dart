import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/app_background/app_background.dart';

class Connecting extends StatelessWidget {
  const Connecting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 60),
          child: Center(
            child: Text("Connecting...",
                style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
