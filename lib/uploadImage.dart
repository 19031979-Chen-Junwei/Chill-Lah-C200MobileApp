import 'dart:io';

import 'package:chill_lah/welcome.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

class UploadImage extends StatefulWidget {
  const UploadImage({Key key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

File image_1;

class _UploadImageState extends State<UploadImage> {
  //File image_1;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      image_1 = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      image_1 = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPicker(context);
      },
      child: CircleAvatar(
        radius: 55,
        backgroundColor: Color(0xffFDCF09),
        child: image_1 != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  image_1,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitHeight,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50)),
                width: 100,
                height: 100,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.grey[800],
                ),
              ),
      ),
    );
  }
}


// void postHttp() async {
//   var headers = {
//     'Cookie':
//         'ARRAffinity=e4e81bc7848b5fcf59c244bbca7b40027ef11e2df54552edc5b5cfc112694829'
//   };
//   var request = http.MultipartRequest(
//       'POST', Uri.parse('http://c200teame.azurewebsites.net/api/demo/upload'));
//   request.fields
//       .addAll({'username': '', 'password': '12345', 'email': 'ha2@gmail.com'});
//   request.files
//       .add(await http.MultipartFile.fromPath('photo', image_1.path.toString()));
//   request.headers.addAll(headers);

//   http.StreamedResponse response = await request.send();

//   if (response.statusCode == 200) {
//     print("Sended");
//   } else {
//     print(response.reasonPhrase);
//   }
// }
