import 'package:mobprogass3/model/user.dart';
import 'package:mobprogass3/screen/edit.dart';
import 'package:mobprogass3/screen/add.dart';
import 'package:mobprogass3/screen/view.dart';
import 'package:mobprogass3/userService.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parcel Information',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<UserCustomer> _userList = <UserCustomer>[];
  final _userService = UserService();

  getAllUserDetails() async {
    var users = await _userService.readAllUsers();
    _userList = <UserCustomer>[];
    users.forEach((user) {
      setState(() {
        var userModel = UserCustomer();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.contact = user['contact'];
        userModel.description = user['description'];
        _userList.add(userModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure You Want to Delete It?',
              style: TextStyle(color: Colors.blueGrey, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.black, // foreground
                      backgroundColor: Colors.orange),
                  onPressed: ()  async{
                    var result=await _userService.deleteUser(userId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllUserDetails();
                      _showSuccessSnackBar(
                          'User Detail Deleted Successfully');
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.black, // foreground
                      backgroundColor: Colors.blueGrey),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Customer Information"),
      ),
      body: ListView.builder(
          itemCount: _userList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewCustomer(
                            user: _userList[index],
                          )));
                },
                leading: const Icon(Icons.person),
                title: Text(_userList[index].name ?? ''),
                subtitle: Text(_userList[index].contact ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditCustomer(
                                    user: _userList[index],
                                  ))).then((data) {
                            if (data != null) {
                              getAllUserDetails();
                              _showSuccessSnackBar(
                                  'User Detail Updated Successfully');
                            }
                          });
                          ;
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        )),
                    IconButton(
                        onPressed: () {
                          _deleteFormDialog(context, _userList[index].id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.black,
                        ))
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddCustomer()))
              .then((data) {
            if (data != null) {
              getAllUserDetails();
              _showSuccessSnackBar('User Detail Added Successfully');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}