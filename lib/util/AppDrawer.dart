import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safebite/screens/updateProfile/updateProfile.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/appColor.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColor.primary),
            child: Text(AppText.title, style: AppText().primaryStyle),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => UpdateProfile()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
