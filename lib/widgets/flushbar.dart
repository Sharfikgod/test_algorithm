import 'package:another_flushbar/flushbar.dart';

import 'package:flutter/material.dart';

Future showPopup(BuildContext context, {required String text, required bool isPositive}) {
  return Flushbar(
    margin: const EdgeInsets.all(16),
    flushbarPosition: FlushbarPosition.TOP,
    messageText: Text(text),
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.white,
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    borderColor: isPositive ? Colors.green : Colors.red,
    icon: isPositive
        ? const Icon(
            Icons.done,
            color: Colors.green,
          )
        : const Icon(
            Icons.close,
            color: Colors.red,
          ),
  ).show(context);
}
