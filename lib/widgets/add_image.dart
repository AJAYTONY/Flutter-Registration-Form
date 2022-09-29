import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';

class AddImageForm extends StatelessWidget {
  final String? imagePath;
  final Function(String)? onChanged;

  const AddImageForm({
    Key? key,
    this.imagePath,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _placeholder = Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 18.0, left: 168.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                width: 28.0,
                height: 28.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                      //fit: BoxFit.fill,
                      image: AssetImage('assets/images/pencil2.png')),
                ),
              )
            ]),
      ),
      Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                width: 68.0,
                height: 68.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/images/default_user.png')),
                ),
              ),
            ]),
      ),
    ]);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
            onTap: () => _onAddImage(context),
            child: imagePath == null
                ? _placeholder
                : _ImageWidget(
                    image: imagePath,
                  )),
        // const SizedBox(
        //   height: 5,
        // ),
        // Text('Add Profile Image'),
      ],
    );
  }

  _onAddImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            'Add Profile Picture',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey.shade500),
          ),
          // const SizedBox(
          //   height: 16,
          // ),
          Divider(),
          SizedBox(
            //height: 40,
            child: GestureDetector(
              onTap: () => _showCamera(context),
              child: Text(
                'Take a Picture',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.blue.shade500),
              ),
            ),
          ),
          Divider(),
          SizedBox(
            // height: 40,
            child: GestureDetector(
              onTap: () => _showGallery(context),
              child: Text('Choose from Gallery',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.blue.shade500)),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  _showCamera(BuildContext context) {
    Navigator.of(context).pop();
    _showImagePicker(ImageSource.camera);
  }

  _showGallery(BuildContext context) {
    Navigator.of(context).pop();
    _showImagePicker(ImageSource.gallery);
  }

  _showImagePicker(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile? image =
        await imagePicker.getImage(source: imageSource, imageQuality: 60);
    if (image != null) {
      //onChanged(image.path);
    }
  }
}

class _ImageWidget extends StatelessWidget {
  final String? image;

  const _ImageWidget({
    Key? key,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _validURL = Uri.parse(image!).isAbsolute;
    return Container(
      height: 100,
      width: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: _validURL
            ? Image.network(
                image!,
                fit: BoxFit.cover,
              )
            : Image.file(
                File(image!),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
