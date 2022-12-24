import 'package:mobprogass3/model/user.dart';
import 'package:mobprogass3/userService.dart';
import 'package:flutter/material.dart';


class EditCustomer extends StatefulWidget {
  final UserCustomer user;
  const EditCustomer({Key? key,required this.user}) : super(key: key);

  @override
  State<EditCustomer> createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  var _userNameController = TextEditingController();
  var _userContactController = TextEditingController();
  var _userDescriptionController = TextEditingController();
  bool _validateName = false;
  bool _validateContact = false;
  bool _validateDescription = false;
  var _userService=UserService();

  @override
  void initState() {
    setState(() {
      _userNameController.text=widget.user.name??'';
      _userContactController.text=widget.user.contact??'';
      _userDescriptionController.text=widget.user.description??'';
    });
    super.initState();
  }

  // This is what you will see in the UI when editing your previous add customer
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Customer Information",
          style: TextStyle(
              fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Customer Information',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    hintText: 'Ex: Sandrine Dico',
                    labelText: 'Input your name',
                    errorText:
                    _validateName ? 'Please input your Name!' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userContactController,
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    hintText: 'Ex: 09664447235',
                    labelText: 'Input your Contact Number',
                    errorText: _validateContact
                        ? 'Please input your Contact Number!'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userDescriptionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    hintText: 'Ex: Tambo Cagayan de Oro City in front of Contreras and Waiting Shed',
                    labelText: 'Input your Address',
                    errorText: _validateDescription
                        ? 'Please Input your Address!'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blueGrey,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _userNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _userContactController.text.isEmpty
                              ? _validateContact = true
                              : _validateContact = false;
                          _userDescriptionController.text.isEmpty
                              ? _validateDescription = true
                              : _validateDescription = false;

                        });
                        if (_validateName == false &&
                            _validateContact == false &&
                            _validateDescription == false) {

                          var _user = UserCustomer();
                          _user.id=widget.user.id;
                          _user.name = _userNameController.text;
                          _user.contact = _userContactController.text;
                          _user.description = _userDescriptionController.text;
                          var result=await _userService.UpdateUser(_user);
                          Navigator.pop(context,result);
                        }
                      },
                      child: const Text('Update Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _userNameController.text = '';
                        _userContactController.text = '';
                        _userDescriptionController.text = '';
                      },
                      child: const Text('Clear Details'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}