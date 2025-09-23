import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safebite/screens/home/components/ImageQuantity.dart';
import 'package:safebite/screens/home/components/uploadButton.dart';
import 'package:safebite/util/appColor.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class QRImagePicker extends StatefulWidget {
  const QRImagePicker({super.key});

  @override
  _QRImagePickerState createState() => _QRImagePickerState();
}

class _QRImagePickerState extends State<QRImagePicker> {
  File? _pickedImage;
  var _quantity = "300.00"; //300 grams as initial value
  @override
  void initState() {
    super.initState();
    _loadDefaultImage();
  }

  Future<void> _loadDefaultImage() async {
    final byteData = await rootBundle.load('assets/bir.png');
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/placeholder.png');

    await file.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );

    setState(() {
      _pickedImage = file; // now initialized
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  void handleChildQuantity(String quantity) {
    //updates the quantitiy from ImageQuantity
    setState(() {
      _quantity = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
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
                  Positioned(top: 0, left: 0, child: _buildCorner()),
                  Positioned(top: 0, right: 0, child: _buildCorner(rotate: 90)),
                  Positioned(
                      bottom: 0, left: 0, child: _buildCorner(rotate: -90)),
                  Positioned(
                      bottom: 0, right: 0, child: _buildCorner(rotate: 180)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ImageQunatity(
            onDataChanged: handleChildQuantity,
          ),

          //  Only show UploadButton when _pickedImage is loaded
          if (_pickedImage != null)
            UploadButton(ImageFile: _pickedImage!)
          else
            const CircularProgressIndicator(), // optional loader
        ],
      ),
    );
  }

  Widget _buildCorner({double rotate = 0}) {
    return Transform.rotate(
      angle: rotate * 3.1416 / 180,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColor.primaryDarkest, width: 4),
            left: BorderSide(color: AppColor.primaryDarkest, width: 4),
          ),
        ),
      ),
    );
  }
}
