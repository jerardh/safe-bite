import 'dart:io';
import 'package:image/image.dart' as img;

class PreProcessImage {
  Future<List<List<List<List<double>>>>> preprocessImage(File imageFile) async {
    // 1. Decode image using image package
    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());

    // 2. Resize to 224x224
    image = img.copyResize(image!, width: 224, height: 224);

    // 3. Convert to RGB and normalize (0–1)
    List<List<List<double>>> imageMatrix = List.generate(
      224,
      (y) => List.generate(
        224,
        (x) {
          final pixel = image!.getPixel(x, y);
          return [
            (img.getRed(pixel) / 255.0),
            (img.getGreen(pixel) / 255.0),
            (img.getBlue(pixel) / 255.0),
          ];
        },
      ),
    );

    // 4. Add batch dimension → shape [1,224,224,3]
    return [imageMatrix];
  }
}
