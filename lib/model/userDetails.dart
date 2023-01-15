class UserDetails {
  final String id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String companyName;
  final String website;
  final String address;

  const UserDetails(
      {required this.id,
      required this.name,
      required this.phone,
      required this.companyName,
      required this.address,
      required this.email,
      required this.username,
      required this.website});

  factory UserDetails.fromJson(Map<String, dynamic> jsonResponse) {
    return UserDetails(
      id: "${jsonResponse["id"]}", 
      name: "${jsonResponse["name"]}",
      phone: "${jsonResponse["phone"]}",
      companyName: "${jsonResponse["company"]["name"]}",
      address:
          "${jsonResponse["address"]["street"]},\n ${jsonResponse["address"]["city"]},\n zipcode - ${jsonResponse["address"]["zipcode"]}",
      email: "${jsonResponse["email"]}",
      website: "${jsonResponse["website"]}",
      username: "${jsonResponse["username"]}",
    );
  }
}
