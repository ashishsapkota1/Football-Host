import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:football_host/resources/app_colors.dart';
import 'package:football_host/resources/utils/images.dart';
import 'package:football_host/resources/utils/responsive.dart';
import 'package:football_host/resources/utils/spacing.dart';
import 'package:football_host/view_model/home_view_model.dart';
import 'package:football_host/view_model/tournamentName_view_model.dart';
import 'package:football_host/view_model/tournament_view_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../resources/utils/routes/routes_name.dart';
import '../resources/utils/text_styles.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    await Permission.storage.request();
    var status = await Permission.storage.status;
    if (status.isDenied) {
        _showPermissionDeniedDialog();

    }

    if (status.isPermanentlyDenied) {
      _showPermissionPermanentlyDeniedDialog();
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Storage permission denied'),
          content: const Text('Allow storage permission.'),
          actions: [
            TextButton(
              onPressed: () async{
                Navigator.pop(context);
                await Permission.storage.isGranted;
              },
              child: const Text('Allow'),
            ),
            TextButton(
              onPressed: () async{
                Navigator.of(context).pop();
                _showPermissionPermanentlyDeniedDialog();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showPermissionPermanentlyDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Permission Permanently Denied'),
          content: const Text(
              'Please enable it in the system settings.'),
          actions: [
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
              child: const Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _requestPermission();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageModel = Provider.of<HomeViewModel>(context);
    TournamentViewModel tournament = Provider.of<TournamentViewModel>(context);
    setState(() {
      tournament.getTournaments();
    });
    final tournaments = tournament.tournamentList;

    Future<void> deleteTournament(int tournamentId) async {
      Navigator.pop(context);
      await tournament.deleteTournament(tournamentId);
    }

    void cancel() {
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: const Text(
          'Football Host',
          style: TextStyles.appBarText,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: ListView.builder(
                  itemCount: tournaments.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: Responsive.screenWidth(context) * 0.02,
                            right: Responsive.screenWidth(context) * 0.02,
                            top: Responsive.screenHeight(context) * 0.01,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              final tournamentNameModel =
                                  Provider.of<TournamentNameViewModel>(context,
                                      listen: false);
                              final selectedTournament = tournaments[index];
                              tournamentNameModel.setSelectedTournament(
                                  selectedTournament.name!);
                              tournamentNameModel.setSelectedTournamentId(
                                  selectedTournament.id!);
                              Navigator.pushNamed(context, RoutesName.addTeams,
                                  arguments: selectedTournament.name);
                            },
                            child: Card(
                              color: AppColor.appBarColor,
                              child: Slidable(
                                endActionPane: ActionPane(
                                  extentRatio: 0.5,
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (BuildContext context) {
                                        AlertDialog alert = AlertDialog(
                                          insetPadding: EdgeInsets.zero,
                                          title: const Text(
                                            'Delete Tournament',
                                            style: TextStyles.scheduleText,
                                          ),
                                          actions: [
                                            Row(
                                              children: [
                                                TextButton(
                                                    onPressed: () async {
                                                      await deleteTournament(
                                                          tournaments[index]
                                                              .id!);
                                                    },
                                                    child: const Text('Confirm',
                                                        style: TextStyles
                                                            .confirmText)),
                                                TextButton(
                                                    onPressed: () {
                                                      cancel();
                                                    },
                                                    child: const Text('Cancel',
                                                        style: TextStyles
                                                            .cancelText))
                                              ],
                                            )
                                          ],
                                        );
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return alert;
                                            });
                                      },
                                      icon: Icons.delete,
                                      backgroundColor: Colors.red,
                                      label: 'Delete',
                                    )
                                  ],
                                ),
                                child: Card(
                                  borderOnForeground: false,
                                  elevation: 2,
                                  color: AppColor.cardGrey,
                                  child: ListTile(
                                    title: Text(
                                      tournaments[index].name ?? '',
                                      style: TextStyles.cardText,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  })),
          InkWell(
            onTap: () async {
              imageModel.onTapped();
              await Navigator.pushNamed(context, RoutesName.addTournament);

              imageModel.resetTapped();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: Responsive.screenHeight(context) * 0.07,
                width: Responsive.screenWidth(context) * 1,
                decoration: BoxDecoration(
                  color: AppColor.appBarColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      horizontalSpacing(space: 6),
                      Image.asset(
                        imageModel.isTapped
                            ? Images.tappedWhistle
                            : Images.unTappedWhistle,
                        scale: 0.1,
                        height: Responsive.screenHeight(context) * 0.045,
                        color: imageModel.isTapped
                            ? Colors.grey
                            : AppColor.backGroundColor,
                      ),
                      horizontalSpacing(space: 8),
                      const Text(
                        'Start a New Tournament',
                        style: TextStyles.buttonText,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
