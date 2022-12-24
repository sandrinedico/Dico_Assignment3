import 'package:mobprogass3/model/user.dart';
import 'package:mobprogass3/userService.dart';
import 'package:flutter/material.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  var _userNameController = TextEditingController();
  var _userContactController = TextEditingController();
  var _userDescriptionController = TextEditingController();
  bool _validateName = false;
  bool _validateContact = false;
  bool _validateDescription = false;
  var _userService=UserService();

// Functions that will add customer
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
                'Add New Basic Customer Information',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600),
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
                    labelText: 'Input your Description Address',
                    errorText: _validateDescription
                        ? 'Please Input your Description Address!'
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
                          _user.name = _userNameController.text;
                          _user.contact = _userContactController.text;
                          _user.description = _userDescriptionController.text;
                          var result=await _userService.SaveUser(_user);
                          Navigator.pop(context,result);
                        }
                      },
                      child: const Text('Save Details')),
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