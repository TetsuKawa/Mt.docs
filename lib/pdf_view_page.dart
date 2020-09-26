import 'dart:typed_data';
import 'package:share/share.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:mtdocs/textform.dart';
import 'add_pdf_page.dart';
import 'db_provider.dart';

class PdfViewPage extends StatefulWidget {
  final String filePath;
  final AllData data;
  final File image;
  final int isNew;
  final int id;

  PdfViewPage({this.filePath,this.data,this.image,this.isNew,this.id}) : super();

  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  AllData emp = AllData();
  List<AllData> dataList;


  List<Widget> actionWidget(int index){
    if(index == 1){
      return <Widget>[
        IconButton(
          icon: Icon(Icons.save_alt),
          onPressed: ()async{
            await DBProvider.insertFileData(emp);
            dataList = await DBProvider.getFileData();
            if(widget.image != null){
              widget.data.path = await FileController.saveLocalImage(widget.image,dataList[dataList.length-1].id.toString());
            }
            await DBProvider.updateFileData(widget.data,dataList[dataList.length-1].id);
            while(Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          },
        ),
      ];
    }
    else if(index == 0){
      return <Widget>[
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () async{
            if(widget.data.file == ""){
              widget.data.file = "notitle";
            }
//            final ByteData bytes = await rootBundle.load(widget.filePath);
////            Uint8List _buffer = await File(widget.filePath).readAsBytes();
//            Share.file(
//                "計画書ファイルを共有",
//                "${widget.filePath}",
//                bytes.buffer.asUint8List(),
//                "image/pdf"
//            );
            final Size size = MediaQuery.of(context).size;
            Share.shareFiles([widget.filePath], text: widget.data.file,subject: '',sharePositionOrigin:  Rect.fromLTWH(0, 0, size.width, size.height / 2));
          },
        ),

        PopupMenuButton<String>(
          onSelected: (value)async{
            switch(value){
              case "1": {
                if(widget.data.path != null){
                  final dir = Directory(widget.data.path);
                  dir.deleteSync(recursive: true);
                }
                await DBProvider.deleteFileData(widget.data.id);
                Navigator.of(context).pop();
              }break;

              case "2":{
                await Navigator.push(context,MaterialPageRoute(builder: (context) => AddPdfPage(isNew:0 ,data: widget.data,)));
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
//          IconButton(
//            icon: Icon(Icons.more_vert),
//            onPressed: ()async{
//              final dir = Directory(widget.data.path);
//              dir.deleteSync(recursive: true);
//              await DBProvider.deleteFileData(widget.data.id);
//              Navigator.of(context).pop();
//            },
//          ),
      ];
    }
    else{
      return <Widget>[

        FlatButton(
          onPressed: ()async{
            if(widget.image != null){
              if(widget.data.path != null){
                File imageFile = File(widget.data.path);
                await imageFile.writeAsBytes(await widget.image.readAsBytes());
              }
              else{
                widget.data.path = await FileController.saveLocalImage(widget.image,widget.data.id.toString());
              }
            }
            else{
              widget.data.path = null;
            }
            await DBProvider.updateFileData(widget.data, widget.id);
            while(Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          },
          child: Text("完了",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.data.file == "" ?  Text("No title") : Text(widget.data.file),
        actions: actionWidget(widget.isNew),
      ),
      body: PDFView(
        fitPolicy: FitPolicy.BOTH,
        swipeHorizontal: true,
        pageSnap: true,
        filePath: widget.filePath,
        onError: (error) {
          print('error: $error');
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
        onPageChanged: (int page, int total) {
          print('page change: $page/$total');
        },
      ),
    );
  }
}

