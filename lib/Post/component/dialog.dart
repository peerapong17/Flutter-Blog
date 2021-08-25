

import 'package:blogpost/Authentication/services/auth.dart';
import 'package:flutter/material.dart';

AlertDialog alertDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure?"),
      content: Text("Thank you for using our app"),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("OK"),
          onPressed: () async {
            await AuthService().signOutWithGoogle(context);
          },
        ),
      ],
    );
  }