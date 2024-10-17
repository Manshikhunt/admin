import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categoryStream =
        FirebaseFirestore.instance.collection('categories').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: categoryStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.size,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final categoryData = snapshot.data!.docs[index];
            return Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    categoryData['image'],
                  ),
                ),
                Text(
                  categoryData['categoryName'],
                  maxLines: 2, // Limit text to 2 lines to prevent overflow
                  overflow: TextOverflow.ellipsis, // Handle text overflow
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            );
          },
        );
      },
    );
  }
}


// flutter run -d chrome --web-renderer html