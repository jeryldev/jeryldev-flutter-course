import 'dart:async';
import 'dart:io';
import 'package:complete_login_setup/src/connectivity/connectivity_service.dart';
import 'package:complete_login_setup/src/firebase_database/models/activity_model.dart';
import 'package:complete_login_setup/src/firebase_database/services/database_service.dart';
import 'package:complete_login_setup/src/widgets/activity/activity_image.dart';
import 'package:complete_login_setup/src/widgets/common/custom_button.dart';
import 'package:complete_login_setup/src/widgets/platform_alert_dialog.dart';
import 'package:complete_login_setup/src/widgets/platform_exception_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CreateOrUpdateActivityPage extends StatefulWidget {
  const CreateOrUpdateActivityPage(
      {Key key, @required this.database, this.activity})
      : super(key: key);

  final DatabaseService database;
  final ActivityModel activity;

  static Future<void> show(
    BuildContext context, {
    ActivityModel activity,
  }) async {
    final database = Provider.of<DatabaseService>(context);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateOrUpdateActivityPage(
          database: database,
          activity: activity,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _CreateOrUpdateActivityPageState createState() =>
      _CreateOrUpdateActivityPageState();
}

class _CreateOrUpdateActivityPageState
    extends State<CreateOrUpdateActivityPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _titleFieldNode = FocusNode();
  final FocusNode _descriptionFieldNode = FocusNode();

  String _title;
  DateTime _activityDate;
  String _description;
  bool _status = false;
  double _latitude = 14.5409;
  double _longitude = 121.0503;

  File _imageFile;
  String _imageDownloadURL;
  String _imagePathName;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final activityDate = widget.activity?.activityDate ?? DateTime.now();
    _activityDate =
        DateTime(activityDate.year, activityDate.month, activityDate.day);
    if (widget.activity != null) {
      _title = widget.activity.title;
      _description = widget.activity.description;
      _status = widget.activity.isCompleted;
      _imageDownloadURL = widget.activity.imageURL;
      _imagePathName = widget.activity.imagePath;
    }
  }

  @override
  dispose() {
    _titleFieldNode.dispose();
    _descriptionFieldNode.dispose();
    super.dispose();
  }

  Future getImage(bool isCamera) async {
    File image;
    isCamera
        ? image = await ImagePicker.pickImage(source: ImageSource.camera)
        : image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() => _imageFile = image);
  }

  Future<void> uploadImage() async {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    setState(() {
      _imagePathName = 'user/${user.uid}/images/${DateTime.now()}.png';
    });
    print('file path name = $_imagePathName');
    StorageReference _reference =
        FirebaseStorage.instance.ref().child(_imagePathName);

    StorageUploadTask _uploadTask = _reference.putFile(_imageFile);

    var imageURL = await (await _uploadTask.onComplete).ref.getDownloadURL();

    setState(() {
      _imageDownloadURL = imageURL.toString();
    });
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }

  Future<void> _submit(ConnectivityStatus connectionStatus) async {
    setState(() {
      isLoading = true;
    });
    if (_validateAndSaveForm()) {
      try {
        if (_imageFile != null) {
          await uploadImage();
        }
        final activities = await widget.database.activitiesStream().first;
        final activityTitles =
            activities.map((activity) => activity.title).toList();

        if (widget.activity != null) {
          activityTitles.remove(widget.activity.title);
        }
        if (activityTitles.contains(_title)) {
          Navigator.of(context).pop();
          PlatformAlertDialog(
            title: 'Title is already used',
            content: 'Please choose a different To-do title',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          final id = widget.activity?.id ?? documentIdFromCurrentDate();
          final activity = ActivityModel(
            id: id,
            title: _title,
            activityDate: _activityDate,
            description: _description,
            isCompleted: _status,
            latitude: _latitude,
            longitude: _longitude,
            imageURL: _imageDownloadURL,
            imagePath: _imagePathName,
          );

          if (connectionStatus == ConnectivityStatus.Offline) {
            Navigator.of(context).pop();
          }

          await widget.database.setActivity(activity);

          Navigator.of(context).pop();
        }
      } on PlatformException catch (err) {
        PlatformExceptionAlertDialog(
          title: 'Operation failed.',
          exception: err,
        ).show(context);
      }
    }
  }

  Future<void> _delete(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    if (widget.activity.imagePath != '') {
      await FirebaseStorage.instance
          .ref()
          .child(widget.activity.imagePath)
          .delete()
          .then(
            (_) => print('Successfully deleted $_imagePathName storage item'),
          );
    }
    try {
      final database = Provider.of<DatabaseService>(context);
      await database.deleteActivity(widget.activity);

      Navigator.of(context).pop();
    } on PlatformException catch (err) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed.',
        exception: err,
      ).show(context);
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime _selectedDate = await showDatePicker(
        context: context,
        initialDate: _activityDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2100),
        builder: (context, child) => SingleChildScrollView(child: child));
    if (_selectedDate != null) {
      setState(() => _activityDate = _selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    ConnectivityStatus connectionStatus =
        Provider.of<ConnectivityStatus>(context);
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: Colors.white,
      opacity: 1,
      progressIndicator: Scaffold(
        body: Center(
          child: Container(
            height: 200,
            width: 200,
            child: LiquidCircularProgressIndicator(
              value: 0.25,
              // Defaults to 0.5.
              valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
              // Defaults to the current Theme's accentColor.
              backgroundColor: Colors.white,
              // Defaults to the current Theme's backgroundColor.
              borderColor: Colors.lightBlue,
              borderWidth: 5.0,
              direction: Axis.vertical,
              // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
              center: Container(
                child: Text(
                  "Processing",
                  style: TextStyle(color: Colors.blue, fontSize: 32),
                ),
              ),
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.activity == null
              ? 'Create a new Activity'
              : 'Update the Activity'),
        ),
        body: _buildContents(context, connectionStatus),
        backgroundColor: Colors.blue[50],
      ),
    );
  }

  Widget _buildContents(
      BuildContext context, ConnectivityStatus connectionStatus) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(context, connectionStatus),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, ConnectivityStatus connectionStatus) {
    return Form(
      key: _formKey,
      child: Column(
        children: _buildFormChildren(context, connectionStatus),
      ),
    );
  }

  List<Widget> _buildFormChildren(
      BuildContext context, ConnectivityStatus connectionStatus) {
    print('imageFile: $_imageFile');
//    print('image URL: ${widget.activity.imageURL}');
    print('image URL: $_imageDownloadURL');
    print('image Path: $_imagePathName');
//    print('image Path: ${widget.activity.imagePath}');
    return [
      GestureDetector(
        onTap: () => getImage(true),
        child: ActivityImage(
          file: _imageFile,
          imageURL: _imageDownloadURL,
          activity: widget.activity,
        ),
      ),
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Title',
        ),
        initialValue: _title,
        validator: (value) =>
            value.isNotEmpty ? null : 'activity name should not be empty.',
        onSaved: (value) => _title = value,
        focusNode: _titleFieldNode,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) {
          _titleFieldNode.unfocus();
          FocusScope.of(context).requestFocus(_descriptionFieldNode);
        },
      ),
      SizedBox(height: 8.0),
      ListTile(
        leading: Icon(Icons.calendar_today),
        title: Text(
          'Date',
          style: TextStyle(fontSize: 18),
        ),
        trailing: Text('${DateFormat.yMMMd().format(_activityDate)}',
            style: TextStyle(fontSize: 18)),
        onTap: () => _selectDate(context),
      ),
      SizedBox(height: 8.0),
      TextFormField(
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: 'Description',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        initialValue: _description,
        keyboardType: TextInputType.multiline,
        maxLength: 100,
        maxLines: 3,
        onSaved: (value) => _description = value,
        focusNode: _descriptionFieldNode,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (value) {
          _descriptionFieldNode.unfocus();
        },
      ),
      SizedBox(height: 8.0),
      SwitchListTile(
        title: Text(
          'Is this complete?',
          style: TextStyle(fontSize: 18),
        ),
        activeColor: Colors.green,
        onChanged: (bool value) {
          setState(() => _status = value);
        },
        value: _status,
      ),
      SizedBox(height: 25.0),
      Row(
        mainAxisAlignment: widget.activity != null
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.center,
        children: <Widget>[
          CustomButton(
            color: Colors.red,
            text: 'Submit',
            textColor: Colors.white,
            onPressed: () => _submit(connectionStatus),
            borderRadius: 8.0,
          ),
          widget.activity != null
              ? Column(
                  children: <Widget>[
                    SizedBox(width: 25.0),
                    CustomButton(
                      color: Colors.red,
                      text: 'Delete',
                      textColor: Colors.white,
                      onPressed: () => _delete(context),
                      borderRadius: 8.0,
                    )
                  ],
                )
              : Container(),
        ],
      ),
    ];
  }
}
