import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'base_network.dart';
import 'matches_model.dart';

class MatchesPage extends StatefulWidget {
  @override
  _MatchesPageState createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  List<MatchesModel>? matches;

  @override
  void initState() {
    super.initState();
    fetchMatchesData();
  }

  Future<void> fetchMatchesData() async {
    try {
      final response = await BaseNetwork.getList('https://copa22.medeiro.tech/matches');
      setState(() {
        matches = response.map((json) => MatchesModel.fromJson(json)).toList();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match List'),
      ),
      body: matches != null
          ? ListView.builder(
        itemCount: matches!.length,
        itemBuilder: (context, index) {
          final match = matches![index];
          return ListTile(
            leading: Image.network(
              'https://flagcdn.com/16x12/${match.homeTeam}.png',
              width: 16,
              height: 12,
            ),
            title: Text('${match.homeScore} - ${match.awayScore}'),
            trailing: Image.network(
              'https://flagcdn.com/16x12/${match.awayTeam}.png',
              width: 16,
              height: 12,
            ),
            onTap: () {
              // Match details
            },
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}