import 'package:complete_login_setup/src/firebase_database/models/activity_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityItem extends StatelessWidget {
  const ActivityItem({
    Key key,
    @required this.activity,
    @required this.onTap,
  }) : super(key: key);

  final ActivityModel activity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.symmetric(vertical: 0.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Icon(
            Icons.check_circle_outline,
            size: 50,
            color: activity.isCompleted ? Colors.green : Colors.grey[350],
          ),
          title: Row(
            children: <Widget>[
              Text(
                DateFormat('EEEE').format(activity.activityDate),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                DateFormat.yMMMd().format(activity.activityDate),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              activity.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
