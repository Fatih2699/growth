import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:growth/models/customer_detail_model.dart';
import 'package:growth/models/notes_model.dart';
import 'package:growth/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotesScreen extends StatefulWidget {
  final int? id;
  final String? title;
  const NotesScreen({Key? key, this.id, this.title}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('tr', timeago.TrMessages());
    callNotes();
  }

  Notes? notes;
  var articles = <Notes>[];
  UserData? user;
  Customer? customer;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formUpdateKey = GlobalKey<FormState>();
  var note;
  var name;
  TextEditingController textController = TextEditingController();
  TextEditingController textUpdatedController = TextEditingController();
  Map<int, TextEditingController> textUpdatedControllers = {};
  var apiurl = '...';
  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    print(DateTime.now().toString() +
        '-->' +
        d.toString() +
        '--> ' +
        diff.inHours.toString());
    return diff.inHours.toString();
  }

  bool _isLoading = true;
  void _changeLoading() async {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future callNotes() async {
    String url = '...' + widget.id.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      debugPrint("CALL NOTES: " + response.body);
      var result = notesFromJson(response.body);
      setState(() {
        note = result;
      });
      _changeLoading();

      return result;
    } catch (e) {
      print("HATA: " + e.toString());
    }
  }

  Future<void> _addNote() async {
    String url = '...';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    var userId = _prefs.getInt('user_id');
    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "user_id": userId.toString(),
        "note": textController.text,
        "license_id": widget.id!.toString(),
      });
      var result = notesFromJson(response.body);
      setState(() {
        note = result;
      });
      debugPrint("ADD NOTE: " + response.body);
      clearResults();
      Fluttertoast.showToast(msg: 'Notunuz başarıyla kaydedildi.');
    } catch (e) {
      debugPrint("HATA::" + e.toString());
    }
  }

  Future<void> deleteNote(int? index) async {
    String url = '...';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    var userId = _prefs.getInt('user_id');

    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "user_id": userId.toString(),
        "note_id": index.toString(),
        "license_id": widget.id!.toString(),
      });
      var result = notesFromJson(response.body);
      setState(() {
        note = result;
      });
      Fluttertoast.showToast(msg: 'Not Silindi');
      Navigator.pop(context);
    } catch (e) {
      debugPrint("HATA!!! DELETE NOTE:" + e.toString());
    }
  }

  Future<void> _updateNote(int index, int? id) async {
    String url = '...';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    var userId = _prefs.getInt('user_id');
    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "updater_user_id": userId.toString(),
        "note_id": id.toString(),
        "license_id": widget.id!.toString(),
        'note': textUpdatedControllers[id]!.text
      });
      debugPrint("UPDATE NOTE: " + response.body);
      var result = notesFromJson(response.body);
      setState(() {
        note = result;
      });
    } catch (e) {
      debugPrint("HATA!!! UPDATE NOTE:" + e.toString());
    }
  }

  Future _showDialog(int? id) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Silmek İstediğinize emin misiniz?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'İptal',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            MaterialButton(
              color: Colors.red,
              onPressed: () async {
                deleteNote(id);
              },
              child: const Text(
                'Sil',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF06113C),
          toolbarHeight: 80,
          elevation: 5,
          title: const Text('NOTLAR'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    AutoSizeText(
                      widget.title!,
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.bold),
                      maxFontSize: 19,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(thickness: 2, color: Colors.black12),
                    const SizedBox(height: 10),
                    Form(
                      key: _formKey,
                      child: TextField(
                        controller: textController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Not Giriniz',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            _addNote();
                          },
                          child: const Text('Kaydet',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF06113C)),
                        )
                      ],
                    ),
                    const Divider(thickness: 0.75, color: Colors.black),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              controller: ScrollController(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: note.notes.length,
                              itemBuilder: (context, index) {
                                TextEditingController textUpdatedController =
                                    TextEditingController(
                                        text: note.notes[index].note);
                                int itemId = note.notes[index].noteId;
                                textUpdatedControllers
                                    .addAll({itemId: textUpdatedController});
                                //.add(textUpdatedController);
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(note.notes[index].note.toString(),
                                            style:
                                                const TextStyle(fontSize: 16)),
                                        const SizedBox(height: 10),
                                        Row(
                                          //TAŞMA OLUYOR
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                AutoSizeText(
                                                  note.notes[index].updaterUser,
                                                  minFontSize: 10,
                                                  maxFontSize: 12,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                AutoSizeText(
                                                  ' - ' +
                                                      DateFormat(
                                                              'dd/MM/yyyy   HH:mm')
                                                          .format(note
                                                              .notes[index]
                                                              .updatedAt),
                                                  minFontSize: 10,
                                                  maxFontSize: 12,
                                                )
                                              ],
                                            ),
                                            SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                      timeago.format(
                                                          DateTime.parse(note
                                                              .notes[index]
                                                              .updatedAt
                                                              .toString()),
                                                          locale: 'tr'),
                                                      style: const TextStyle(
                                                          color: Colors.green)),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                scrollable:
                                                                    true,
                                                                content: Column(
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const CircleAvatar(
                                                                            minRadius:
                                                                                8,
                                                                            maxRadius:
                                                                                15,
                                                                            child:
                                                                                Icon(Icons.close),
                                                                            backgroundColor:
                                                                                Colors.red,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Form(
                                                                      key:
                                                                          _formUpdateKey,
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            TextField(
                                                                              controller: textUpdatedControllers[itemId],
                                                                              maxLines: 5,
                                                                              decoration: const InputDecoration(
                                                                                border: OutlineInputBorder(),
                                                                                labelText: 'Not Giriniz...',
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(primary: const Color(0xFF06113C)),
                                                                                    child: const Text('Güncelle'),
                                                                                    onPressed: () async {
                                                                                      await _updateNote(index, note.notes[index].noteId);
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        icon: const Icon(
                                                            Icons.edit,
                                                            color: Colors.grey),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          _showDialog(note
                                                              .notes[index]
                                                              .noteId);
                                                        },
                                                        icon: const Icon(
                                                            Icons.delete,
                                                            color: Colors.red),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void clearResults() {
    setState(() {
      articles = [];
    });
    textController.clear();
  }
}
