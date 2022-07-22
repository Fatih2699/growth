import 'package:flutter/material.dart';
import 'package:growth/models/register_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DenemeMusteri extends StatefulWidget {
  const DenemeMusteri({Key? key}) : super(key: key);

  @override
  State<DenemeMusteri> createState() => _DenemeMusteriState();
}

class _DenemeMusteriState extends State<DenemeMusteri> {
  late TextEditingController firmaAdi = TextEditingController();
  late TextEditingController yetkiliKisi = TextEditingController();
  var data;
  int counter = 0;
  bool isLoading = true;
  changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DENEME MÜSTERİ ADI FİLTRELE'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: firmaAdi,
          ),
          TextField(
            controller: yetkiliKisi,
          ),
          ElevatedButton(
            onPressed: () => musteriFiltrele(firmaAdi.text, yetkiliKisi.text),
            child: const Text('ARA'),
          ),
          isLoading
              ? const SingleChildScrollView()
              : ListView.builder(
                  itemCount: counter,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(data.record[index].companyTitle),
                    );
                  },
                )
        ],
      ),
    );
  }

  Future musteriFiltrele(String? title, String? authorized) async {
    String url = Uri.encodeFull('...title=$title&authorized=$authorized');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      // return debugPrint(url);
      var result = registerFromJson(response.body);
      setState(() {
        data = result;
        counter = result.record.length;
      });
      changeLoading();
      return result;
    } catch (e) {
      debugPrint('HATA VAR:' + e.toString());
    }
  }
}
