import 'package:flutter/material.dart';
import 'base_network.dart';
import 'detail_matches_model.dart';
import 'match_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Qatar World Cup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MatchListScreen(),
    );
  }
}

class MatchListScreen extends StatefulWidget {
  @override
  _MatchListScreenState createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  Future<List<DetailMatchesModel>>? _matchesFuture;

  @override
  void initState() {
    super.initState();
    _loadMatches();
  }

  void _loadMatches() {
    _matchesFuture = BaseNetwork.getList('matches')
        .then((response) =>
        response
            .map((json) => DetailMatchesModel.fromJson(json))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qatar World Cup 2022 Match List'),
      ),
      body: FutureBuilder<List<DetailMatchesModel>>(
        future: _matchesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final matches = snapshot.data!;
            return ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];
                return ListTile(
                  leading: Image.network(
                    'https://flagcdn.com/h240/${countryCodes[match.homeTeam!
                        .country]}.png',
                    width: 40,
                    height: 40,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        match.homeTeam!.country!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        match.homeTeam!.country!,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        '${match.homeTeam.goals} - ${match.awayTeam.goals}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Image.network(
                        'https://flagcdn.com/h240/${countryCodes[match.awayTeam!
                            .country]}.png',
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            match.awayTeam!.country!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            match.awayTeam!.country!,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MatchDetailScreen(matchId: match.id!),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

Map<String, String> countryNames = {
  'QAT': 'Qatar',
  'ECU': 'Ecuador',
  // Add more country code to full name mappings here
};