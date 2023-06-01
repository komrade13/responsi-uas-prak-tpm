class DetailMatchesModel {
  final String id;
  final TeamModel homeTeam;
  final TeamModel awayTeam;
  final String stadium;
  final String date;
  final String time;

  DetailMatchesModel({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.stadium,
    required this.date,
    required this.time,
  });

  factory DetailMatchesModel.fromJson(Map<String, dynamic> json) {
    return DetailMatchesModel(
      id: json['id'] ?? '',
      homeTeam: TeamModel.fromJson(json['homeTeam'] ?? {}),
      awayTeam: TeamModel.fromJson(json['awayTeam'] ?? {}),
      stadium: json['stadium'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
    );
  }
}

class TeamModel {
  final String country;
  final int goals;

  TeamModel({
    required this.country,
    required this.goals,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      country: json['country'] ?? '',
      goals: json['goals'] ?? 0,
    );
  }
}

Map<String, String> countryNames = {
  'QAT': 'Qatar',
  'ECU': 'Ecuador',
  // Add more country code to country name mappings as needed
};