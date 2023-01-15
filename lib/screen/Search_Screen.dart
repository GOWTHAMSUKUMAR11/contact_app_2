import 'package:flutter/material.dart';

import '../model/userDetails.dart';

class Search extends SearchDelegate {
  late List<UserDetails> totalUserDetails;

  @override
  String get searchFieldLabel => 'Search User';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
          ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 249, 186, 61),
      ),
      textTheme: const TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 18,
          decorationThickness: 0.00000001,
        ),
      ),
    );
  }

  Search({required this.totalUserDetails});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(
          Icons.close,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void SelectHandler(BuildContext ctx, String id, String name) {
    Navigator.of(ctx).pushNamed(
      "/oneUser",
      arguments: {
        'id': id,
        'name': name,
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<UserDetails> userDetails = query.isEmpty
        ? []
        : totalUserDetails
                .where(
                    (p) => p.name.toLowerCase().contains(query.toLowerCase()))
                .toList() +
            totalUserDetails
                .where((p) =>
                    p.companyName.toLowerCase().contains(query.toLowerCase()))
                .toList() +
            totalUserDetails.where((p) => p.id == query).toList();
    var seen = Set<UserDetails>();
    List<UserDetails> uniquelist =
        userDetails.where((user) => seen.add(user)).toList();
    userDetails = uniquelist;

    return userDetails.isEmpty
        ? Container(
            height: double.infinity,
            width: double.infinity,
            color: const Color.fromARGB(127, 249, 186, 61),
            child: const Center(
              child: Text(
                "No Users found!",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          )
        : Container(
            height: double.infinity,
            width: double.infinity,
            color: const Color.fromARGB(127, 249, 186, 61),
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => SelectHandler(
                      context, userDetails[index].id, userDetails[index].name),
                  splashColor: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.black,
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: SizedBox(
                              width: 60,
                              child: Text(
                                userDetails[index].id,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${userDetails[index].name}\n",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  userDetails[index].companyName,
                                  style: const TextStyle(
                                    color: Color.fromARGB(127, 249, 186, 61),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: userDetails.length,
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: const Color.fromARGB(127, 249, 186, 61),
      child: const Center(
        child: Text(
          "Search User",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
