import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> bannerStream =
        FirebaseFirestore.instance.collection('banners').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: bannerStream,
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
            final bannerData = snapshot.data!.docs[index];
            return Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 250,
                  child: Image.network(
                    bannerData['image'],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}