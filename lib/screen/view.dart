import 'package:mobprogass3/model/user.dart';
import 'package:flutter/material.dart';

class ViewCustomer extends StatefulWidget {

  final UserCustomer user;
  const ViewCustomer({Key? key, required this.user}) : super(key: key);

  @override
  State<ViewCustomer> createState() => _ViewCustomerState();
}

// functions to view what you input
class _ViewCustomerState extends State<ViewCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Parcel Customer Information",
            style: TextStyle(
                fontWeight: FontWeight.bold),
          ),
          foregroundColor: Colors.white,
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Full Details",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text('Name:',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(widget.user.name ?? '', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text('Contact:',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(widget.user.contact ?? '', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Address Description:',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(widget.user.description ?? '', style: const TextStyle(fontSize: 16)),
                ],
              )
            ],
          ),
        ));
  }
}