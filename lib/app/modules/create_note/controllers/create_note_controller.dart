import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp_crud_getxcli/app/data/model/NoteModel.dart';
import 'package:http/http.dart' as http;
import 'package:noteapp_crud_getxcli/app/modules/home/controllers/home_controller.dart';

class CreateNoteController extends GetxController {
  final homeController = Get.find<HomeController>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  Future<void> addNotes() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      Get.snackbar('Error', 'Title and Description cannot be empty');
    } else {
      var newNote = NoteModel(
        title: titleController.text,
        description: descriptionController.text,
        date: DateTime.now().toString(),
        time: DateTime.timestamp().toString(),
      );

      try {
        var response = await http.post(
          Uri.parse(homeController.url),
          body: jsonEncode(newNote.toJson()),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 201) {
          titleController.clear();
          descriptionController.clear();

          await homeController.getNotes();

          Get.back();
        } else {
          Get.snackbar("Error", "Failed to create note");
        }
      } catch (e) {
        Get.snackbar("Exception", "Something went wrong: $e");
      }
    }
  }
}
