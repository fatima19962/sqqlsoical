import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// for picking up image from gallery
//todo  navigation should be used instead of return in exception
pickImage(ImageSource source) async {
  try {
    final ImagePicker imagePicker = ImagePicker();
    XFile? _file = await imagePicker.pickImage(source: source,imageQuality: 40,maxHeight: 400.0,maxWidth: 400.0);
    if (_file != null) {
      return await _file.readAsBytes();
    }
  }
  on Exception{
    return ;
  }catch(e){
    SnackBar(content: Text(e.toString()),backgroundColor: Colors.grey,);
  }
  print('No Image Selected');
}

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
