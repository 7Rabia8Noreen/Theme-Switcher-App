import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_switcher_app/bloc/theme_switcher_bloc.dart';
import 'package:theme_switcher_app/bloc/theme_switcher_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<ThemeSwitcherBloc, ThemeData>(
            builder: (context, state) {
              return CupertinoSwitch(
                value: state == ThemeData.dark(),
                onChanged: (value) {
                  context.read<ThemeSwitcherBloc>().add(ThemeSwitching());
                },
              );
            },
          )
        ],
      ),
      body: const Center(child: Text('Theme Switcher App')),
    );
  }
}
