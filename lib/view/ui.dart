import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:delete_account_dialog/delete_account.dart';

class Ui extends StatelessWidget {
  const Ui({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0f2027), Color(0xFF203a43), Color(0xFF2c5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                barrierColor: Colors.black45,
                builder: (_) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: AlertDialog(
                      contentPadding: const EdgeInsets.all(6.0),
                      // insetPadding: EdgeInsets.zero,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                      content:const Wrap(
                        children: [DeleteAccount()],
                      ),
                    ),
                  );
                },
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [Color(0xFFff416c), Color(0xFFff4b2b)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.6),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Text(
                "Delete My Account",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 6,
                      color: Colors.black45,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
