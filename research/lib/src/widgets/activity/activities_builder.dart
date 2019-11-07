import 'package:flutter/material.dart';
import 'package:research/src/pages/tabs/activity/empty_activities_tab.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ActivityItemsBuilder<T> extends StatelessWidget {
  const ActivityItemsBuilder(
      {Key key, @required this.snapshot, @required this.itemBuilder})
      : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.active) {
      if (snapshot.hasData) {
        final List<T> items = snapshot.data;
        if (items.isNotEmpty) {
          return _buildList(items);
        } else {
          return EmptyActivitiesTab();
        }
      } else if (snapshot.hasError) {
        print(snapshot);
        print(snapshot.error);
        return EmptyActivitiesTab(
          title: 'Something went wrong',
          message: 'Can\'t load items right now',
        );
      }
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List<T> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(context, items[index]);
      },
    );
  }
}
