class User {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;
  final String userType;

  User({
    this.userType,
    this.id,
    this.name,
    this.imageUrl,
    this.isOnline,
  });
}

final User currentUser = User(
    id: 0,
    name: 'Steve Smith',
    imageUrl: 'images/user.png',
    isOnline: true,
    userType: "Student");

// USERS
final User Jerry = User(
    id: 1,
    name: 'Jerry Smith',
    imageUrl: 'images/image8.png',
    isOnline: true,
    userType: "Student Interviewer");
final User Shawn = User(
    id: 2,
    name: 'Shawn Gomes',
    imageUrl: 'images/image9.png',
    isOnline: true,
    userType: "Student Interviewer ");
final User Catherine = User(
    id: 3,
    name: 'Catherine Smith',
    imageUrl: 'images/image1.png',
    isOnline: false,
    userType: "Essay Reviewer");
final User Dana = User(
    id: 4,
    name: 'Dana Hudson',
    imageUrl: 'images/image2.png',
    isOnline: false,
    userType: "Essay Reviewer");
final User Emma = User(
    id: 5,
    name: 'Emma Carlson',
    imageUrl: 'images/image4.png',
    isOnline: true,
    userType: "Student Interviewer");
final User Hemang = User(
    id: 6,
    name: 'Hemang Dash',
    imageUrl: 'images/hemang.png',
    isOnline: false,
    userType: "College Applicant");
final User Pranav = User(
    id: 6,
    name: 'Pranav Thomas',
    imageUrl: 'images/pranav.png',
    isOnline: false,
    userType: "College Applicant");
