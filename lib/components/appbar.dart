import 'package:flutter/material.dart';
class AppBarExample extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Color backgroundColor;
  final List<Widget> actions;

  AppBarExample({
    required this.title,
    this.backgroundColor = const Color.fromARGB(255, 180, 80, 80),
    required this.actions,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title, // Usa o título recebido no construtor
      backgroundColor: backgroundColor,
    );
  }
}