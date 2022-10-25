import 'package:flutter/material.dart';

class ResultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onQuestionTapped;
  const ResultAppBar({super.key, required this.onQuestionTapped});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Results"),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: ClipOval(
            child: Material(
              color: Colors.amber.withOpacity(.85), // Button color
              child: InkWell(
                // Splash color
                onTap: onQuestionTapped,
                child: const SizedBox(
                  width: 42,
                  child: Icon(
                    Icons.question_mark_rounded,
                    size: 26,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 6)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
