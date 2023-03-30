import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player_sample/main.dart';

import '../app_providers/main_provider.dart';

enum SampleItem { delete, move, createFolder }

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final folders = Provider.of<MainProvider>(context).folders;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Download",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => sortDialog(context),
              );
            },
            icon: const Icon(Icons.menu),
          ),
          const PopupMenu()
        ],
      ),

      // body
      body: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Card(
                color: Colors.white,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        SizedBox(width: 12),
                        Icon(Icons.folder_open_outlined),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Recently added files 0",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (folders.isEmpty)
              Center(
                child: Column(
                  children: const [
                    Icon(Icons.hourglass_empty),
                    SizedBox(height: 12),
                    Text("Currently is empty!")
                  ],
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: folders.length,
                itemBuilder: (context, index) {
                  return ItemFolder(folder: folders[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Dialog sortDialog(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ), //this right here
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "Sort",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close_rounded),
                  )
                ],
              ),
              const SortDialogListItem(
                title: "New order",
                isSelected: true,
                itemId: 1,
              ),
              const SortDialogListItem(
                title: "Date order",
                isSelected: false,
                itemId: 1,
              ),
              const SortDialogListItem(
                title: "File size order",
                isSelected: false,
                itemId: 1,
              ),
            ],
          ),
        ),
      );
}

// folder item ---------------------------------->
class ItemFolder extends StatelessWidget {
  final Folder folder;

  const ItemFolder({Key? key, required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: Row(
        children: [
          // icon
          const Icon(Icons.folder_open_outlined),
          SizedBox(width: 12.0,),
          // title
          Expanded(child: Text(folder.title)),
          // text 0
          Text("0"),
          // icon dots
          const Icon(Icons.more_vert_outlined),
        ],
      ),
    );
  }
}

// sort dialog ---------------------------------->
class SortDialogListItem extends StatelessWidget {

  final bool isSelected;
  final String title;
  final itemId;

  const SortDialogListItem({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.itemId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          if (isSelected) const Icon(Icons.check)
        ],
      ),
    );
  }
}

// popup menu ------------------------------------->

class PopupMenu extends StatefulWidget {
  const PopupMenu({Key? key}) : super(key: key);

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  SampleItem? selectedMenu;
  late TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,
      onSelected: (SampleItem item) {
        if (item == SampleItem.move) {
          // ScaffoldMessenger.of(context).hideCurrentSnackBar();
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text("Move"),
          //   ),
          // );
          Navigator.of(context).push(MyHomePage.route("Video"));
        } else if (item == SampleItem.delete) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Delete"),
            ),
          );
        } else if (item == SampleItem.createFolder) {
          showDialog(
            context: context,
            builder: (BuildContext context) => sortDialog(context),
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.delete,
          child: Text('Delete'),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.move,
          child: Text('Move'),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.createFolder,
          child: Text('Create folder'),
        ),
      ],
    );
  }

  Dialog sortDialog(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ), //this right here
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Create a new folder",
                style: TextStyle(fontSize: 20),
              ),
              const TextField(

              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Confirm"),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
}
