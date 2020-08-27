class User {
  String Categorie;
  String phoneNumber;

  User(this.Categorie,this.phoneNumber);

  Map<String, dynamic> toJson() => {
    'categorie': Categorie,
    'phoneNumber': phoneNumber,
  };
}