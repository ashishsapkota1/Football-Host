import 'package:flutter/material.dart';
import 'package:football_host/resources/utils/routes/routes_name.dart';
import 'package:football_host/view/add_teams.dart';
import 'package:football_host/view/home_view.dart';
import 'package:football_host/view/match-view/start_match.dart';
import 'package:football_host/view/new_tournament.dart';
import 'package:football_host/view/player/team_players.dart';



class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case RoutesName.homePage:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeView());

      case RoutesName.addTournament:
        return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation){

             return const  AddTournament();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child){
          const begin = Offset(1, 1);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          
          return SlideTransition(position: offsetAnimation, child: child,);
        },
        transitionDuration: const Duration(milliseconds: 500)
        );

      case RoutesName.addTeams:
        return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation){
          final tournament = ModalRoute.of(context)!.settings.arguments as String?;
          return   AddTeams(tournamentName: tournament,);
        },
            transitionsBuilder: (context, animation, secondaryAnimation, child){
              const begin = Offset(1, 1);
              const end = Offset.zero;
              const curve = Curves.bounceInOut;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child,);
            },
            transitionDuration: const Duration(milliseconds: 500)
        );

      case RoutesName.teamPlayers:
        return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation){
          final teamName = ModalRoute.of(context)!.settings.arguments as String?;
          return TeamPlayers(teamName: teamName,);
        },
            transitionsBuilder: (context, animation, secondaryAnimation, child){
              const begin = Offset(0, 0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child,);
            },
            transitionDuration: const Duration(milliseconds: 500)
        );

      case RoutesName.startMatch:
        return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation){
          final teamName = ModalRoute.of(context)!.settings.arguments as String?;
          return const StartMatch();
        },
            transitionsBuilder: (context, animation, secondaryAnimation, child){
              const begin = Offset(0, 0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child,);
            },
            transitionDuration: const Duration(milliseconds: 500)
        );


      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No Route Defined'),
            ),
          );
        });
    }
  }
}