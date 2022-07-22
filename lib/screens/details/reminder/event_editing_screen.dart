import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:growth/constants/app_constant.dart';
import 'package:growth/models/event_model.dart';
import 'package:growth/screens/details/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class EventEditingPage extends StatefulWidget {
  final int? id;
  final String? title;
  const EventEditingPage({Key? key, this.id, this.title}) : super(key: key);

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  bool isLoading = true;
  changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('tr', timeago.TrMessages());
    if (event == null) {
      remindDate = DateTime.now();
    }
    callEvents();
    initializeDateFormatting();
  }

  late DateTime remindDate;
  final _formKey = GlobalKey<FormState>();
  final _formUpdateKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final titleUpdateController = TextEditingController();
  final descriptionUpdateController = TextEditingController();
  List<TextEditingController> textTitleUpdatedControllers = [];
  List<TextEditingController> textDescriptionUpdatedControllers = [];
  bool isChecked = false;
  bool _isLoading = true;
  Event? event;
  var calendar;

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    return diff.inHours.toString();
  }

  void _changeLoading() async {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future callEvents() async {
    String url = '...' + widget.id.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      debugPrint(response.body);

      var result = eventFromJson(response.body);
      setState(() {
        calendar = result;
      });
      _changeLoading();

      return result;
    } catch (e) {
      print("HATA: " + e.toString());
    }
  }

  Future<void> addEvents() async {
    String url = '...';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    var userId = _prefs.getInt('user_id');
    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "user_id": userId.toString(),
        "title": titleController.text,
        "description": descriptionController.text,
        "remind_date": remindDate.toString(),
        "license_id": widget.id!.toString(),
      });
      var result = eventFromJson(response.body);
      setState(() {
        calendar = result;
      });
      titleController.text = '';
      descriptionController.text = '';
      debugPrint("ADD EVENTS: " + response.body);
    } catch (e) {
      debugPrint("HATA::" + e.toString());
    }
  }

  Future<void> updateEvent(int index, int? id) async {
    String url = '...';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    var userId = _prefs.getInt('user_id');
    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "updater_user_id": userId.toString(),
        "reminder_id": id.toString(),
        "license_id": widget.id!.toString(),
        "title": textTitleUpdatedControllers[index].text,
        "description": textDescriptionUpdatedControllers[index].text,
      });
      debugPrint('UPDATE REMINDER: ' + response.body);
      var result = eventFromJson(response.body);
      setState(() {
        calendar = result;
      });
    } catch (e) {
      debugPrint("HATA!!! UPDATE NOTE:" + e.toString());
    }
  }

  Future<void> deleteEvent(int? id) async {
    String url = '...';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    var userId = _prefs.getInt('user_id');

    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "updater_user_id": userId.toString(),
        "reminder_id": id.toString(),
        "license_id": widget.id!.toString(),
      });
      var result = eventFromJson(response.body);
      setState(() {
        calendar = result;
      });
      Navigator.pop(context);
      debugPrint("DELETE NOTE: " + response.body);
    } catch (e) {
      debugPrint("HATA!!! DELETE NOTE:" + e.toString());
    }
  }

  Future<void> updateEventStatus(int id, String status) async {
    String url = '...';

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    var userId = _prefs.getInt('user_id');
    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "status": status,
        "updater_user_id": userId.toString(),
        "reminder_id": id.toString(),
        "license_id": widget.id!.toString(),
      });
      var result = eventFromJson(response.body);
      setState(() {
        calendar = result;
      });
      debugPrint("DELETE NOTE: " + response.body);
    } catch (e) {
      debugPrint("HATA!!! DELETE NOTE:" + e.toString());
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
                  await deleteEvent(id);
                },
                child: const Text(
                  'Sil',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF06113C),
          toolbarHeight: 80,
          elevation: 5,
          title: const Text(
            'HATIRLATMA SAYFASI',
            style: TextStyle(color: Colors.white),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              AutoSizeText(
                widget.title!,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                maxFontSize: 20,
                maxLines: 2,
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(thickness: 2, color: Colors.black12),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    buildDateTimePickers(),
                    const SizedBox(height: 5),
                    buildTitle(),
                    const SizedBox(height: 5),
                    buildDescription(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      addEvents();
                    },
                    child: const Text('Kaydet',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF06113C)),
                  )
                ],
              ),
              const Divider(thickness: 0.75, color: Colors.black),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              controller: ScrollController(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: calendar.reminders.length,
                              itemBuilder: (context, index) {
                                final difference = DateTime.now()
                                    .difference(
                                        calendar.reminders[index].remindDate)
                                    .inDays;
                                TextEditingController
                                    textTitleUpdatedController =
                                    TextEditingController(
                                        text: calendar.reminders[index].title);
                                textTitleUpdatedControllers
                                    .add(textTitleUpdatedController);
                                TextEditingController
                                    textDescriptionUpdatedController =
                                    TextEditingController(
                                        text: calendar
                                            .reminders[index].description);
                                textDescriptionUpdatedControllers
                                    .add(textDescriptionUpdatedController);
                                bool isComplated = calendar
                                        .reminders[index].status
                                        .toString() ==
                                    'completed';
                                return Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        SingleChildScrollView(
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  ColorFiltered(
                                                    colorFilter: isComplated
                                                        ? const ColorFilter
                                                            .matrix(<double>[
                                                            0.2126,
                                                            0.7152,
                                                            0.0722,
                                                            0,
                                                            0,
                                                            0.2126,
                                                            0.7152,
                                                            0.0722,
                                                            0,
                                                            0,
                                                            0.2126,
                                                            0.7152,
                                                            0.0722,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            1,
                                                            0,
                                                          ])
                                                        : const ColorFilter
                                                            .linearToSrgbGamma(),
                                                    child: const Image(
                                                        image: AssetImage(
                                                            'assets/icons/bell.png'),
                                                        width: 20,
                                                        height: 20),
                                                  ),
                                                  const SizedBox(width: 15),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      isComplated
                                                          ? Text(
                                                              calendar
                                                                  .reminders[
                                                                      index]
                                                                  .title
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey))
                                                          : Text(
                                                              calendar
                                                                  .reminders[
                                                                      index]
                                                                  .title
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      const SizedBox(
                                                          height: 10),
                                                      isComplated
                                                          ? Text(
                                                              DateFormat.yMMMMd(
                                                                      'tr')
                                                                  .format(calendar
                                                                      .reminders[
                                                                          index]
                                                                      .remindDate),
                                                              // DateFormat(
                                                              //         'dd/MM/yyyy   HH:mm')
                                                              //     .format(calendar
                                                              //         .reminders[
                                                              //             index]
                                                              //         .remindDate),
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey))
                                                          : Text(
                                                              DateFormat(
                                                                      'dd/MM/yyyy   HH:mm')
                                                                  .format(calendar
                                                                      .reminders[
                                                                          index]
                                                                      .remindDate),
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      const SizedBox(
                                                          height: 10),
                                                      isComplated
                                                          ? Text(
                                                              calendar
                                                                  .reminders[
                                                                      index]
                                                                  .description
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey))
                                                          : Text(calendar
                                                              .reminders[index]
                                                              .description
                                                              .toString()),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3.5),
                                              Checkbox(
                                                value: isComplated,
                                                onChanged: (bool? value) {
                                                  if (value == true) {
                                                    updateEventStatus(
                                                        calendar
                                                            .reminders[index]
                                                            .reminderId,
                                                        "completed");
                                                  } else {
                                                    updateEventStatus(
                                                        calendar
                                                            .reminders[index]
                                                            .reminderId,
                                                        "pending");
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                          scrollDirection: Axis.horizontal,
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          //taşma oluyor
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      calendar
                                                          .reminders[index].name
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color: Colors.grey)),
                                                  Text(
                                                    ' - ' +
                                                        DateFormat(
                                                                'dd/MM/yyyy   HH:mm')
                                                            .format(calendar
                                                                .reminders[
                                                                    index]
                                                                .updatedAt),
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ]),
                                            Text(
                                                timeago.format(
                                                    DateTime.parse(calendar
                                                        .reminders[index]
                                                        .updatedAt
                                                        .toString()),
                                                    locale: 'tr'),
                                                style: const TextStyle(
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          scrollable: true,
                                                          content: Column(
                                                            children: <Widget>[
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        const CircleAvatar(
                                                                      minRadius:
                                                                          8,
                                                                      maxRadius:
                                                                          15,
                                                                      child: Icon(
                                                                          Icons
                                                                              .close),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Form(
                                                                key:
                                                                    _formUpdateKey,
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      TextField(
                                                                        controller:
                                                                            textTitleUpdatedControllers[index],
                                                                        maxLines:
                                                                            2,
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              'Başlık...',
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      TextField(
                                                                        controller:
                                                                            textDescriptionUpdatedControllers[index],
                                                                        maxLines:
                                                                            5,
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              'Açıklama...',
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(primary: ApplicationConstants.lacivert),
                                                                              child: const Text('Güncelle'),
                                                                              onPressed: () async {
                                                                                await updateEvent(index, calendar.reminders[index].reminderId);
                                                                                Navigator.pop(context);
                                                                              },
                                                                            )
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
                                                      });
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: Colors.grey,
                                                )),
                                            IconButton(
                                                onPressed: () async {
                                                  await _showDialog(calendar
                                                      .reminders[index]
                                                      .reminderId);
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
              )
            ],
          ),
        ),
      ));
  Widget buildTitle() => TextFormField(
        style: const TextStyle(fontSize: 16),
        decoration: const InputDecoration(
            border: OutlineInputBorder(), hintText: 'Hatırlatma Başlığı...'),
        onFieldSubmitted: (_) {},
        validator: (title) => title != null && title.isEmpty
            ? 'Hatırlatma başlığı boş bırakılamaz'
            : null,
        controller: titleController,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 4,
        style: const TextStyle(fontSize: 16),
        decoration: const InputDecoration(
            border: OutlineInputBorder(), hintText: 'Açıklama...'),
        onFieldSubmitted: (_) {},
        validator: (title) =>
            title != null && title.isEmpty ? 'Açıklama boş bırakılamaz' : null,
        controller: descriptionController,
      );
  Widget buildDateTimePickers() => Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: buildDropDownField(
                  text: Utils.toDate(remindDate),
                  onClicked: () {
                    debugPrint('clicked');
                    pickFromDateTime(pickDate: true);
                  },
                ),
              ),
              Expanded(
                child: buildDropDownField(
                    text: Utils.toTime(remindDate),
                    onClicked: () => pickFromDateTime(pickDate: false)),
              )
            ],
          ),
        ],
      );
  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(remindDate, pickDate: pickDate);
    if (date == null) return;

    setState(() => remindDate = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);

      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Widget buildDropDownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );
}
