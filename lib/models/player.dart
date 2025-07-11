class Player {
  final String name;
  num level;
  double health;
  double mana;
  double stamina;
  String avatarPath;
  num strength;
  num wisdom;
  num constitution;
  num charisma;
  num agility;
 
  Player({
    required this.name,
    required this.level,
    required this.health,
    required this.mana,
    required this.stamina,
    required this.avatarPath,
    required this.strength,
    required this.wisdom,
    required this.constitution,
    required this.charisma,
    required this.agility,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'],
      level: json['level'],
      health: json['health'].toDouble(),
      mana: json['mana'].toDouble(),
      stamina: json['stamina'].toDouble(),
      avatarPath: json['avatar'], 
      strength: json['strength'],  
      wisdom: json['wisdom'], 
      constitution: json['constitution'], 
      charisma: json['charisma'], 
      agility: json['agility'], 
    );
  }
} 
