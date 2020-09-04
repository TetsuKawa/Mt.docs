import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mtdocs/pdf_view_page.dart';
import 'package:mtdocs/textform.dart';

import 'add_pdf_page.dart';
import 'create_pdf.dart';
import 'db_provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Climb Doc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'HOME'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale("ja"),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  List<AllData> fileList = [];
  static List<Card> _cardList = [];

  Future<void> setDb() async{
    await DBProvider.setDb();
    fileList = await DBProvider.getFileData();
    _cardList = [];
    for(int i = 0; i < fileList.length; i++){
      _cardList.add(
          Card(
            child: ListTile(
              leading: Icon(Icons.insert_drive_file),
              title: fileList[i].file == "" ? Text("No title") : Text(fileList[i].file),
              subtitle: Text(fileList[i].date),
              trailing: PopupMenuButton<String>(
                onSelected: (value)async{
                  switch(value){
                    case "1": {
                      if(fileList[i].path != null){
                        final dir = Directory(fileList[i].path);
                        dir.deleteSync(recursive: true);
                      }
                      await DBProvider.deleteFileData(fileList[i].id);
                      setDb();
                    }break;

                    case "2":{
                      await Navigator.push(context,MaterialPageRoute(builder: (context) => AddPdfPage(isNew:0 ,data: fileList[i])));
                    }
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: "1",
                    child: Text('削除'),
                  ),
                  const PopupMenuItem<String>(
                    value: "2",
                    child: Text('編集'),
                  ),
                ],
              ),
              onTap: ()async{
                String _filePath = await CreatePdf.createPdfA4(allData:fileList[i],isNew: 0);
                print(_filePath);
                await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => PdfViewPage(filePath: _filePath,data: fileList[i],isNew: 0)));
                setDb();
              },
            ),
          )
      );
    }
    setState((){
    });
  }

  @override
  void initState() {
    setDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: _cardList.length != 0 ?ListView.builder(
          itemCount: _cardList.length,
          itemBuilder: (BuildContext context, int index) {
            return _cardList[index];

          },
        )
            : Center(
          child: Text("＋ボタンからファイル作成",style: TextStyle(fontSize: 20,color: Colors.black54),),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await Navigator.push(context,MaterialPageRoute(builder: (context) => AddPdfPage(isNew:1)));
          await setDb();
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
