class StudentInterviewer {
  String imagePath;
  String name;
  String university;
  String description;
  double pricing;
  double latitude;
  double longitude;
  String location;
  double distance;

  StudentInterviewer(String name, String description, double latitude,
      double longitude, String location) {
    this.name = name;
    this.description = description;
    this.longitude = longitude;
    this.latitude = latitude;
    this.location = location;
  }
}
