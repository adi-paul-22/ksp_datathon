import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref().child('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  String _name = '';
  String _email = '';
  String _phone = '';
  String _position = '';
  XFile? _imageFile;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DataSnapshot snapshot = await _databaseReference.child(user.uid).get();
      Map<String, dynamic> userData = Map<String, dynamic>.from(snapshot.value as Map);
      setState(() {
        _name = userData['name'] ?? 'No Name';
        _email = userData['email'] ?? 'No Email';
        _phone = userData['phone'] ?? 'No Phone';
        _position = userData['position'] ?? 'No Position';
        _imageUrl = userData['imageUrl']; // Assuming you store imageUrl in your Firebase Database
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        _imageFile = selectedImage;
      });
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    User? user = _auth.currentUser;
    if (user != null && _imageFile != null) {
      try {
        final ref = _storage.ref().child('userImages/${user.uid}.jpg');
        await ref.putFile(File(_imageFile!.path));
        final url = await ref.getDownloadURL();
        await _databaseReference.child(user.uid).update({'imageUrl': url});
        setState(() {
          _imageUrl = url;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _imageUrl != null
                      ? NetworkImage(_imageUrl!)
                      : _imageFile != null
                        ? FileImage(File(_imageFile!.path)) as ImageProvider
                        : AssetImage('assets/placeholder.png'), // Placeholder image
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
              SizedBox(height: 20),
              Text("Name: $_name", style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text("Email: $_email", style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text("Phone: $_phone", style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text("Position: $_position", style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
