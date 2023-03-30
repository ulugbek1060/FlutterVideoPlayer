import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Folder extends Equatable {
  final String title;
  final String id;

  const Folder({required this.title, required this.id});

  @override
  List<Object?> get props => [title];
}

class MainProvider extends ChangeNotifier {
  final folders = <Folder>[
    Folder(title: "First folder", id: "323r3etkj34ntb43thjk"),
    Folder(title: "First folder", id: "323r3etkj34ntb43thjk"),
    Folder(title: "First folder", id: "323r3etkj34ntb43thjk"),
  ];

  createFolder(String title) {
    final id = const Uuid().v4();
    final newFolder = Folder(title: title, id: id);
    folders.add(newFolder);
    notifyListeners();
  }

  deleteFolder(String id) {
    final folder = folders.firstWhere((folder) => folder.id == id);
    folders.remove(folder);
    notifyListeners();
  }
}
