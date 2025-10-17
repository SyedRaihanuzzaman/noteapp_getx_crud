import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp_crud_getxcli/app/data/model/NoteModel.dart';
import 'package:http/http.dart' as http;
import 'package:noteapp_crud_getxcli/app/modules/home/controllers/home_controller.dart';

class NoteDetailsController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  late NoteModel note;

  @override
  void onInit() {
    super.onInit();

    // Get the passed note from arguments
    note = Get.arguments as NoteModel;

    // Pre-fill the text fields
    titleController.text = note.title ?? '';
    descriptionController.text = note.description ?? '';
  }

  // Optional: cleanup
  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> updateNote() async {
    final updatedTitle = titleController.text.trim();
    final updatedDescription = descriptionController.text.trim();

    if (updatedTitle.isEmpty || updatedDescription.isEmpty) {
      Get.snackbar('Error', 'Title and Description cannot be empty');
      return;
    }

    final updatedNote = NoteModel(
      id: note.id,
      title: updatedTitle,
      description: updatedDescription,
      date: DateTime.now().toString(),
      time: DateTime.timestamp().toString(),
    );

    final url = 'https://68f278b6b36f9750deecbed9.mockapi.io/note/${note.id}';

    final response = await http.put(
      Uri.parse(url),
      body: jsonEncode(updatedNote.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Optional: refresh HomeController notes
      try {
        final homeController = Get.find<HomeController>();
        await homeController.getNotes();
      } catch (_) {}

      Get.back(); // go back to home
    } else {
      Get.snackbar('Error', 'Failed to update note');
    }
  }
}
