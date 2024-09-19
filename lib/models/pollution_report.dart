class PollutionReport {
  final String id;
  final String location;
  final String pollutionType;
  final String pollutionSeverity;
  final String description;
  final List<String> photos;
  final DateTime incidentDate;
  final String waterCondition;
  final bool wildlifeAffected;
  final bool recurringIssue;
  final String nearbyActivities;
  final String reporterName;
  final String contactInfo;
  final String ngoAffiliation;

  PollutionReport({
    required this.id,
    required this.location,
    required this.pollutionType,
    required this.pollutionSeverity,
    required this.description,
    required this.photos,
    required this.incidentDate,
    required this.waterCondition,
    required this.wildlifeAffected,
    required this.recurringIssue,
    required this.nearbyActivities,
    required this.reporterName,
    required this.contactInfo,
    required this.ngoAffiliation,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'location': location,
        'pollutionType': pollutionType,
        'pollutionSeverity': pollutionSeverity,
        'description': description,
        'photos': photos,
        'incidentDate': incidentDate.toIso8601String(),
        'waterCondition': waterCondition,
        'wildlifeAffected': wildlifeAffected,
        'recurringIssue': recurringIssue,
        'nearbyActivities': nearbyActivities,
        'reporterName': reporterName,
        'contactInfo': contactInfo,
        'ngoAffiliation': ngoAffiliation,
      };
}
