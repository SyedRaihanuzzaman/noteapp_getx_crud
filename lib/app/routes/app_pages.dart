import 'package:get/get.dart';

import '../modules/create_note/bindings/create_note_binding.dart';
import '../modules/create_note/views/create_note_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/note_details/bindings/note_details_binding.dart';
import '../modules/note_details/views/note_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(name: _Paths.HOME, page: () => HomeView(), binding: HomeBinding()),
    GetPage(
      name: _Paths.CREATE_NOTE,
      page: () => const CreateNoteView(),
      binding: CreateNoteBinding(),
    ),
    GetPage(
      name: _Paths.NOTE_DETAILS,
      page: () => NoteDetailsView(),
      binding: NoteDetailsBinding(),
    ),
  ];
}
