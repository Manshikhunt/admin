import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VenderWidget extends StatelessWidget {
  VenderWidget({super.key});

  Widget venderData(int? flex, Widget Widget) {
    return Expanded(
      flex: flex!,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Widget,
          ),
        ),
      ),
    );
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _vendersStream =
        FirebaseFirestore.instance.collection('vendors').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _vendersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final venderUserData = snapshot.data!.docs[index];
            return Container(
              child: Row(
                children: [
                  venderData(
                    1,
                    Container(
                      height: 50,
                      width: 50,
                      child: Image.network(venderUserData['storageImage']),
                    ),
                  ),
                  venderData(
                    3,
                    Text(
                      venderUserData['businesName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  venderData(
                    2,
                    Text(
                      venderUserData['cityValue'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  venderData(
                    2,
                    Text(
                      venderUserData['stateValue'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  venderData(
                    1,
                    venderUserData['approved'] == false
                    ? ElevatedButton(
                      onPressed: () async{
                        await _firestore.collection('vendors').doc(venderUserData['vendorId']).update({
                          'approved' : true}
                        );
                      },
                      child: Text('Approved', style: TextStyle(fontSize: 13),),
                    )
                    : ElevatedButton(
                      onPressed: () async{
                        await _firestore.collection('vendors').doc(venderUserData['vendorId']).update({
                          'approved' : false}
                        );
                      },
                      child: Text('Reject'),
                    ),
                  ),
                  venderData(
                    1,
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('View More'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
