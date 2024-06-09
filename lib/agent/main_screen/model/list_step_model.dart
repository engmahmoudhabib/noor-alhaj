class StepsModel {
  final int id;
  final List<SecondaryStep> secondarySteps;
  final String name;
  final int? rank;
  final String note;
  final bool completed;

  StepsModel({
    required this.id,
    required this.secondarySteps,
    required this.name,
    required this.rank,
    required this.note,
    required this.completed,
  });

  factory StepsModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> secondaryStepsJson = json['secondary_steps'] ?? json['scondary_steps'] ?? [];
    List<SecondaryStep> secondarySteps = secondaryStepsJson.map((e) => SecondaryStep.fromJson(e)).toList();

    return StepsModel(
      id: json['id'],
      secondarySteps: secondarySteps,
      name: json['name'],
      rank: json['rank'],
      note: json['note'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'secondary_steps': secondarySteps.map((e) => e.toJson()).toList(),
      'name': name,
      'rank': rank,
      'note': note,
      'completed': completed,
    };
  }
}

class SecondaryStep {
  final String name;
  final String note;

  SecondaryStep({
    required this.name,
    required this.note,
  });

  factory SecondaryStep.fromJson(Map<String, dynamic> json) {
    return SecondaryStep(
      name: json['name'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'note': note,
    };
  }
}
