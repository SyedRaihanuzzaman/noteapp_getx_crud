import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_details_controller.dart';
import '../../home/controllers/home_controller.dart';

class NoteDetailsView extends GetView<NoteDetailsController> {
  final homeController = Get.find<HomeController>();

  // Get the note passed as an argument
  final note = Get.arguments;

  NoteDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Details'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,

        // Delete icon in AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              Get.defaultDialog(
                title: "Delete Note",
                middleText: "Are you sure you want to delete this note?",
                textCancel: "Cancel",
                textConfirm: "Delete",
                confirmTextColor: Colors.white,
                onConfirm: () async {
                  Get.back(); // Close the dialog first
                  await Future.delayed(const Duration(milliseconds: 300));
                  await homeController.deleteNote(note.id!);
                  // Navigate back to Home page after deletion
                  Get.offAllNamed('/home');
                },
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: controller.titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: controller.descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Description',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: controller.updateNote,
              icon: const Icon(Icons.save),
              label: const Text(
                'Update Note',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
