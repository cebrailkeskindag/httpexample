import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:httpexample/models/product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    Uri url = Uri.https("dummyjson.com", "products");
    // http istekleri ASYNC'dır
    // await keywordü
    final response = await http.get(url);
    final data = json.decode(response.body);
    final products = data["products"];
    List<Product> productsFromWebAPI = [];

    for (final item in products) {
      Product product = Product(
        id: item["id"],
        title: item["title"],
        description: item["description"],
        price: item["price"],
        discountPercentage: item["discountPercentage"],
        rating: item["rating"],
        stock: item["stock"],
        brand: item["brand"],
        category: item["category"],
        thumbnail: item["thumbnail"],
        images: item["images"],
      );
      productsFromWebAPI.add(product);
    }

    setState(() {
      productList = productsFromWebAPI;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (ctx, index) => Card(
        child: Column(children: [
          Container(
            width: 375,
            height: 550,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(0.32, -0.95),
                end: Alignment(-0.32, 0.95),
                colors: [Color(0xFFE6E9F3), Colors.white],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x2B0757D0),
                  blurRadius: 77,
                  offset: Offset(34, 24),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  top: 20,
                  child: SizedBox(
                    width: 335,
                    height: 386,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 335,
                            height: 386,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFD3D3D3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 335,
                            height: 340,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image:
                                    NetworkImage(productList[index].thumbnail),
                                fit: BoxFit.cover,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 260,
                          bottom: 18,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFFFFFF),
                            ),
                            padding: const EdgeInsets.all(
                                8), // İsteğe bağlı olarak içerideki metni ayarlamak için padding ekleyebilirsiniz
                            child: Text(
                              "\$${productList[index].price.toString()}",
                              style: const TextStyle(
                                color: Colors
                                    .black, // Metin rengini beyaz olarak ayarladım, siz istediğiniz rengi kullanabilirsiniz
                                fontSize: 14,
                                fontFamily: 'CircularXX',
                                fontWeight: FontWeight.w700,
                                height: 3,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 10,
                          child: Text(
                            productList[index].title,
                            style: const TextStyle(
                              color: Color(0xFF232323),
                              fontSize: 24,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 392,
                  child: SizedBox(
                    width: 335,
                    height: 167,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 68,
                          child: SizedBox(
                            width: 335,
                            child: Text(
                              productList[index].description,
                              style: const TextStyle(
                                color: Color(0xFF3A544F),
                                fontSize: 14,
                                fontFamily: 'CircularXX',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 74,
                          top: 167,
                          child: Transform(
                            transform: Matrix4.identity()
                              ..translate(0.0, 0.0)
                              ..rotateZ(-1.57),
                            child: Container(
                              width: 24,
                              height: 24,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 3,
                          top: 10,
                          child: SizedBox(
                            width: 332,
                            height: 42,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 25,
                                  child: SizedBox(
                                    width: 114,
                                    height: 17,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 114,
                                          height: 17,
                                          child: Stack(
                                            children: [
                                              // Dolu yıldızlar
                                              Positioned(
                                                left: 0,
                                                top: 2,
                                                child: Row(
                                                  children:
                                                      List.generate(5, (index) {
                                                    return Icon(
                                                      Icons.star,
                                                      color: index <
                                                              productList[index]
                                                                  .rating
                                                          ? Colors.yellow
                                                          : Colors
                                                              .grey, // Rating değerine göre renk ayarlanıyor
                                                      size: 12,
                                                    );
                                                  }),
                                                ),
                                              ),
                                              // Rating değeri
                                              Positioned(
                                                left: 65,
                                                top: 2,
                                                child: Text(
                                                  productList[index]
                                                      .rating
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Color(0xFF5F5F5F),
                                                    fontSize: 12,
                                                    fontFamily: 'CircularXX',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}


/*
Center(
      child: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (ctx, index) => Card(
                color: Colors.grey,
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        color: Colors.red,
                        child: Text(productList[index].id.toString())),
                    SizedBox(child: Text(productList[index].title)),
                    SizedBox(child: Text(productList[index].description)),
                    SizedBox(child: Text(productList[index].price.toString())),
                    SizedBox(
                        child: Text(
                            productList[index].discountPercentage.toString())),
                    SizedBox(child: Text(productList[index].rating.toString())),
                    SizedBox(child: Text(productList[index].stock.toString())),
                    SizedBox(child: Text(productList[index].brand)),
                    SizedBox(
                        child: Image.network(productList[index].thumbnail)),
                    const SizedBox(
                      child: Text("Images:"),
                    ),
                    for (var imageUrl in productList[index].images)
                      SizedBox(
                        width: 100,
                        child: Image.network(imageUrl),
                      ),
                  ],
                ),
              )),
    );
*/