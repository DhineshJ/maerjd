part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

final class AddNotesEvent extends NotesEvent {
  AddNotesEvent(this.note);

  final Notes note;
}

final class ModifyNotesEvent extends NotesEvent {
  ModifyNotesEvent(this.note);

  final Notes note;
}

final class DeleteNotesEvent extends NotesEvent {
  DeleteNotesEvent(this.noteId);
  int noteId;
  // final Notes note;
}
