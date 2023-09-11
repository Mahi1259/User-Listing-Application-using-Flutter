import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Call the fetchData function when the widget initializes
  }

  Future<void> fetchData() async {
    final Uri url = Uri.parse('https://www.motesplatsen.se/api/v1/test/users?pageNr=0');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the JSON response into a list of user data
      final List<Map<String, dynamic>> userData = List<Map<String, dynamic>>.from(json.decode(response.body));
      setState(() {
        users.addAll(userData); // Update the 'users' list with the fetched data
      });
    } else {
      throw Exception('Failed to load data from the API'); // Handle API request failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mötesplatsen Users'),
        backgroundColor: Colors.blue, // Set app bar background color
      ),
      body: users.isEmpty
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.blue, // Set loading indicator color
        ),
      )
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index]; // Get the user data for the current index

          return Card(
            elevation: 4, // Add elevation to cards for a 3D effect
            margin: EdgeInsets.all(8), // Add margin around each card
            child: ListTile(
              title: Text(
                'Name: ${user['username']}',
                style: TextStyle(fontWeight: FontWeight.bold), // Style the username with bold font
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gender: ${user['gender'] == 1 ? 'Male' : 'Female'}'),
                  Text('Date of Birth: ${user['dateOfBirth']}'),
                  Text('Municipality: ${user['municipality']}'),
                  Text('Province: ${user['province']}'),
                ],
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user['pictureUrl']),
                radius: 30, // Adjust the avatar size
              ),
            ),
          );
        },
      ),
    );
  }
}
