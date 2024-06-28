import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/bloc/notes_bloc.dart';
import 'package:notes/entity/notes.dart';
import 'package:notes/pages/notes_input.dart';

class NotesListing extends StatefulWidget {
  const NotesListing({super.key});

  @override
  State<NotesListing> createState() => _NotesListingState();
}

class _NotesListingState extends State<NotesListing> {
  final getIt = GetIt.instance;
  late NotesBloc notesBloc;
  late Timer _timer;
  int _start = 5;
  bool showReview = false;

  List<bool> listOfReview = [];
  @override
  void initState() {
    notesBloc = getIt<NotesBloc>();
    super.initState();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          showReview = true;

          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Notes Listing'),
      ),
      body: Center(
        child: BlocBuilder<NotesBloc, NotesState>(
          bloc: notesBloc,
          builder: (context, state) {
            List<Notes> notesResult = [];
            if (state is NotesAdded) {
              startTimer();
              notesResult = state.notesResult;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(notesResult[index].name),
                                  Text(notesResult[index].notesDetails)
                                ],
                              ),
                            ),
                            (showReview)
                                ? Text(
                                    "Review",
                                    style: TextStyle(color: Colors.blue),
                                  )
                                : Text(
                                    _start.toString(),
                                    style: TextStyle(color: Colors.blue),
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                // notesBloc.add(ModifyNotesEvent(index));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NotesInput(
                                            inputContentToModify: 'send form',
                                            inputTitleToModify: 'sfds',
                                          )),
                                );
                              },
                              child: const Text(
                                'Edit ',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                notesBloc.add(DeleteNotesEvent(index));
                              },
                              child: const Text(
                                'Delete ',
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: notesResult.length),
              );
            }
            return const Text('click + to add new notes');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotesInput(
                      inputContentToModify: '',
                      inputTitleToModify: '',
                    )),
          );
        },
        tooltip: 'Create Note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
