import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ListStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/striingList.txt');
  }

  Future<File> writeList(List listTODO) async {
    final file = await _localFile;
    String fullString = '';
    for (var item in listTODO) {
      if (listTODO.length <= 1) {
        fullString += item;
      } else {
        fullString += '%D%' + item;
      }
    }
    // Write the file
    return file.writeAsString('$fullString');
  }

  Future<List> readList() async {
    try {
      final file = await _localFile;
      List currentList;
      List endedList = [];
      // Read the file
      final contents = await file.readAsString();
      currentList = contents.split('%D%');
      for (var item in currentList) {
        if (item == '') {
          continue;
        } else {
          endedList.add(item);
        }
      }
      return endedList;
    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }
}
