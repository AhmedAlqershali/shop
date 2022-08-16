import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_udeny/api/controller/categories_controller.dart';
import 'package:shop_udeny/api/controller/favorites_controller.dart';

import '../api/controller/home_controller.dart';
import '../models/home_models.dart';

class Homescreen extends StatefulWidget {
  Homescreen({Key? key}) : super(key: key);
  HomeModels? models;

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // getData(int index) async {
  //   ApiResponse apiResponse = await FavoritesController()
  //       .setfavoritesOn(Get.find<FavoritesController>().favoritesModels!.id!);
  // }

  void toggleFavorite(int index) {
    setState(() {
      if (Get.find<HomeController>()
              .homeModels!
              .data!
              .products![index]
              .inFavorites ==
          false) {
        Get.find<HomeController>()
            .homeModels!
            .data!
            .products![index]
            .inFavorites = true;
      } else {
        Get.find<HomeController>()
            .homeModels!
            .data!
            .products![index]
            .inFavorites = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<HomeController>(
      global: true,
      builder: (controller) {
        if (controller.homeModels == null) {
          return Center(child: Text("loading"));
        }
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SizedBox(
            height: 3100,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              productHome(),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategory(
                          index: index,
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10,
                        ),
                        itemCount: Get.find<CategoriesController>()
                            .categoriesModels!
                            .value
                            .data!
                            .data!
                            .length,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'New Product',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                color: Colors.grey[300],
                child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 1 / 1.56,
                    children: List.generate(
                        Get.find<HomeController>()
                            .homeModels!
                            .data!
                            .products!
                            .length,
                        (index) => ProductWidget(
                            product: Get.find<HomeController>()
                                .homeModels!
                                .data!
                                .products![index]))),
              )),
            ]),
          ),
        );
      },
    ));
  }

  Widget productHome() => Column(
        children: [
          CarouselSlider(
            items: Get.find<HomeController>()
                .homeModels!
                .data!
                .banners!
                .map((e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                    ))
                .toList(),
            options: CarouselOptions(
                height: 110,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal),
          ),
        ],
      );
}

class buildCategory extends StatelessWidget {
  buildCategory({
    required this.index,
    Key? key,
  }) : super(key: key);
  int index;

  @override
  Widget build(BuildContext context) {
    return GetX<CategoriesController>(
        global: true,
        builder: ((controller) => Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Image(
                  image: NetworkImage(controller
                      .categoriesModels!.value.data!.data![index].image!),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withOpacity(.8),
                  width: 100,
                  child: Text(
                    controller.categoriesModels!.value.data!.data![index].name!,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )));
  }
}

class ProductWidget extends StatefulWidget {
  ProductWidget({Key? key, required this.product}) : super(key: key);
  Products product;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  HomeController controller = Get.find<HomeController>();
  bool isfav = false;
  @override
  void initState() {
    setState(() {
      isfav = widget.product.inFavorites!;
    });
    super.initState();
  }

  toggleIsFav() {
    if (isfav) {
      setState(() {
        isfav = false;
      });
    } else {
      setState(() {
        isfav = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Products product = widget.product;

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(widget.product.image!),
                width: double.infinity,
                height: 170,
              ),
              if (product.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      product.price!.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade400,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2,
                      width: 5,
                    ),
                    if (product.discount != 0)
                      Text(
                        product.oldPrice!.toString(),
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    Column(
                      children: [
                        if (isfav)
                          CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                onPressed: () {
                                  toggleIsFav();
                                  FavoritesController()
                                      .setFavouriteOf(product.id!);
                                },
                                icon: Icon(
                                  Icons.favorite_outlined,
                                  size: 26,
                                  color: Colors.red,
                                ),
                              ),
                              backgroundColor: Colors.blue)
                        else
                          CircleAvatar(
                              radius: 20,
                              child: Center(
                                child: IconButton(

                                  onPressed: () {
                                    toggleIsFav();
                                    FavoritesController()
                                        .setfavoriteOn(product.id!);
                                  },
                                  icon: Icon(
                                    Icons.favorite_border_outlined,
                                    size: 26,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.grey),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
