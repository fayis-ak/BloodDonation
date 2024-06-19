import 'package:blood_donation/constants/firebase_const.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class searchpage extends StatefulWidget {
  @override
  _searchpageState createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  final CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection(DonorRegistration);

  List<String> searchResults = [];

  void search(String query) async {
    searchResults.clear();

    if (query.isNotEmpty) {
      QuerySnapshot querySnapshot = await itemsCollection
          .where('blood', isGreaterThanOrEqualTo: query)
          .where('blood', isLessThan: query + 'z')
          .get();

      Set<String> uniqueBloodTypes = Set();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        String item = document['blood'];
        uniqueBloodTypes.add(item);
      }

      searchResults.addAll(uniqueBloodTypes.toList());
    }

    setState(() {});
  }

  void showDetails(String selectedItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(selectedItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        title: Center(
          child: Text(
            "Find Donor",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                search(query);
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index]),
                  onTap: () {
                    showDetails(searchResults[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String selectedItem;

  DetailsPage(this.selectedItem);

  final CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection(DonorRegistration);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          'Details for $selectedItem',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            itemsCollection.where('blood', isEqualTo: selectedItem).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No data found"));
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userData = users[index].data() as Map<String, dynamic>;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Details for $selectedItem:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text('Name: ${userData['name']}'),
                    Text('Phone: ${userData['phone']}'),
                    Text('Adress: ${userData['adress']}'),
                    // Add more fields as needed
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
