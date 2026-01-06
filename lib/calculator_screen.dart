import 'package:calculator/functionality.dart';
import 'package:flutter/material.dart';

import 'buttons.dart';

class CalculatorScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const CalculatorScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Pill-Style Theme Toggle
          Positioned(
            top: 40,
            right: 16,
            child: GestureDetector(
              onTap: widget.onToggleTheme,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: widget.isDark ? const Color(0xFF3A4554) : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.isDark ? Icons.light_mode : Icons.dark_mode,
                      size: 18,
                      color: widget.isDark ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.isDark ? "LIGHT MODE" : "DARK MODE",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: widget.isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 6, left: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Output Screen
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children:
                        Functionality.getDisplayLines(maxChars: 15, maxLines: 2)
                            .map(
                              (line) => Text(
                                line,
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            )
                            .toList(),
                  ),
                ),

                // Size between both
                SizedBox(height: 20),

                // buttons
                Wrap(
                  children: Buttons.allButtons.map((e) {
                    final isTop = Buttons.topRow.contains(e);
                    final isOperator = Buttons.opratorButtons.contains(e);

                    // final bgColor = isTop
                    //     ? const Color(0xFFE6E7EC)
                    //     : isOperator
                    //     ? AppColors.random
                    //     : Colors.white;

                    final bgColor = widget.isDark
                        ? const Color(0xFF3A4554)
                        : Colors.white;

                    return Padding(
                      padding: const EdgeInsets.all(6),
                      child: Material(
                        color: bgColor, // 👈 MOVE COLOR HERE
                        borderRadius: BorderRadius.circular(18),
                        elevation: widget.isDark ? 8 : 6, // replaces shadow
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18),
                          splashColor: Colors.blue.withOpacity(0.25),
                          highlightColor: Colors.blue.withOpacity(0.15),
                          onTap: () {
                            Functionality.appendInput(e, context, setState);
                          },
                          child: SizedBox(
                            width: e != "0" ? screenWidth * .21 : screenWidth * .45,
                            height: 70,
                            child: Center(
                              child: Text(
                                e,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: widget.isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );

                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
