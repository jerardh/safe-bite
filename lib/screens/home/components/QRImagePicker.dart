import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safebite/util/appColor.dart';

class QRImagePicker extends StatefulWidget {
  @override
  _QRImagePickerState createState() => _QRImagePickerState();
}

class _QRImagePickerState extends State<QRImagePicker> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            color: AppColor.divider,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.divider, width: 3),
          ),
          child: Stack(
            children: [
              // Display picked image
              if (_pickedImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _pickedImage!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

              // QR-like corner borders
              Positioned(top: 0, left: 0, child: _buildCorner()),
              Positioned(top: 0, right: 0, child: _buildCorner(rotate: 90)),
              Positioned(bottom: 0, left: 0, child: _buildCorner(rotate: -90)),
              Positioned(bottom: 0, right: 0, child: _buildCorner(rotate: 180)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCorner({double rotate = 0}) {
    return Transform.rotate(
      angle: rotate * 3.1416 / 180,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColor.primaryDarkest, width: 4),
            left: BorderSide(color: AppColor.primaryDarkest, width: 4),
          ),
        ),
      ),
    );
  }
}
