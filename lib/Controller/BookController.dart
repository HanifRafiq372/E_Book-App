import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/Config/Messages.dart';
import 'package:e_book/Models/BookModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:logger/logger.dart';

class BookController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController auth = TextEditingController();
  TextEditingController aboutAuth = TextEditingController();
  TextEditingController pages = TextEditingController();
  TextEditingController audioLen = TextEditingController();
  TextEditingController language = TextEditingController();
  TextEditingController price = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;
  final fAuth = FirebaseAuth.instance;
  RxString imageUrl = "".obs;
  RxString pdfUrl = "".obs;
  int index = 0;
  RxBool isImageUploading = false.obs;
  RxBool isPdfUploading = false.obs;
  RxBool isPostUploading = true.obs;
  var bookData = RxList<BookModel>();
  var currentUserBooks = RxList<BookModel>();

  // Buat objek logger
  var logger = Logger();

  @override
  void onInit() {
    super.onInit();
    getAllBooks();
    getUserBook();  // Pastikan ini dipanggil untuk mengisi currentUserBooks
  }

  void getAllBooks() async {
    bookData.clear();
    successMessage("Book Get Fun");
    var books = await db.collection("Books").get();
    for (var book in books.docs) {
      bookData.add(BookModel.fromJson(book.data()));
    }
  }

  void getUserBook() async {
    currentUserBooks.clear();
    if (fAuth.currentUser != null) {
      var books = await db
          .collection("userBook")
          .doc(fAuth.currentUser!.uid)
          .collection("Books")
          .get();
      for (var book in books.docs) {
        currentUserBooks.add(BookModel.fromJson(book.data()));
      }
    } else {
      logger.w("User not logged in"); // Menggunakan logger
    }
  }

  void pickImage() async {
    isImageUploading.value = true;
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      logger.d(image.path); // Menggunakan logger
      uploadImageToFirebase(File(image.path));
    }
    isImageUploading.value = false;
  }

  void uploadImageToFirebase(File image) async {
    var uuid = const Uuid();
    var filename = uuid.v1();
    var storageRef = storage.ref().child("Images/$filename");
    var response = await storageRef.putFile(image);
    String downloadURL = await storageRef.getDownloadURL();
    imageUrl.value = downloadURL;
    logger.d("Download URL: $downloadURL"); // Menggunakan logger
    isImageUploading.value = false;
  }

  void createBook() async {
    isPostUploading.value = true;
    var newBook = BookModel(
      id: "$index",
      title: title.text,
      description: des.text,
      coverUrl: imageUrl.value,
      bookurl: pdfUrl.value,
      author: auth.text,
      aboutAuthor: aboutAuth.text,
      price: int.parse(price.text),
      pages: int.parse(pages.text),
      language: language.text,
      audioLen: audioLen.text,
      audioUrl: "",
      rating: "",
    );

    await db.collection("Books").add(newBook.toJson());
    addBookInUserDb(newBook);
    isPostUploading.value = false;
    title.clear();
    des.clear();
    aboutAuth.clear();
    pages.clear();
    language.clear();
    audioLen.clear();
    auth.clear();
    price.clear();
    imageUrl.value = "";
    pdfUrl.value = "";
    successMessage("Book added to the db");
    getAllBooks();
    getUserBook();
  }

  void pickPDF() async {
    isPdfUploading.value = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.first.path!);

      if (file.existsSync()) {
        Uint8List fileBytes = await file.readAsBytes();
        String fileName = result.files.first.name;
        logger.d("File Bytes: $fileBytes"); // Menggunakan logger

        final response =
            await storage.ref().child("Pdf/$fileName").putData(fileBytes);

        final downloadURL = await response.ref.getDownloadURL();
        pdfUrl.value = downloadURL;
        logger.i(downloadURL); // Menggunakan logger
      } else {
        logger.e("File does not exist"); // Menggunakan logger
      }
    } else {
      logger.w("No file selected"); // Menggunakan logger
    }
    isPdfUploading.value = false;
  }

  void addBookInUserDb(BookModel book) async {
    if (fAuth.currentUser != null) {
      await db
          .collection("userBook")
          .doc(fAuth.currentUser!.uid)
          .collection("Books")
          .add(book.toJson());
    } else {
      logger.w("User not logged in, cannot add book to user DB"); // Menggunakan logger
    }
  }
}
