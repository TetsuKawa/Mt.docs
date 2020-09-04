import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:mtdocs/textform.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class CreatePdf{
  static Future<String> createPdfA4({AllData allData,File image,int isNew}) async {
    final Document pdf = Document();

    Future<dynamic> getFontData() async {
      final ByteData bytes = await rootBundle.load('assets/fonts/ipaexm.ttf');
      final Uint8List fontData = bytes.buffer.asUint8List();

      return Font.ttf(fontData.buffer.asByteData());
    }
    DateTime now = DateTime.now();
    var font = await getFontData();

    if(allData.firstAddress1==null) allData.firstAddress1 = "";
    if(allData.firstAddress2==null) allData.firstAddress2 = "";
    if(allData.firstAddress3==null) allData.firstAddress3 = "";
    if(allData.emergeAddress1==null) allData.emergeAddress1 = "";
    if(allData.emergeAddress2==null) allData.emergeAddress2 = "";
    if(allData.emergeAddress3==null) allData.emergeAddress3 = "";
    if(allData.id1Address1==null) allData.id1Address1 = "";
    if(allData.id1Address2==null) allData.id1Address2 = "";
    if(allData.id1Address3==null) allData.id1Address3 = "";
    if(allData.id2Address1==null) allData.id2Address1 = "";
    if(allData.id2Address2==null) allData.id2Address2 = "";
    if(allData.id2Address3==null) allData.id2Address3 = "";
    if(allData.id3Address1==null) allData.id3Address1 = "";
    if(allData.id3Address2==null) allData.id3Address2 = "";
    if(allData.id3Address3==null) allData.id3Address3 = "";
    if(allData.id4Address1==null) allData.id4Address1 = "";
    if(allData.id4Address2==null) allData.id4Address2 = "";
    if(allData.id4Address3==null) allData.id4Address3 = "";
    if(allData.id5Address1==null) allData.id5Address1 = "";
    if(allData.id5Address2==null) allData.id5Address2 = "";
    if(allData.id5Address3==null) allData.id5Address3 = "";

    Widget checkItem(bool check, String item,double num){
      return Row(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(left: 0* PdfPageFormat.mm),
                margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                width: 15,
                height: 15,
                child: Center(child: check ? Text("■", style: TextStyle(font: font,fontSize: 10)) : Text("□", style: TextStyle(font: font,fontSize: 10))),
                decoration: const BoxDecoration(
                    border:
                    BoxBorder(bottom: false ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))
            ),

            Container(
                padding: const EdgeInsets.only(left: 0 * PdfPageFormat.mm,top: 0.8 * PdfPageFormat.mm),
                margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                width: num * 15,
                height: 15,
                child: Text(item, style: TextStyle(font: font,fontSize: 10)),
                decoration: const BoxDecoration(
                    border:
                    BoxBorder(bottom: false ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))
            ),
          ]
      );
    }

    Widget actionSpace(String date,String action){
      return Row(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                width: 40,
                height: 15,
                child: Center(child: date == null ? Text("") : Text(date, style: TextStyle(font: font,fontSize: 10)),),
                decoration: const BoxDecoration(
                    border:
                    BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
            Container(
                margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                padding: const EdgeInsets.only(left: 2 * PdfPageFormat.mm,top: 0.8 * PdfPageFormat.mm),
                width: 495,
                height: 15,
                child: action == null ? Text("") : Text(action, style: TextStyle(font: font,fontSize: 10)),
                decoration: const BoxDecoration(
                    border:
                    BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
          ]
      );
    }

    Widget idInformation(String role,String nameH,String name,String sex,String age,String date,String blood,String address1,
        String address2,String address3,String address4,String houseTel,String selTel,String emergeName,String emergeTel){
      if (sex == null) sex = "";
      if(age == null) age = "  ";
      if(houseTel == null) houseTel ="           ";
      if(selTel == null) selTel = "           ";


      return Row(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                width: 30,
                height: 45,
                child: Center(child: role == null ? Text("") : Text(role, style: TextStyle(font: font,fontSize: 10)),),
                decoration: const BoxDecoration(
                    border:
                    BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
            Column(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                      width: 125,
                      height: 15,
                      child: Center(child: nameH == null ? Text("") : Text(nameH, style: TextStyle(font: font,fontSize: 10)),),
                      decoration: const BoxDecoration(
                          border:
                          BoxBorder(bottom: false ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                  Container(
                      margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                      width: 125,
                      height: 30,
                      child: Center(child: name == null ? Text("") : Text(name, style: TextStyle(font: font,fontSize: 20)),),
                      decoration: const BoxDecoration(
                          border:
                          BoxBorder(bottom: true ,top: false,right: true,left: true, width: 0.5, color: PdfColors.black))),
                ]
            ),
            Column(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                      padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                      width: 85,
                      height: 22,
                      child: Center(child: Text(sex + " / 満" + age + "歳", style: TextStyle(font: font,fontSize: 10)),),
                      decoration: const BoxDecoration(
                          border:
                          BoxBorder(bottom: false ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                  Container(
                      margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                      padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                      width: 85,
                      height: 23,
                      child: Center(child: date == null ? Text("") : Text(date, style: TextStyle(font: font,fontSize: 10)),),
                      decoration: const BoxDecoration(
                          border:
                          BoxBorder(bottom: true ,top: false,right: true,left: true, width: 0.5, color: PdfColors.black))),
                ]
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                width: 35,
                height: 45,
                child: Center(child: blood == null ? Text("") : Text(blood, style: TextStyle(font: font,fontSize: 10)),),
                decoration: const BoxDecoration(
                    border:
                    BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
            Column(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                      padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                      width: 180,
                      height: 15,
                      child: Center(child: address1 == null && address2 == null && address3 == null ? Text("")
                          : Text(address1+address2+address3, style: TextStyle(font: font,fontSize: 10)),),
                      decoration: const BoxDecoration(
                          border:
                          BoxBorder(bottom: false ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                  Container(
                      margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                      padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                      width: 180,
                      height: 15,
                      child: Center(child: address4 == null ? Text("") :Text(address4, style: TextStyle(font: font,fontSize: 10)),),
                      decoration: const BoxDecoration(
                          border:
                          BoxBorder(bottom: true ,top: false,right: true,left: true, width: 0.5, color: PdfColors.black))),
                  Container(
                      margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                      padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                      width: 180,
                      height: 15,
                      child: Center(child: Text(houseTel+" / ("+selTel+")", style: TextStyle(font: font,fontSize: 10)),),
                      decoration: const BoxDecoration(
                          border:
                          BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                ]
            ),
            Column(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                      padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                      width: 80,
                      height: 22,
                      child: Center(child: emergeName == null ? Text("") :Text(emergeName, style: TextStyle(font: font,fontSize: 10)),),
                      decoration: const BoxDecoration(
                          border:
                          BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                  Container(
                      margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                      padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                      width: 80,
                      height: 23,
                      child: Center(child: emergeTel == null ? Text("") :Text(emergeTel, style: TextStyle(font: font,fontSize: 10)),),
                      decoration: const BoxDecoration(
                          border:
                          BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                ]
            ),
          ]
      );
    }

    List<Widget> others(String a){
      List<Widget> list = [];
      for(int i = 0; i < a.length; i++){
        list.add(Text(a[i], style: TextStyle(font: font,fontSize: 10))
        );
      }
      return list;
    }

    pdf.addPage(
      MultiPage(
        margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.portrait,
        header: (Context context) {
          if (context.pageNumber == 1) {
            return
              Row(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                        padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                        width: 150,
                        height: 15,
                        child: allData.head == null ? Text("") : Text(allData.head, style: TextStyle(font: font,fontSize: 10)),
                        decoration: const BoxDecoration(
                            border:
                            BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
                    Container(
                        margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                        padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                        width: 30,
                        height: 15,
                        child: Text("御中", style: TextStyle(font: font,fontSize: 10)),
                        decoration: const BoxDecoration(
                            border:
                            BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
                    Container(
                      margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                      padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                      width: 150,
                      height: 15,
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                        padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                        width: 60,
                        height: 15,
                        child: Text("提出日", style: TextStyle(font: font,fontSize: 10)),
                        decoration: const BoxDecoration(
                            border:
                            BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
                    Container(
                        margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                        padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                        width: 100,
                        height: 15,
                        child: allData.firstDate == null ? Text("") : Text(allData.firstDate, style: TextStyle(font: font,fontSize: 10)),
                        decoration: const BoxDecoration(
                            border:
                            BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
                  ]
              );
          }
          else{
            return Container();
          }
        },
        build: (Context context) => <Widget>[
          Padding(padding: EdgeInsets.all(15)),
          Center(
              child: Container(
                child: Text("登山計画書", style: TextStyle(font: font,fontSize: 30)),
              )
          ),
          Padding(padding: EdgeInsets.all(10)),
          Row(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 50,
                    height: 15,
                    child: Text("所属", style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 200,
                    height: 15,
                    child: allData.belongs == null ? Text("") : Text(allData.belongs, style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
                Container(
                  margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                  padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                  width: 30,
                  height: 15,
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 60,
                    height: 15,
                    child: Text("緊急連絡先", style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 190,
                    height: 15,
                    child: Text("", style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
              ]
          ),

          Row(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 50,
                    height: 15,
                    child: Text("団体名", style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 200,
                    height: 15,
                    child: allData.groupName == null ? Text("") : Text(allData.groupName, style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                  padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                  width: 30,
                  height: 15,
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 50,
                    height: 15,
                    child: Text("氏名", style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 200,
                    height: 15,
                    child: allData.emergeName == null ? Text("") : Text(allData.emergeName, style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))
                ),
              ]
          ),

          Row(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 50,
                    height: 15,
                    child: Text("代表者", style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 200,
                    height: 15,
                    child: allData.represent == null ? Text("") : Text(allData.represent, style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
                Container(
                  margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                  padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                  width: 30,
                  height: 15,
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 50,
                    height: 15,
                    child: Text("電話番号", style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 200,
                    height: 15,
                    child: allData.emergeTel == null ? Text("") : Text(allData.emergeTel, style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
              ]
          ),
          Row(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 60,
                    height: 15,
                    child: Text("代表者住所", style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 190,
                    height: 15,
                    child: Expanded(
                      child: allData.firstAddress1 == null ? Text("") : Text(allData.firstAddress1+allData.firstAddress2+allData.firstAddress3, style: TextStyle(font: font,fontSize: 10),softWrap: true),
                    ),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))
                ),

                Container(
                  margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                  padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                  width: 30,
                  height: 15,
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 50,
                    height: 15,
                    child: Text("住所", style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 200,
                    height: 15,
                    child: allData.emergeAddress1 == null ? Text("") : Text(allData.emergeAddress1+allData.emergeAddress2+allData.emergeAddress3, style: TextStyle(font: font,fontSize: 10),softWrap: true),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))
                ),

              ]
          ),
          Row(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 60,
                    height: 15,
                    child: Text("", style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 190,
                    height: 15,
                    child: Expanded(
                      child: allData.firstAddress4 == null ? Text("") : Text(allData.firstAddress4, style: TextStyle(font: font,fontSize: 10),softWrap: true),
                    ),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))
                ),

                Container(
                  margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                  padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                  width: 30,
                  height: 15,
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 50,
                    height: 15,
                    child: Text("", style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 200,
                    height: 15,
                    child: allData.emergeAddress4 == null ? Text("") : Text(allData.emergeAddress4, style: TextStyle(font: font,fontSize: 10),softWrap: true),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))
                ),

              ]
          ),

          Row(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 60,
                    height: 15,
                    child: Text("代表者電話", style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
                Container(
                    margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
                    width: 190,
                    height: 15,
                    child: allData.firstTel == null ? Text("") : Text(allData.firstTel, style: TextStyle(font: font,fontSize: 10)),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
              ]
          ),
          Padding(padding: EdgeInsets.all(10)),
          Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 2 * PdfPageFormat.mm),
                  padding: const EdgeInsets.only(bottom: 2 * PdfPageFormat.mm),
                  width: 535,
                  height: 15,
                  child: Text("現地連絡先", style: TextStyle(font: font,fontSize: 15)),
                ),

                Row(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          width: 200,
                          height: 15,
                          child: Center(child: Text("施設名", style: TextStyle(font: font,fontSize: 10)),),
                          decoration: const BoxDecoration(
                              border:
                              BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                      Container(
                          margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          width: 335,
                          height: 15,
                          child: Center(child: Text("TEL", style: TextStyle(font: font,fontSize: 10)),),
                          decoration: const BoxDecoration(
                              border:
                              BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                    ]
                ),
                Row(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          width: 200,
                          height: 15,
                          child: Center(child: allData.localPoint1 == null ? Text("") : Text(allData.localPoint1, style: TextStyle(font: font,fontSize: 10)),),
                          decoration: const BoxDecoration(
                              border:
                              BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                      Container(
                          margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          width: 335,
                          height: 15,
                          child: Center(child: allData.localTel1 == null ? Text("") :Text(allData.localTel1, style: TextStyle(font: font,fontSize: 10)),),
                          decoration: const BoxDecoration(
                              border:
                              BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                    ]
                ),
                Row(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          width: 200,
                          height: 15,
                          child: Center(child: allData.localPoint2 == null ? Text("") :Text(allData.localTel2, style: TextStyle(font: font,fontSize: 10)),),
                          decoration: const BoxDecoration(
                              border:
                              BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                      Container(
                          margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          width: 335,
                          height: 15,
                          child: Center(child: allData.localTel2 == null ? Text("") : Text(allData.localTel2, style: TextStyle(font: font,fontSize: 10)),),
                          decoration: const BoxDecoration(
                              border:
                              BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                    ]
                ),
                Row(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          width: 200,
                          height: 15,
                          child: Center(child: allData.localPoint3 == null ? Text("") :Text(allData.localPoint3, style: TextStyle(font: font,fontSize: 10)),),
                          decoration: const BoxDecoration(
                              border:
                              BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                      Container(
                          margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          width: 335,
                          height: 15,
                          child: Center(child: allData.localTel3 == null ? Text("") :Text(allData.localTel3, style: TextStyle(font: font,fontSize: 10)),),
                          decoration: const BoxDecoration(
                              border:
                              BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                    ]
                ),
              ]
          ),
          Padding(padding: EdgeInsets.all(10)),
          Container(
            margin: const EdgeInsets.only(bottom: 2 * PdfPageFormat.mm),
            padding: const EdgeInsets.only(bottom: 2 * PdfPageFormat.mm),
            width: 535,
            height: 15,
            child: Text("パーティーメンバー情報", style: TextStyle(font: font,fontSize: 15)),
          ),
          Row(
              children: <Widget>[

                Container(
                    margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    width: 30,
                    height: 15,
                    child: Center(child: Text("役割", style: TextStyle(font: font,fontSize: 10)),),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                Container(
                    margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    width: 125,
                    height: 15,
                    child: Center(child: Text("氏名", style: TextStyle(font: font,fontSize: 10)),),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                Container(

                    margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    width: 85,
                    height: 15,
                    child: Center(child: Text("性別/生年月日", style: TextStyle(font: font,fontSize: 10)),),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                Container(
                    margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    width: 35,
                    height: 15,
                    child: Center(child: Text("血液型", style: TextStyle(font: font,fontSize: 10)),),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                Container(
                    margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    width: 180,
                    height: 15,
                    child: Center(child: Text("現住所", style: TextStyle(font: font,fontSize: 10)),),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                Container(
                    margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    width: 80,
                    height: 15,
                    child: Center(child: Text("緊急連絡先", style: TextStyle(font: font,fontSize: 10)),),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
              ]
          ),
          idInformation(allData.id1Role,allData.id1NameH,allData.id1Name,allData.id1Sex,allData.id1Age,allData.id1Birth,allData.id1Blood,allData.id1Address1,allData.id1Address2,
              allData.id1Address3,allData.id1Address4,allData.id1HouseTel,allData.id1SelTel,allData.id1EmergeName,allData.id1EmergeTel),
          idInformation(allData.id2Role,allData.id2NameH,allData.id2Name,allData.id2Sex,allData.id2Age,allData.id2Birth,allData.id2Blood,allData.id2Address1,allData.id2Address2,
              allData.id2Address3,allData.id2Address4,allData.id2HouseTel,allData.id2SelTel,allData.id2EmergeName,allData.id2EmergeTel),
          idInformation(allData.id3Role,allData.id3NameH,allData.id3Name,allData.id3Sex,allData.id3Age,allData.id3Birth,allData.id3Blood,allData.id3Address1,allData.id3Address2,
              allData.id3Address3,allData.id3Address4,allData.id3HouseTel,allData.id3SelTel,allData.id3EmergeName,allData.id3EmergeTel),
          idInformation(allData.id4Role,allData.id4NameH,allData.id4Name,allData.id4Sex,allData.id4Age,allData.id4Birth,allData.id4Blood,allData.id4Address1,allData.id4Address2,
              allData.id4Address3,allData.id4Address4,allData.id4HouseTel,allData.id4SelTel,allData.id4EmergeName,allData.id4EmergeTel),
          idInformation(allData.id5Role,allData.id5NameH,allData.id5Name,allData.id5Sex,allData.id5Age,allData.id5Birth,allData.id5Blood,allData.id5Address1,allData.id5Address2,
              allData.id5Address3,allData.id5Address4,allData.id5HouseTel,allData.id5SelTel,allData.id5EmergeName,allData.id5EmergeTel),
          Padding(padding: EdgeInsets.all(10)),
          Container(
            margin: const EdgeInsets.only(bottom: 2 * PdfPageFormat.mm),
            padding: const EdgeInsets.only(bottom: 2 * PdfPageFormat.mm),
            width: 535,
            height: 15,
            child: Text("行動予定", style: TextStyle(font: font,fontSize: 15)),
          ),
          Row(
              children: <Widget>[

                Container(
                    margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    width: 70,
                    height: 15,
                    child: Center(child: Text("山(域)名", style: TextStyle(font: font,fontSize: 10)),),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                Container(
                    margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    width: 198,
                    height: 15,
                    child: Center(child:allData.destination == null ? Text("") : Text(allData.destination, style: TextStyle(font: font,fontSize: 10)),),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                Container(

                    margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    width: 70,
                    height: 15,
                    child: Center(child: Text("登山方法", style: TextStyle(font: font,fontSize: 10)),),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                Container(
                    margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    width: 197,
                    height: 15,
                    child: Center(child: allData.method == null ? Text("") : Text(allData.method, style: TextStyle(font: font,fontSize: 10)),),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
              ]
          ),
          Row(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    width: 70,
                    height: 15,
                    child: Center(child: Text("登山開始日時", style: TextStyle(font: font,fontSize: 10)),),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                Container(
                    margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    width: 198,
                    height: 15,
                    child: Center(
                      child: Row(children:<Widget>[
                        Container(

                          margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          width: 70,
                          height: 15,
                          child: Center(child: allData.start == null ? Container() : Text(allData.start, style: TextStyle(font: font,fontSize: 10)),),
                        ),
                        Container(

                          margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          width: 70,
                          height: 15,
                          child: Center(child: allData.sTime == null ? Container() : Text(allData.sTime, style: TextStyle(font: font,fontSize: 10)),),
                        ),
                      ]),
                    ),

                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                Container(

                    margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    width: 70,
                    height: 15,
                    child: Center(child: Text("下山予定日時", style: TextStyle(font: font,fontSize: 10)),),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                Container(
                    margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                    width: 197,
                    height: 15,
                    child: Center(
                      child: Row(children:<Widget>[
                        Container(

                          margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          width: 70,
                          height: 15,
                          child: Center(child: allData.finish == null ? Container() : Text(allData.finish, style: TextStyle(font: font,fontSize: 10)),),
                        ),
                        Container(

                          margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          padding: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          width: 70,
                          height: 15,
                          child: Center(child: allData.fTime == null ? Container() : Text(allData.fTime, style: TextStyle(font: font,fontSize: 10)),),
                        ),
                      ]),
                    ),
                    decoration: const BoxDecoration(
                        border:
                        BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
              ]
          ),
          Padding(padding: EdgeInsets.all(5)),
          Column(
              children: <Widget>[
                Row(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          width: 40,
                          height: 15,
                          child: Center(child: Text("月日", style: TextStyle(font: font,fontSize: 10)),),
                          decoration: const BoxDecoration(
                              border:
                              BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                      Container(
                          margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                          width: 495,
                          height: 15,
                          child: Center(child: Text("予定", style: TextStyle(font: font,fontSize: 10)),),
                          decoration: const BoxDecoration(
                              border:
                              BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))),
                    ]
                ),
                actionSpace(allData.date1, allData.action1),
                actionSpace(allData.date2, allData.action2),
                actionSpace(allData.date3, allData.action3),
                actionSpace(allData.date4, allData.action4),
                actionSpace(allData.date5, allData.action5),
                actionSpace(allData.date6, allData.action6),
              ]
          ),
          Column(
            children: <Widget> [
              Container(
                margin: const EdgeInsets.only(bottom: 2 * PdfPageFormat.mm),
                padding: const EdgeInsets.only(bottom: 2 * PdfPageFormat.mm),
                width: 535,
                height: 15,
                child: Text("概念図", style: TextStyle(font: font,fontSize: 15)),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                  width: 535,
                  height: 350,
                  child: isNew == 1 ? (image == null ? Container() : Image(PdfImage.file(
                      pdf.document,
                      bytes: image.readAsBytesSync()),
                      width: 530,height: 340
                  )) : isNew == 0 ? allData.path == null ? Container() : Image(PdfImage.file(pdf.document, bytes: File(allData.path).readAsBytesSync()),width: 530,height: 340)
                      : (image == null ? Container() : Image(PdfImage.file(pdf.document,bytes: image.readAsBytesSync()),width: 530,height: 340)),
                  decoration: const BoxDecoration(
                      border:
                      BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))
              ),
              Container(
                  padding: const EdgeInsets.only(top: 1 * PdfPageFormat.mm,left: 1 * PdfPageFormat.mm),
                  margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                  width: 535,
                  height: 15,
                  child: Text("荒天時エスケープルート／その他：", style: TextStyle(font: font,fontSize: 10)),
                  decoration: const BoxDecoration(
                      border:
                      BoxBorder(bottom: false ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))
              ),
              Container(
                  padding: const EdgeInsets.only(top: 1 * PdfPageFormat.mm,left: 1 * PdfPageFormat.mm,right: 1 * PdfPageFormat.mm),
                  margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                  width: 535,
                  height: 45,
                  child: Wrap(
                    children: allData.other1 == null ? <Widget>[Container()] : others(allData.other1),

                  ),
                  decoration: const BoxDecoration(
                      border:
                      BoxBorder(bottom: true ,top: false,right: true,left: true, width: 0.5, color: PdfColors.black))
              ),

            ],
          ),
          Padding(padding: EdgeInsets.all(5)),
          Column(
            children: <Widget> [
              Container(
                margin: const EdgeInsets.only(bottom: 2 * PdfPageFormat.mm),
                padding: const EdgeInsets.only(bottom: 2 * PdfPageFormat.mm),
                width: 535,
                height: 15,
                child: Text("装備", style: TextStyle(font: font,fontSize: 15)),
              ),
              Row(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                        width: 50,
                        height: 150,
                        child: Center(child: Text("個人装備", style: TextStyle(font: font,fontSize: 10)),),
                        decoration: const BoxDecoration(
                            border:
                            BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))
                    ),
                    Column(
                        children:<Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                            width: 485,
                            height: 15,
                            decoration: const BoxDecoration(
                                border:
                                BoxBorder(bottom: false ,top: true,right: true,left: false, width: 0.5, color: PdfColors.black)),
                            child: Row(
                                children: <Widget>[
                                  checkItem(allData.zack, "ザック",3),
                                  checkItem(allData.shoes, "靴",2),
                                  checkItem(allData.rainWear, "雨具",3),
                                  checkItem(allData.sleepBag, "シュラフ",4),
                                  checkItem(allData.headLmp, "ヘッドランプ",5),
                                  checkItem(allData.light, "懐中電灯",4),
                                  checkItem(allData.battery, "予備電池",4),
                                ]
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                            width: 485,
                            height: 15,
                            decoration: const BoxDecoration(
                                border:
                                BoxBorder(bottom: false ,top: false,right: true,left: false, width: 0.5, color: PdfColors.black)),
                            child: Row(
                                children: <Widget>[
                                  checkItem(allData.compass, "コンパス",3),
                                  checkItem(allData.planDoc, "計画書",3),
                                  checkItem(allData.selPhone, "携帯電話",4),
                                  checkItem(allData.lighter, "ライター",4),
                                  checkItem(allData.zackCover, "ザックカバー",5),
                                  checkItem(allData.sleepBagCover, "シュラフカバー",5),
                                ]
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                            width: 485,
                            height: 15,
                            decoration: const BoxDecoration(
                                border:
                                BoxBorder(bottom: false ,top: false,right: true,left: false, width: 0.5, color: PdfColors.black)),
                            child: Row(
                                children: <Widget>[
                                  checkItem(allData.helmet, "ヘルメット",4),
                                  checkItem(allData.crampons, "アイゼン",3),
                                  checkItem(allData.iceAx, "ピッケル",3),
                                  checkItem(allData.snack, "行動食",3),
                                  checkItem(allData.mask, "マスク",3),
                                  checkItem(allData.alMeter, "高度計",3),
                                  checkItem(allData.tissue, "ティッシュ",3),
                                ]
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                            width: 485,
                            height: 15,
                            decoration: const BoxDecoration(
                                border:
                                BoxBorder(bottom: false ,top: false,right: true,left: false, width: 0.5, color: PdfColors.black)),
                            child: Row(
                                children: <Widget>[
                                  checkItem(allData.map, "地図",2),
                                  checkItem(allData.winterClothes, "防寒着",3),
                                  checkItem(allData.medicalCase, "医療品",3),
                                  checkItem(allData.towel, "タオル",3),
                                  checkItem(allData.stick, "トレッキングポール",7),
                                  checkItem(allData.knife, "ナイフ",3),
                                  checkItem(allData.thermometer, "温度計",3),
                                ]
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                            width: 485,
                            height: 15,
                            decoration: const BoxDecoration(
                                border:
                                BoxBorder(bottom: false ,top: false,right: true,left: false, width: 0.5, color: PdfColors.black)),
                            child: Row(
                                children: <Widget>[
                                  checkItem(allData.changeClothes, "着替え",3),
                                  checkItem(allData.gloves, "手袋",2),
                                  checkItem(allData.workGloves, "軍手",2),
                                  checkItem(allData.cap, "帽子",3),
                                  checkItem(allData.rainSpats, "レインスパッツ",6),
                                  checkItem(allData.insects, "虫除け",3),
                                  checkItem(allData.copy, "保険証コピー",6),
                                ]
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                            width: 485,
                            height: 15,
                            decoration: const BoxDecoration(
                                border:
                                BoxBorder(bottom: false ,top: false,right: true,left: false, width: 0.5, color: PdfColors.black)),
                            child: Row(
                                children: <Widget>[
                                  checkItem(allData.food, "食糧",2),
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                                      width: 50,
                                      height: 15,
                                      child: allData.num1 == null ?  Text("(   食分)", style: TextStyle(font: font,fontSize: 10))
                                          : Center(child: Text("("+"${allData.num1} 食分)", style: TextStyle(font: font,fontSize: 10)),),
                                      decoration: const BoxDecoration(
                                          border:
                                          BoxBorder(bottom: false ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
                                  checkItem(allData.subFood, "予備食",3),
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                                      width: 45,
                                      height: 15,
                                      child: allData.num2 == null ?  Text("(   食分)", style: TextStyle(font: font,fontSize: 10))
                                          : Center(child: Text("("+"${allData.num2} 食分)", style: TextStyle(font: font,fontSize: 10)),),
                                      decoration: const BoxDecoration(
                                          border:
                                          BoxBorder(bottom: false ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
                                  checkItem(allData.emergeFood, "非常食",3),
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                                      width: 45,
                                      height: 15,
                                      child: allData.cal == null ?  Text("(   kcal)", style: TextStyle(font: font,fontSize: 10))
                                          : Center(child: Text("("+"${allData.cal} kcal)", style: TextStyle(font: font,fontSize: 10)),),
                                      decoration: const BoxDecoration(
                                          border:
                                          BoxBorder(bottom: false ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
                                  checkItem(allData.water, "水",1),
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                                      width: 45,
                                      height: 15,
                                      child: allData.amount == null ?  Text("(   L)", style: TextStyle(font: font,fontSize: 10))
                                          : Center(child: Text("("+"${allData.amount} L)", style: TextStyle(font: font,fontSize: 10)),),
                                      decoration: const BoxDecoration(
                                          border:
                                          BoxBorder(bottom: false ,top: false,right: false,left: false, width: 0.5, color: PdfColors.black))),
                                ]
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.only(top: 1 * PdfPageFormat.mm,left: 1 * PdfPageFormat.mm),
                              margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                              width: 485,
                              height: 15,
                              child: Text("その他：", style: TextStyle(font: font,fontSize: 10)),
                              decoration: const BoxDecoration(
                                  border:
                                  BoxBorder(bottom: false ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))
                          ),
                          Container(
                              padding: const EdgeInsets.only(top: 1 * PdfPageFormat.mm,left: 1 * PdfPageFormat.mm),
                              margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                              width: 485,
                              height: 45,
                              child: Wrap(
                                children: allData.perOther == null ? <Widget>[Container()] : others(allData.perOther),
                              ),
                              decoration: const BoxDecoration(
                                  border:
                                  BoxBorder(bottom: false ,top: false,right: true,left: true, width: 0.5, color: PdfColors.black))
                          ),
                        ]
                    ),
                  ]
              ),
              Row(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                        width: 50,
                        height: 90,
                        child: Center(child: Text("共同装備", style: TextStyle(font: font,fontSize: 10)),),
                        decoration: const BoxDecoration(
                            border:
                            BoxBorder(bottom: true ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))
                    ),
                    Column(
                        children:<Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                            width: 485,
                            height: 15,
                            decoration: const BoxDecoration(
                                border:
                                BoxBorder(bottom: false ,top: true,right: true,left: false, width: 0.5, color: PdfColors.black)),
                            child: Row(
                                children: <Widget>[
                                  checkItem(allData.tent, "テント",3),
                                  checkItem(allData.hob, "コンロ",3),
                                  checkItem(allData.gas, "ガス缶",3),
                                  checkItem(allData.subGas, "ガス管予備",4),
                                  checkItem(allData.rope, "ロープ",3),
                                  checkItem(allData.celtic, "ツェルト",3),
                                  checkItem(allData.mat, "マット",3),
                                ]
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                            width: 485,
                            height: 15,
                            decoration: const BoxDecoration(
                                border:
                                BoxBorder(bottom: false ,top: false,right: true,left: false, width: 0.5, color: PdfColors.black)),
                            child: Row(
                                children: <Widget>[
                                  checkItem(allData.cup, "コッヘル",3),
                                  checkItem(allData.cook, "調理器具",4),
                                ]
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.only(top: 1 * PdfPageFormat.mm,left: 1 * PdfPageFormat.mm),
                              margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                              width: 485,
                              height: 15,
                              child: Text("その他：", style: TextStyle(font: font,fontSize: 10)),
                              decoration: const BoxDecoration(
                                  border:
                                  BoxBorder(bottom: false ,top: true,right: true,left: true, width: 0.5, color: PdfColors.black))
                          ),
                          Container(
                              padding: const EdgeInsets.only(top: 1 * PdfPageFormat.mm,left: 1 * PdfPageFormat.mm),
                              margin: const EdgeInsets.only(bottom: 0 * PdfPageFormat.mm),
                              width: 485,
                              height: 45,
                              child: Wrap(
                                children: allData.joinOther == null ? <Widget>[Container()] : others(allData.joinOther),
                              ),
                              decoration: const BoxDecoration(
                                  border:
                                  BoxBorder(bottom: true ,top: false,right: true,left: true, width: 0.5, color: PdfColors.black))
                          ),
                        ]
                    ),
                  ]
              ),
            ],
          ),
        ],
      ),
    );


    Directory _temporaryDirectory = await getTemporaryDirectory();
    String temporaryDirectoryPath = _temporaryDirectory.path;
    String _filePath = '$temporaryDirectoryPath/resume.pdf';

    List<int> _pdfSaveData = pdf.save();
    File _file = File(_filePath);
    await _file.writeAsBytes(_pdfSaveData);

    return _filePath;
  }
}
