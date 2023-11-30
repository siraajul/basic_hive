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
  final addressCtrl = TextEditingController();

  String? name = '';
  String? address = '';
  final _mybox= Hive.box('mybox');

  //write Data
  void writeData(String  name, String value )  {
    _mybox.put(name, value );
  }

//read Data
  void readData()  {
    setState(() {
      name = _mybox.get('name')??'';
      address = _mybox.get('address')??'';
    });

  }

  //delete data
 void deleteData()
 {
    _mybox.delete('name');
    _mybox.delete('address');
 }

  @override
  Widget build(BuildContext context) {
    print(DateTime.now());
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
                controller: addressCtrl,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                    hintText: 'Enter Your address'),
              ),
            ),

            const SizedBox(height: 32,),
            ElevatedButton(onPressed: ()  {

              writeData('name',nameCtrl.text);
              writeData('address',addressCtrl.text);

              readData();
              nameCtrl.text='';
              addressCtrl.text='';
            },style: LogInButton, child: const Text('Save')),
            const SizedBox(height: 10,),

            ElevatedButton(onPressed: ()  {
              readData();

            },style: GetButton, child: const Text('Get')),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: ()  {
              deleteData();
              readData();
              nameCtrl.text='';
              addressCtrl.text='';

            },style: GetButton, child: const Text('Delete')),

            const SizedBox(height: 32,),
            Text('My name: $name'),
            const SizedBox(height: 8,),

            Text('My address: $address'),
          ],
        ),
      ),
    );
  }
}