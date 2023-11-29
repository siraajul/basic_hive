import 'package:basic_hive/Style/button.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LogIn extends StatefulWidget {
  LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final  nameCtrl = TextEditingController();
  final mailCtrl = TextEditingController();

  String? name = '';
  String? mail = '';
  final _mybox= Hive.box('mybox');

  //write Data
  void writeData(String  name, String value )  {
    _mybox.put(name, value );
  }

//read Data
  void readData()  {
    setState(() {
      name = _mybox.get('name');
      mail = _mybox.get('mail');
    });

  }

  //delete data
 void deleteData()  {

    _mybox.delete(1);

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Hive DB ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter Your Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: mailCtrl,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter Your Email'),
              ),
            ),
            ElevatedButton(onPressed: ()  {

              writeData('name',nameCtrl.text);
              writeData('mail',mailCtrl.text);
              //final hiveData = Hive()
            },style: LogInButton, child: const Text('Save')),
            const SizedBox(height: 10,),

            ElevatedButton(onPressed: ()  {
              readData();

            },style: GetButton, child: const Text('Get')),

            Text('My name: $name'),
            Text('My mail: $mail'),
          ],
        ),
      ),
    );
  }
}