import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_udeny/api/controller/favorites_controller.dart';
import 'package:shop_udeny/api/controller/home_controller.dart';
import 'package:shop_udeny/models/favorite_models.dart';


class Favoritescreen extends StatefulWidget {
   Favoritescreen({Key? key}) : super(key: key);

  @override
  State<Favoritescreen> createState() => _FavoritescreenState();
}

class _FavoritescreenState extends State<Favoritescreen> {

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
      }else{
        Get.find<HomeController>()
            .homeModels!
            .data!
            .products![index]
            .inFavorites = false;
      }
    });
  }
  bool isfav = true;
  @override


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
    return Scaffold(
  body: GetBuilder<FavoritesController>(
    global: true,
      builder:((controller){
        return ListView.separated(
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 120,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Image(
                            image: NetworkImage(controller.favoritesModels!.data!.data![index].product!.image!),
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          ),
                          if (controller.favoritesModels!.data!.data![index].product!.discount! != 0)
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
                      SizedBox(
                        width:20  ,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.favoritesModels!.data!.data![index].product!.name!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14, height: 1.3),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Text(
                                  controller.favoritesModels!.data!.data![index].product!.price!.toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue.shade400,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 2,
                                  width: 5,
                                ),
                                if (controller.favoritesModels!.data!.data![index].product!.discount != 0)
                                  Text(
                                    controller.favoritesModels!.data!.data![index].product!.oldPrice!.toString(),
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
                                                  .setFavouriteOf(controller.favoritesModels!.data!.data![index].id!);
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
                                                    .setfavoriteOn(controller.favoritesModels!.data!.data![index].id!);
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
                ),
              );
            },
            separatorBuilder: (context,index)=>Divider(),
            itemCount: controller.favoritesModels!.data!.data!.length);
      })),
    );
  }
}
