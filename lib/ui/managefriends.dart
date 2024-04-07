import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:log450_doit/ui/addfriends.dart';
import 'package:log450_doit/ui/reusableWidgets/friendItem.dart';
import 'package:log450_doit/ui/reusableWidgets/searchBar.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';
import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/sharedPreferences.dart';

class ManageFriendsScreen extends StatefulWidget {
  const ManageFriendsScreen({super.key});

  static const routeName = '/managefriends';

    @override
  _ManageFriendsScreenState createState() => _ManageFriendsScreenState();
}

class _ManageFriendsScreenState extends State<ManageFriendsScreen> {
  late String userId = SharedPreferences.shared.userId;
  List<Map<String, String>> friends = [];

  @override
  void initState() {
    super.initState();
    _fetchUserFriends();
  }

  Future<void> _fetchUserFriends() async {
    try {
      final userResponse = await http.get(Uri.parse('http://10.0.2.2:3000/users/$userId'));
      if (userResponse.statusCode == 200) {
        Map<String, dynamic> userData = jsonDecode(userResponse.body);
        List<dynamic> friendIds = userData['friend_ids'];

        for (var friendId in friendIds) {
          final friendResponse = await http.get(Uri.parse('http://10.0.2.2:3000/users/$friendId'));
          if (friendResponse.statusCode == 200) {
            Map<String, dynamic> friendData = jsonDecode(friendResponse.body);

            String friendName = "${friendData['username']}";
            String friendId = "${friendData['_id']}";

            Map<String, String> friend = {
              'id': friendId,
              'username': friendName
            };

            setState(() {
              friends.add(friend);
            });
          }
        }
        print(friends);
      } else {
        throw Exception('Failed to load friends');
      }
    } catch (error) {
      print('Error fetching friends: $error');
    }
  }

    Future<void> _deleteFriend(String friendId) async {
    try {
        final usersResponse = await http.delete(Uri.parse('http://10.0.2.2:3000/users/$userId/friends/$friendId'));
        if (usersResponse.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color.fromARGB(255, 57, 166, 255),
              content: Text("L'ami a été supprimé avec succès!", 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              duration: Duration(seconds: 3),
            ),
          );
      
          setState(() {
            friends.removeWhere((friend) => friend['id'] == friendId);
          });
        } else {
          throw Exception(usersResponse.statusCode);
        }
      } catch (error) {
        print('Error fetching friends: $error');
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 80),
        const Text(
          'MES AMIS',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        const SizedBox(height: 16),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AddFriendsScreen.routeName,
              );
              print("Ajouter amis button pressed");
            },
            icon: const Icon(Icons.add, color: Colors.blue),
            label: const Text(
              "Ajouter amis",
              style: TextStyle(color: Colors.blue),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.blue),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        ),
        friends.isEmpty
            ? const Center(
                child: Text("Vous n'avez aucuns amis."),
              )
            : Expanded(
                child: ListView(
                  children: friends.map((friend) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 65, 180, 238),
                                Color.fromARGB(255, 54, 155, 206),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            title: Text(
                              "@${friend['username'].toString().toUpperCase()}",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete, 
                                color: Colors.white
                              ),
                              onPressed: () async {
                                _deleteFriend(friend['id']!);
                              },
                            ),
                          ),
                        ),
                      )
                    );
                  }).toList(),
                ),
              ),
      ],
    ),
  );
}
}
final createMaterialColor = CreateMaterialColor();
