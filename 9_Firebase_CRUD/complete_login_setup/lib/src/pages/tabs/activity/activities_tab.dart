import 'package:complete_login_setup/src/firebase_database/models/activity_model.dart';
import 'package:complete_login_setup/src/firebase_database/services/database_service.dart';
import 'package:complete_login_setup/src/pages/tabs/activity/create_or_update_activity_page.dart';
import 'package:complete_login_setup/src/widgets/activity/activities_builder.dart';
import 'package:complete_login_setup/src/widgets/activity/activity_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivitiesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => CreateOrUpdateActivityPage.show(context),
        child: Icon(Icons.add),
      ),
    );
  }

  _buildContents(BuildContext context) {
    final database = Provider.of<DatabaseService>(context, listen: false);
    return StreamBuilder<List<ActivityModel>>(
      stream: database.activitiesStream(),
      builder: (context, snapshot) {
        return ActivityItemsBuilder<ActivityModel>(
          snapshot: snapshot,
          itemBuilder: (context, activity) {
            return ActivityItem(
              activity: activity,
              onTap: () =>
                  CreateOrUpdateActivityPage.show(context, activity: activity),
            );
          },
        );
      },
    );
  }
}
