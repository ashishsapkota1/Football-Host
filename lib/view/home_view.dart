import 'package:flutter/material.dart';
import 'package:football_host/resources/app_colors.dart';
import 'package:football_host/view_model/tournament_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TournamentViewModel>(context);
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
          title: const Text('Football Host'),
        centerTitle: true,
      ),
    );
  }
}
