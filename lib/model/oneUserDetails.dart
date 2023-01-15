class OneUserDetails {
  final String id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String companyName;
  final String website;
  final String address;

  const OneUserDetails({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.companyName,
    required this.website,
    required this.address,
  });

  factory OneUserDetails.fromJson(Map<String, dynamic> jsonResponse) {
    return OneUserDetails(
      id: "${jsonResponse["id"]}",
      name: "${jsonResponse["name"]}",
      phone: "${jsonResponse["phone"]}",
      companyName: "${jsonResponse["company"]["name"]}",
      address:
          "${jsonResponse["address"]["street"]}, ${jsonResponse["address"]["city"]}, zipcode - ${jsonResponse["address"]["zipcode"]}",
      email: "${jsonResponse["email"]}",
      website: "${jsonResponse["website"]}",
      username: "${jsonResponse["username"]}",
    );
  }
}
