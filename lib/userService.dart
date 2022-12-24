import 'package:mobprogass3/database/repository.dart';
import 'package:mobprogass3/model/user.dart';

class UserService
{
  late Repository _repository;
  UserService(){
    _repository = Repository();
  }
  //Save User
  SaveUser(UserCustomer user) async{
    return await _repository.insertData('users', user.userMap());
  }
  //Read All Users
  readAllUsers() async{
    return await _repository.readData('users');
  }
  //Edit User
  UpdateUser(UserCustomer user) async{
    return await _repository.updateData('users', user.userMap());
  }

  deleteUser(userId) async {
    return await _repository.deleteDataById('users', userId);
  }

}