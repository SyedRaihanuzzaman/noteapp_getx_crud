import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(() {
          return GridView.builder(
            itemCount: controller.noteList.length,

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 7,
              crossAxisSpacing: 7,

              crossAxisCount: 2,
            ),

            itemBuilder: (context, index) {
              var note = controller.noteList[index];

              return InkWell(
                onTap: () {
                  Get.toNamed('/note-details', arguments: note);
                },

                onLongPress: () {
                  Get.defaultDialog(
                    title: "Delete Note",
                    middleText: "Are you sure you want to delete this note?",
                    textCancel: "Cancel",
                    textConfirm: "Delete",
                    confirmTextColor: Colors.white,
                    onConfirm: () async {
                      Get.back(); // Close the dialog first
                      await Future.delayed(
                        const Duration(milliseconds: 300),
                      ); // Small delay to avoid dialog reopening issue
                      await controller.deleteNote(
                        note.id!,
                      ); // Then delete the note
                    },
                  );
                },

                child: Card(
                  color: Colors.deepPurple,
                  child: ListTile(
                    title: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      note.title.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      note.description.toString(),
                      style: TextStyle(color: Colors.white),
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,

        onPressed: () {
          Get.toNamed('/create-note');
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
