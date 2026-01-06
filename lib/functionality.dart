import 'package:flutter/material.dart';
import 'buttons.dart';

class Functionality {
  static const int maxTotalChars = 15;

  static String myOutput = "";

  static void appendInput(
      String s,
      BuildContext context,
      void Function(VoidCallback fn) setState,
      ) {
    setState(() {

      // DIGITS
      if (Buttons.digitButtons.contains(s)) {
        if (myOutput.length >= maxTotalChars) {
          showLimitToast(context);
          return;
        }
        myOutput += s;
        return;
      }

      // CLEAR
      if (s == "AC") {
        myOutput = "";
        return;
      }

      // BACKSPACE
      if (s == "⌫") {
        if (myOutput.isNotEmpty) {
          myOutput = myOutput.substring(0, myOutput.length - 1);
        }
        return;
      }

      // DOT
      if (s == ".") {
        if (myOutput.length >= maxTotalChars) {
          showLimitToast(context);
          return;
        }

        if (myOutput.isEmpty) {
          myOutput = "0.";
          return;
        }

        if (currentNumberHasDot()) return;

        myOutput += ".";
        return;
      }

      // PERCENT
      if (s == "%") {
        if (myOutput.isEmpty || endsWithOperator()) return;

        int index = lastOperatorIndex();
        String number = myOutput.substring(index + 1);
        double value = double.parse(number) / 100;

        myOutput =
            myOutput.substring(0, index + 1) +
                (value % 1 == 0 ? value.toInt().toString() : value.toString());
        return;
      }

      // EQUALS
      if (s == "=") {
        if (myOutput.isEmpty) return;

        if (endsWithOperator()) {
          myOutput = myOutput.substring(0, myOutput.length - 1);
        }

        try {
          double res = evaluateExpression(myOutput);
          myOutput = res % 1 == 0
              ? res.toInt().toString()
              : res.toString();
        } catch (e) {
          showErrorSnackBar(context, "Invalid calculation");
        }
        return;
      }

      // ✅ OPERATORS (+ - * ÷)
      if (Buttons.opratorButtons.contains(s)) {
        if (myOutput.length >= maxTotalChars) {
          showLimitToast(context);
          return;
        }

        if (myOutput.isEmpty || endsWithOperator()) return;

        myOutput += s;
        return;
      }
    });
  }


  // ---------- UI helpers ----------

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red.shade700,
      ),
    );
  }



  static void showLimitToast(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Maximum 15 characters allowed"),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static List<String> getDisplayLines({int maxChars = 15, int maxLines = 2}) {
    if (myOutput.isEmpty) return ["0"];

    List<String> lines = [];

    for (int i = 0; i < myOutput.length; i += maxChars) {
      lines.add(
        myOutput.substring(
          i,
          (i + maxChars > myOutput.length)
              ? myOutput.length
              : i + maxChars,
        ),
      );
    }

    if (lines.length > maxLines) {
      lines = lines.sublist(lines.length - maxLines);
    }

    return lines;
  }

  // ---------- logic helpers ----------

  static bool isOperator(String c) {
    return Buttons.opratorButtons.contains(c) && c != "=";
  }

  static bool endsWithOperator() {
    if (myOutput.isEmpty) return false;
    return isOperator(myOutput.characters.last);
  }

  static bool currentNumberHasDot() {
    for (int i = myOutput.length - 1; i >= 0; i--) {
      if (isOperator(myOutput[i])) break;
      if (myOutput[i] == ".") return true;
    }
    return false;
  }

  static int lastOperatorIndex() {
    for (int i = myOutput.length - 1; i >= 0; i--) {
      if (isOperator(myOutput[i])) return i;
    }
    return -1;
  }

  // ---------- evaluator ----------

  static double evaluateExpression(String exp) {
    debugPrint("Input expression: $exp");

    exp = exp.replaceAll("×", "*").replaceAll("÷", "/");
    debugPrint("Normalized expression: $exp");

    List<String> tokens = [];
    String number = "";

    // TOKENIZATION
    for (int i = 0; i < exp.length; i++) {
      String ch = exp[i];

      if ("0123456789.".contains(ch)) {
        number += ch;
      } else {
        if (number.isNotEmpty) {
          tokens.add(number);
          number = "";
        }
        tokens.add(ch);
      }
    }

    if (number.isNotEmpty) tokens.add(number);

    debugPrint("Tokens after parsing: $tokens");

    // HANDLE * and /
    for (int i = 0; i < tokens.length; i++) {
      if (tokens[i] == "*" || tokens[i] == "/") {
        double left = double.parse(tokens[i - 1]);
        double right = double.parse(tokens[i + 1]);

        if (tokens[i] == "/" && right == 0) {
          throw Exception("Division by zero");
        }

        double result =
        tokens[i] == "*" ? left * right : left / right;

        debugPrint("Computed $left ${tokens[i]} $right = $result");

        tokens.replaceRange(i - 1, i + 2, [result.toString()]);
        debugPrint("Tokens now: $tokens");

        i--;
      }
    }

    // HANDLE + and -
    double result = double.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i += 2) {
      String op = tokens[i];
      double next = double.parse(tokens[i + 1]);

      debugPrint("Applying $op $next");

      if (op == "+") result += next;
      if (op == "-") result -= next;
    }

    debugPrint("Final result: $result");
    return result;
  }

}
