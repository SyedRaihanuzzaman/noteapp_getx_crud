import 'dart:convert';
import 'package:get/get.dart';
import 'package:noteapp_crud_getxcli/app/data/model/NoteModel.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  String url = 'https://68f278b6b36f9750deecbed9.mockapi.io/note';

  var noteList = <NoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getNotes();
  }

  Future<void> getNotes() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> notes = jsonDecode(response.body);
        noteList.assignAll(
          notes.map((note) => NoteModel.fromJson(note)).toList(),
        );
      } else {
        Get.snackbar("Error", "Failed to fetch notes: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  Future<void> deleteNote(String id) async {
    final url = 'https://68f278b6b36f9750deecbed9.mockapi.io/note/$id';

    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        // Remove from UI list
        noteList.removeWhere((note) => note.id == id);
      } else {
        Get.snackbar("Error", "Failed to delete note");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }
  }
}
