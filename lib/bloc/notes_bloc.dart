import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/entity/notes.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    List<Notes> noteList = [];

    int notesId = 0;
    on<AddNotesEvent>((event, emit) {
      emit(NotesLoadingState());
      noteList.add(Notes(
          id: notesId++,
          name: event.note.name,
          notesDetails: event.note.notesDetails));

      emit(NotesAdded(notesResult: noteList));
    });

    on<ModifyNotesEvent>((event, emit) {
      emit(NotesLoadingState());

      noteList[event.note.id] = Notes(
          id: event.note.id,
          name: event.note.name,
          notesDetails: event.note.notesDetails);

      emit(NotesAdded(notesResult: noteList));
    });

    on<DeleteNotesEvent>((event, emit) {
      emit(NotesLoadingState());

      noteList.removeAt(event.noteId);

      emit(NotesAdded(notesResult: noteList));
    });
  }
}
