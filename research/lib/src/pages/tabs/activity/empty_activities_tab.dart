import 'package:complete_login_setup/src/pages/tabs/activity/create_or_update_activity_page.dart';
import 'package:flutter/material.dart';

class EmptyActivitiesTab extends StatelessWidget {
  const EmptyActivitiesTab({
    Key key,
    this.title = 'The list is empty',
    this.message = 'Create a new activity to get started',
  }) : super(key: key);
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 32.0, color: Colors.black54),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              message,
              style: TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'createUpdateButton',
        child: Icon(Icons.add),
        onPressed: () => CreateOrUpdateActivityPage.show(context),
      ),
    );
  }
}
