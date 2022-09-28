import 'dart:io';

import 'package:flutter/material.dart';
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
    Widget _placeholder = Stack(children: [
      Container(
        margin: EdgeInsets.only(top: 48),
       // height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      const Align(
        alignment: Alignment.center,
        child: SizedBox(
          child: CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.blue,
            child: CircleAvatar(
              child: Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 12.0,
                  child: Icon(
                    Icons.camera_alt,
                    size: 15.0,
                    color: Color(0xFF404040),
                  ),
                ),
              ),
              radius: 38.0,
              backgroundImage:
                  AssetImage('default.user.png'),
            ),
          ),
        ),
      )
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
        SizedBox(
          height: 5,
        ),
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
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 40,
            child: GestureDetector(
              onTap: () => _showCamera(context),
              child: Text('Add from Camera'),
            ),
          ),
          SizedBox(
            height: 40,
            child: GestureDetector(
              onTap: () => _showGallery(context),
              child: Text('Add from Gallery'),
            ),
          ),
          SizedBox(
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
