import 'package:flutter/material.dart';
import 'package:user/model/userDetails.dart';
import 'package:user/widgets/cardDetail.dart';

// ignore: must_be_immutable
class CardUser extends StatelessWidget {
  UserDetails userDetails;

  CardUser(this.userDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.black,
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CardDetails(name: "ID", value: userDetails.id),
            CardDetails(name: "Name", value: userDetails.name),
            CardDetails(name: "Username", value: userDetails.username),
            CardDetails(name: "Email", value: userDetails.email),
            CardDetails(name: "Phone", value: userDetails.phone),
            CardDetails(name: "Company Name", value: userDetails.companyName),
            CardDetails(name: "Website", value: userDetails.website),
            CardDetails(name: "Address", value: userDetails.address),
          ],
        ),
      ),
    );
  }
}
