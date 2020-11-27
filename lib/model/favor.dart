class Favor {
  String assignedUser;
  String assignedUsername;
  String favorDescription;
  String favorLocation;
  String favorTitle;
  String key;
  String status;
  int timestamp;
  String user;
  String username;

  Favor(
      {this.assignedUser,
      this.assignedUsername,
      this.favorDescription,
      this.favorLocation,
      this.favorTitle,
      this.key,
      this.status,
      this.timestamp,
      this.user,
      this.username});

  Favor.fromJson(Map<String, dynamic> parsedJSON)
      : assignedUser = parsedJSON['assignedUser'],
        assignedUsername = parsedJSON['assignedUsername'],
        favorDescription = parsedJSON['favorDescription'],
        favorLocation = parsedJSON['favorLocation'],
        favorTitle = parsedJSON['favorTitle'],
        key = parsedJSON['key'],
        timestamp = parsedJSON['timestamp'],
        status = parsedJSON['status'],
        user = parsedJSON['user'],
        username = parsedJSON['username'];
}
