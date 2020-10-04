import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../feature_pages/screen_sizes.dart';

void main() async {
  runApp(UploadFeature());
}

class UploadFeature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(104, 193, 231, .1),
      100: Color.fromRGBO(104, 193, 231, .2),
      200: Color.fromRGBO(104, 193, 231, .3),
      300: Color.fromRGBO(104, 193, 231, .4),
      400: Color.fromRGBO(104, 193, 231, .5),
      500: Color.fromRGBO(104, 193, 231, .6),
      600: Color.fromRGBO(104, 193, 231, .7),
      700: Color.fromRGBO(104, 193, 231, .8),
      800: Color.fromRGBO(104, 193, 231, .9),
      900: Color.fromRGBO(104, 193, 231, 1),
    };

    return MaterialApp(
      home: ImageCapture(),
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF68c1e7, color),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class ImageCapture extends StatefulWidget {
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _file;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _file = selected;
    });
    Uploader(file: _file);
  }

  Future<void> _pickFile() async {
    File selected = await FilePicker.getFile();
    setState(() {
      _file = selected;
    });
    Uploader(file: _file);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon:
                  Icon(Icons.photo_camera, size: 50, color: Color(0xFF68c1e7)),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            SizedBox(width: SizeConfig.blockSizeHorizontal * 30),
            IconButton(
              icon: Icon(Icons.file_copy_outlined,
                  size: 50, color: Color(0xFF68c1e7)),
              onPressed: () => _pickFile(),
            ),
            SizedBox(width: SizeConfig.blockSizeHorizontal * 30),
            IconButton(
              icon:
                  Icon(Icons.photo_library, size: 50, color: Color(0xFF68c1e7)),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
      body: ListView(children: <Widget>[Uploader(file: _file)]),
    );
  }
}

class Uploader extends StatefulWidget {
  File file;

  Uploader({File file}) {
    this.file = file;
  }

  createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://collegemaster-d61fb.appspot.com');

  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filePath = 'essays/${DateTime.now()}.png';
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            return Column(
              children: [
                SizedBox(height: SizeConfig.blockSizeVertical * 22),
                if (!_uploadTask.isComplete)
                  JumpingDotsProgressIndicator(
                    fontSize: 250,
                    color: Color(0xFF68c1e7),
                  )
                else
                  Icon(Icons.check_circle,
                      color: Colors.green,
                      size: SizeConfig.blockSizeVertical * 25),
                if (_uploadTask.isComplete)
                  Container(
                      width: SizeConfig.blockSizeHorizontal * 25,
                      height: SizeConfig.blockSizeVertical * 5,
                      child: FloatingActionButton(
                          backgroundColor: Colors.green,
                          child: Text('Finish',
                              style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14)),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                          onPressed: () {
                            Navigator.pop(context);
                          }))
              ],
            );
          });
    } else {
      return Column(children: <Widget>[
        SizedBox(height: SizeConfig.blockSizeVertical * 30),
        Container(
            height: SizeConfig.blockSizeVertical * 20,
            width: SizeConfig.blockSizeHorizontal * 75,
            child: FloatingActionButton(
                onPressed: _startUpload,
                backgroundColor: Colors.green,
                child: Text('Upload',
                    style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))))),
      ]);
    }
  }
}
