import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kings_store/screens/edit_profile_screen.dart';
import 'package:kings_store/screens/signin_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Ella Jorman',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileItem(
              context,
              "Edit Profile",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()));
              },
            ),
            _buildProfileItem(context, "Delivery Address", onTap: () {}),
            _buildProfileItem(context, 'Order Tracking', onTap: () {}),
            _buildProfileItem(context, "Order History", onTap: () {}),
            _buildProfileItem(context, "Wishlist", onTap: () {}),
            _buildProfileItem(context, "Add bank details", onTap: () {}),
            _buildProfileItem(context, "Log Out", onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage()));
            })
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(BuildContext context, String title,
      {required VoidCallback onTap}) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
