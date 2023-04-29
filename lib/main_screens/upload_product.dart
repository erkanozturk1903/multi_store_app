// ignore_for_file: avoid_print, prefer_final_fields, unused_field, sort_child_properties_last, depend_on_referenced_packages

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:multi_store_app/widgets/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late double price;
  late int quantity;
  late String proName;
  late String proDesc;
  late String proId;
  String mainCategValue = 'Erkek';
  String subCategValue = 'Gömlek';
  List<String> subCategList = [];
  bool processing = false;

  final ImagePicker _picker = ImagePicker();

  List<XFile>? imagesFileList = [];
  List<String> imagesUrlList = [];
  dynamic _pickedImageError;

  void pickProductImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 95,
      );
      setState(() {
        imagesFileList = pickedImages;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  Widget previewImages() {
    if (imagesFileList!.isNotEmpty) {
      return ListView.builder(
        itemCount: imagesFileList!.length,
        itemBuilder: (context, index) {
          return Image.file(
            File(imagesFileList![index].path),
          );
        },
      );
    } else {
      return const Center(
        child: Text(
          'Henüz Resim Seçilmedi..!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    }
  }

  void selectedMainCateg(String? value) {
    if (value == 'select category') {
      subCategList = [];
    } else if (value == 'Erkek') {
      subCategList = men;
    } else if (value == 'Kadın') {
      subCategList = women;
    } else if (value == 'Elektronik') {
      subCategList = electronics;
    } else if (value == 'Aksesuar') {
      subCategList = accessories;
    } else if (value == 'Ayakkabı') {
      subCategList = shoes;
    } else if (value == 'Ev & Bahçe') {
      subCategList = homeandgarden;
    } else if (value == 'Makyaj') {
      subCategList = beauty;
    } else if (value == 'Çocuk') {
      subCategList = kids;
    } else if (value == 'Çanta') {
      subCategList = bags;
    }
    print(value);
    setState(() {
      mainCategValue = value!;
      subCategValue = 'subcategory';
    });
  }

  Future<void> uploadImages() async {
    if (mainCategValue != 'select category' && subCategValue != 'subcategory') {
      if (_fromKey.currentState!.validate()) {
        _fromKey.currentState!.save();
        if (imagesFileList!.isNotEmpty) {
          setState(() {
            processing = true;
          });
          try {
            for (var image in imagesFileList!) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref('products/${path.basename(image.path)}');

              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  imagesUrlList.add(value);
                });
              });
            }
          } catch (e) {
            print(e);
          }
        } else {
          MyMessageHandler.showSnackBar(_scaffoldKey, 'Lütfen resim seçiniz.');
        }
      } else {
        MyMessageHandler.showSnackBar(
            _scaffoldKey, 'Lütfen tüm alanları doldurunuz.');
      }
    } else {
      MyMessageHandler.showSnackBar(_scaffoldKey, 'Lütfen kategori seçiniz.');
    }
  }

  void uploadData() async {
    if (imagesUrlList.isNotEmpty) {
      CollectionReference productRef =
          FirebaseFirestore.instance.collection('products');

      proId = const Uuid().v4();

      await productRef.doc(proId).set({
        'proid': proId,
        'maincateg': mainCategValue,
        'subcateg': subCategValue,
        'price': price,
        'instock': quantity,
        'proname': proName,
        'prodesc': proDesc,
        'sid': FirebaseAuth.instance.currentUser!.uid,
        'proimages': imagesUrlList,
        'discount': 0,
      }).whenComplete(() {
        setState(() {
          processing = false;
          imagesFileList = [];
          mainCategValue = 'select category';
          subCategList = [];
          imagesUrlList = [];
        });
        _fromKey.currentState!.reset();
      });
    }
  }

  void uploadProduct() async {
    await uploadImages().whenComplete(
      () => uploadData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _fromKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        color: Colors.blueGrey.shade100,
                        height: size.width * 0.5,
                        width: size.width * 0.5,
                        child: imagesFileList != null
                            ? previewImages()
                            : const Center(
                                child: Text(
                                  'Henüz Resim Seçilmedi..!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: size.width * 0.5,
                        width: size.width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  '* Ana Kategori Seç',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                DropdownButton(
                                  iconSize: 40,
                                  iconEnabledColor: Colors.red,
                                  dropdownColor: Colors.yellow.shade400,
                                  value: mainCategValue,
                                  items: maincateg
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    selectedMainCateg(value);
                                  },
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  '* Alt Kategori Seç',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                DropdownButton(
                                  iconSize: 40,
                                  iconEnabledColor: Colors.red,
                                  iconDisabledColor: Colors.black,
                                  dropdownColor: Colors.yellow.shade400,
                                  disabledHint: const Text('select category'),
                                  value: subCategValue,
                                  items: subCategList
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    print(value);
                                    setState(() {
                                      subCategValue = value!;
                                    });
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.yellow,
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.38,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Lütfen Ürünün Fiyatını Giriniz';
                          } else if (value.isValidPrice() != true) {
                            return 'geçerli olmayan fiyat girdiniz';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          price = double.parse(value!);
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Fiyat',
                          hintText: 'Ürünün Fiyatı TL',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Lütfen Ürünün Adedini Giriniz';
                          } else if (value.isValidQuantity() != true) {
                            return 'geçerli olmayan adet girdiniz';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          quantity = int.parse(value!);
                        },
                        keyboardType: TextInputType.number,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Adet',
                          hintText: 'Ürün Adedi Ekle',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Lütfen Ürünün Adını Giriniz';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          proName = value!;
                        },
                        maxLength: 100,
                        maxLines: 3,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Ürün Adı',
                          hintText: 'Ürünün Adını Giriniz ',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Lütfen Ürünün Açıklamasını Giriniz';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          proDesc = value!;
                        },
                        maxLength: 800,
                        maxLines: 5,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Ürün Açıklaması',
                          hintText: 'Ürünün Açıklamasını Giriniz',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FloatingActionButton(
                onPressed: imagesFileList!.isEmpty
                    ? () {
                        pickProductImages();
                      }
                    : () {
                        setState(() {
                          imagesFileList = [];
                        });
                      },
                backgroundColor: Colors.yellow,
                child: imagesFileList!.isEmpty
                    ? const Icon(
                        Icons.photo_library,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      ),
              ),
            ),
            FloatingActionButton(
              onPressed: processing == true
                  ? null
                  : () {
                      uploadProduct();
                    },
              backgroundColor: Colors.yellow,
              child: processing == true
                  ? const CircularProgressIndicator(
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.upload,
                      color: Colors.black,
                    ),
            )
          ],
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'Fiyat',
  hintText: 'Ürünün Fiyatı TL',
  labelStyle: const TextStyle(color: Colors.purple),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.yellow,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.blueAccent,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
);

extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceQalidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0][\.]*))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}
