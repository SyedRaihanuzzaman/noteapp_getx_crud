import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_note_controller.dart';

class CreateNoteView extends GetView<CreateNoteController> {
  const CreateNoteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CreateNote'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(10),

        child: Column(
          children: [
            TextFormField(
              controller: controller.titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: controller.descriptionController,
              decoration: InputDecoration(
                hintText: 'Description',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () => controller.addNotes(),
              icon: Icon(Icons.save, color: Colors.black),

              label: Text('Save Note', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
