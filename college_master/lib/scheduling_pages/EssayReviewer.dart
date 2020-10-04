class EssayReviewer {
  String imagePath;
  String name;
  String organization;
  double rating;
  String nationality;
  int essaysReviewed;
  String countryOfSpecialization;

  EssayReviewer(String name, double rating, String nationality,
      int essaysReviewed, String countyOfSpecialization) {
    this.name = name;
    this.rating = rating;
    this.nationality = nationality;
    this.essaysReviewed = essaysReviewed;
    this.countryOfSpecialization = countyOfSpecialization;
  }
}
