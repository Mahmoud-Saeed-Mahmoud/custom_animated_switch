import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: InkWell(
            onTap: () {
              setState(() {
                active = !active;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: 90,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: active ? Colors.teal : Colors.grey,
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                alignment:
                    active ? Alignment.centerRight : Alignment.centerLeft,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    final rotateAnimation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(animation);
                    final reverseAnimation =
                        Tween<double>(begin: 1.0, end: 0.0).animate(animation);
                    return RotationTransition(
                      turns: active ? rotateAnimation : reverseAnimation,
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  layoutBuilder: (currentChild, previousChildren) {
                    return Stack(
                      fit: StackFit.loose,
                      children: [
                        // Show the current child.
                        if (currentChild != null) currentChild,
                        // Show the previous children in a stack.
                        ...previousChildren.map(
                          (child) {
                            return IgnorePointer(child: child);
                          },
                        ),
                      ],
                    );
                  },
                  switchInCurve: Curves.easeOutExpo,
                  switchOutCurve: Curves.easeInExpo,
                  child: active
                      ? const Icon(
                          key: ValueKey(0),
                          Icons.check,
                        )
                      : const Icon(
                          key: ValueKey(1),
                          Icons.cancel,
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
