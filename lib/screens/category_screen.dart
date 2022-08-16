import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_udeny/api/controller/categories_controller.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
      return ListView.separated(
          itemBuilder: (context,index)=>buildCatIteam(index),
          separatorBuilder: (context,index)=>Divider(endIndent: 10,indent: 10,height: 5,thickness: 2),
          itemCount: Get.find<CategoriesController>()
              .categoriesModels!
              .value
              .data!
              .data!
              .length) ;
  }



  Widget buildCatIteam(int index)=>GetX<CategoriesController>(builder: ((controller) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage(controller.categoriesModels!.value.data!.data![index].image!),
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20,
        ),
        Text(controller.categoriesModels!.value.data!.data![index].name!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        Spacer(),
        Icon(Icons.arrow_forward_ios)

      ],
    ),
  )));


}
