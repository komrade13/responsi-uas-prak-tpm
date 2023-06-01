import 'package:flutter/material.dart';
import 'base_network.dart';
import 'detail_matches_model.dart';

class MatchDetailScreen extends StatefulWidget {
  final String matchId;

  const MatchDetailScreen({Key? key, required this.matchId}) : super(key: key);

  @override
  _MatchDetailScreenState createState() => _MatchDetailScreenState();
}

class _MatchDetailScreenState extends State<MatchDetailScreen> {
  Future<DetailMatchesModel>? _matchFuture;

  @override
  void initState() {
    super.initState();
    _loadMatch();
  }

  void _loadMatch() {
    _matchFuture = BaseNetwork.get('matches/${widget.matchId}')
        .then((response) => DetailMatchesModel.fromJson(response));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match Detail'),
      ),
      body: FutureBuilder<DetailMatchesModel>(
        future: _matchFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final match = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],

                        ),
                        child: Image.network(
                          'https://flagcdn.com/h240/${countryCodes[match
                              .homeTeam!.country]}.png',
                          width: 240,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        '${match.homeTeam!.goals} - ${match.awayTeam!.goals}',
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Image.network(
                          'https://flagcdn.com/h240/${countryCodes[match
                              .awayTeam!.country]}.png',
                          width: 240,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Stadium: ${match.stadium}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Date: ${match.date}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Time: ${match.time}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Go Back'),
                ),
              ],
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

Map<String, String> countryCodes = {
  'QAT': 'qa',
  'ARG': 'ar',
  'BRA': 'br',
  'ENG': 'gb-eng',
  'WAL': 'gb-wls',
  'NED': 'nl',
  'DEN': 'dk',
  'FRA': 'fr',
  'CRC': 'cr',
  'POR': 'pt',
  'URU': 'uy',
  'SUI': 'ch',
  'GER': 'de',
  'MEX': 'mx',
  'USA': 'us',
  'AUS': 'au',
  'KSA': 'sa',
  'SEN': 'sn',
  'POL': 'pl',
  'JPN': 'jp',
  'CMR': 'cm',
  'KOR': 'kr',
  'ESP': 'es',
  'DEU': 'de',
  'GHA': 'gh',
  'CAN': 'ca',
  'TUN': 'tn',
  'ECU': 'ec',
  'IRN': 'ir',
  'MAR': 'ma',
  'CRO': 'hr',
  'BEL': 'be',
  'SRB': 'rs',
};