import 'package:admin/views/screens/side_bar_screens/widgets/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  static const routeName = 'CategoriesScreen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  dynamic _image;
  String? filename;
  late String categoryName;

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

  _uploadCategoryBannerToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('categories').child(filename!);
    UploadTask uploadTask = ref.putData(image);

    TaskSnapshot snapshot = await uploadTask;

    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  uploadCategory() async {
    if (_formkey.currentState!.validate()) {
      EasyLoading.show();

      if (_image != null) {
        String imageURL = await _uploadCategoryBannerToStorage(_image);

        await _firestore.collection('categories').doc(filename).set(
            {
              'image': imageURL, 
              'categoryName': categoryName})
              .whenComplete(
          () {
            EasyLoading.dismiss();

            setState(
              () {
                _image = null;
                _formkey.currentState!.reset();
              },
            );
          },
        );
      }
    } else {
      print("Not ok");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Category',
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
                              : const Text('Category'),
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
                Flexible(
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      onChanged: (value) {
                        categoryName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Category name cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: "Enter Category",
                          hintText: "Product's Category Name"),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    uploadCategory();
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
                  'Categories',
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
            const CategoryWidget(),
          ],
        ),
      ),
    );
  }
}
