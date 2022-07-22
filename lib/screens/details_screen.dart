import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final url =
      '...page=1&title=&authorized=&step=&listType=all&start_date=2022-01-15&end_date=2022-04-15';
  int? counter;
  var denemeResult;
  bool _isLoading = true;
  void _changeLoading() async {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future callDetail() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var token = prefs.getString('token');
    // try {
    //   final response = await http.get(Uri.parse(url), headers: {
    //     'Authorization': 'Bearer $token',
    //   });
    //   debugPrint(response.statusCode.toString());
    //   var result = denemeFromJson(response.body);
    //   debugPrint("RESULTTTTTTT: " + result.record[2].companyTitle.toString());
    //   setState(() {
    //     counter = result.record.length;
    //     denemeResult = result;
    //   });
    //   _changeLoading();
    //   debugPrint("RESULT: " + result.toString());
    //   debugPrint("COUNTER: " + counter.toString());
    //   return result;
    // } catch (e) {
    //   print("HATA: " + e.toString());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF06113C),
          toolbarHeight: 80,
          elevation: 5,
          title: const Center(
              child: Text(
                  'AGG FİNANSAL DANIŞMANLIK OTOMOTİV İNŞAAT TURİZM E-TİCARET İTHALAT İHRACAT SANAYİ VE TİC.LTD.ŞTİ.',
                  maxLines: 20,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center)),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF04d1aa),
                        border: Border.all(
                            color: const Color(0xFF04d1aa), width: 3.0),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5.0),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text('Durum:',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                          const Text('AKTİF',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF06113C),
                        border: Border.all(
                            width: 3.0, color: const Color(0xFF06113C)),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5.0),
                        )),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text('Kurumsal',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
