import 'package:e_book/Components/BookCard.dart';
import 'package:e_book/Components/BookTile.dart';
import 'package:e_book/Components/MyDrawer.dart';
import 'package:e_book/Controller/BookController.dart';
import 'package:e_book/Models/Data.dart';
import 'package:e_book/Pages/BookDetails/BookDetails.dart';
import 'package:e_book/Pages/Homepage/Widgets/AppBar.dart';
import 'package:e_book/Pages/Homepage/Widgets/CategoryWidget.dart';
import 'package:e_book/Pages/Homepage/Widgets/MyInputeTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());
    bookController.getUserBook();
    return Scaffold(
      drawer: myDrawer,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const HomeAppBar(),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Text(
                        "Hellow!",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface,
                            ),
                      ),
                      Text(
                        "",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "Time to read book and enhance your knowledge",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const MyInputTextField(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Topics",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categoryData
                          .map(
                            (e) => CategoryWidget(
                                iconPath: e["icon"]!,
                                btnName: e["lebel"]!),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Trending",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // Adding six different images with text below
                        buildTrendingBook(context, "boundraries.jpg", "Boundaries"),
                        buildTrendingBook(context, "When the moon split.jpg", "When the Moon Split"),
                        buildTrendingBook(context, "Give and Take.jpg", "Give and Take"),
                        buildTrendingBook(context, "You are not so smart.jpg", "You Are Not So Smart"),
                        buildTrendingBook(context, "sycho.png", "Psychology of Money"), // New book
                        buildTrendingBook(context, "narnia.png", "Narnia"), // Sixth book
                        buildTrendingBook(context, "daily stoic.jpg", "Daily Stoic"),
                        buildTrendingBook(context, "never.jpg", "Never Split the Difference"),
                        // Existing books from controller
                        Obx(
                          () => Row(
                            children: bookController.bookData
                                .map(
                                  (e) => BookCard(
                                    title: e.title!,
                                    coverUrl: e.coverUrl!,
                                    ontap: () {
                                      Get.to(BookDetails(
                                        book: e,
                                      ));
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Your Interests",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => Column(
                      children: bookController.bookData
                          .map(
                            (e) => BookTile(
                              ontap: () {
                                Get.to(BookDetails(book: e));
                              },
                              title: e.title!,
                              coverUrl: e.coverUrl!,
                              author: e.author!,
                              price: e.price!,
                              rating: e.rating!,
                              numberofRating: 12,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTrendingBook(BuildContext context, String imageFileName, String title) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "Assets/Images/$imageFileName",
                  width: 90,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
