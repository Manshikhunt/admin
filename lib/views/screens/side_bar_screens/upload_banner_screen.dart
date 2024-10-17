import 'package:admin/views/screens/side_bar_screens/widgets/banner_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UploadBannerScreen extends StatefulWidget {
  const UploadBannerScreen({super.key});

  static const routeName = 'UploadBannerScreen';

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  dynamic _image;
  String? filename;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        filename = result.files.first.name;
      });
    }
  }

  _uploadBannerToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('banners').child(filename!);
    UploadTask uploadTask = ref.putData(image);

    TaskSnapshot snapshot = await uploadTask;

    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  _uploadToFirebaseStore() async {
    EasyLoading.show();
    if (_image != null) {
      String imageURL = await _uploadBannerToStorage(_image);

      await _firestore
          .collection('banners')
          .doc(filename)
          .set({'image': imageURL}).whenComplete(
        () {
          EasyLoading.dismiss();

          setState(() {
            _image = null;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Banners',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(color: Colors.grey.shade800),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: _image != null
                            ? Image.memory(
                                _image,
                                fit: BoxFit.cover,
                              )
                            : const Text('Banner'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        pickImage();
                      },
                      child: const Text(
                        ' Upload Image',
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _uploadToFirebaseStore();
                },
                child: const Text(
                  'Save',
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: const Text(
                'Banners',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const BannerWidget(),
        ],
      ),
    );
  }
}
