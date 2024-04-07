import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:log450_doit/ui/reusableWidgets/friendItem.dart';
import 'package:log450_doit/ui/reusableWidgets/searchBar.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';
import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/sharedPreferences.dart';

class AddFriendsScreen extends StatefulWidget {
  const AddFriendsScreen({super.key});

  static const routeName = '/addfriends';

    @override
  _AddFriendsScreenState createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> {
  late String userId = SharedPreferences.shared.userId;
  List<Map<String, String>> friends = [];
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> filteredFriends = [];

  @override
  void initState() {
    super.initState();
    _fetchUserFriends();
  }

  Future<void> _fetchUserFriends() async {
    setState(() {
      isLoading = true;
    });

    try {
      final usersResponse = await http.get(Uri.parse('http://10.0.2.2:3000/users'));
      if (usersResponse.statusCode == 200) {
        List<dynamic> allUsers = jsonDecode(usersResponse.body);

        final userResponse = await http.get(Uri.parse('http://10.0.2.2:3000/users/$userId'));
        if (userResponse.statusCode == 200) {
          Map<String, dynamic> userData = jsonDecode(userResponse.body);
          List<dynamic> friendIds = userData['friend_ids'];

          for (var user in allUsers) {
            String userId = user['_id'];

            if (userId != this.userId && !friendIds.contains(userId)) {
              String userName = user['username'];

              Map<String, String> friend = {
                'id': userId,
                'username': userName,
              };

              friends.add(friend);
            }
          }
        } else {
          throw Exception('Failed to load current user');
        }
      } else {
        throw Exception('Failed to load all users');
      }

      setState(() {
        filteredFriends = List<Map<String, String>>.from(friends); // Initialize filtered list
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching friends: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _addFriend(String friendId) async {
    try {
        final usersResponse = await http.post(Uri.parse('http://10.0.2.2:3000/users/$userId/friends/$friendId'));
        if (usersResponse.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color.fromARGB(255, 57, 166, 255),
              content: Text("L'ami a été ajouté avec succès!", 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              duration: Duration(seconds: 3),
            ),
          );
      
          setState(() {
            filteredFriends.removeWhere((friend) => friend['id'] == friendId);
          });
        } else {
          throw Exception(usersResponse.statusCode);
        }
      } catch (error) {
        print('Error fetching friends: $error');
    }
  }

  void _filterFriends(String searchText) {
    setState(() {
      filteredFriends = friends.where((friend) =>
          friend['username']!.toLowerCase().contains(searchText.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 80),
          const Text(
            'AJOUTER AMIS',
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterFriends,
              decoration: InputDecoration(
                labelText: 'Rechercher un ami',
                labelStyle: TextStyle(color: Colors.blue), 
                prefixIcon: Icon(Icons.search, color: Colors.blue), 
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: Colors.blue), 
                  onPressed: () {
                    searchController.clear();
                    _filterFriends('');
                  },
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), 
                  borderSide: BorderSide(color: Colors.blue, width: 2.0), 
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), 
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              style: TextStyle(color: Colors.blue), 
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                )
              : filteredFriends.isEmpty && friends.isNotEmpty
                  ? const Center(
                      child: Text("Aucun utilisateur trouvé."),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: filteredFriends.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, String> friend = filteredFriends[index];
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
                                      Color.fromARGB(255, 65, 174, 238),
                                      Color.fromARGB(255, 54, 206, 135),
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
                                      Icons.add_circle_rounded,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      _addFriend(friend['id']!);
                                      print("Add friend logic");
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}

final createMaterialColor = CreateMaterialColor();
