import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  static const Color defaultTextColor = Colors.black;
  static const double defaultPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 5,
            toolbarHeight: 0,
            bottom: PreferredSize(
              preferredSize: const Size(200.0, 50.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SizedBox(
                    width: 200.0,
                    child: TabBar(
                      tabs: [
                        Tab(
                          child: Text(
                            "Men",
                            style: TextStyle(color: defaultTextColor),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Women",
                            style: TextStyle(color: defaultTextColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, defaultPadding, 0),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(children: [
            LeftCategories(
              categoryType: 'Women',
            ),
            LeftCategories(
              categoryType: 'Men',
            ),
          ]),
        ));
  }
}

class LeftCategories extends StatefulWidget {
  LeftCategories({Key? key, required this.categoryType}) : super(key: key);
  final String categoryType;

  @override
  State<LeftCategories> createState() => _LeftCategoriesState();
}

class _LeftCategoriesState extends State<LeftCategories> {
  final List<String> womenCategories = [
    "New Arrivals",
    "Promotions",
    "Clothing",
    "Self Care",
    "Skirt",
    "Top",
    "Y2K"
  ];

  final List<String> menCategories = [
    "New Arrivals",
    "Promotions",
    "Clothing",
    "Self Care",
    "Top",
    "Y2K"
  ];

  List<bool> selected = [true, false, false, false, false, false, false];

  void select(int n, type) {
    int len = 0;

    if (type == 'Men') {
      len = menCategories.length;
    } else {
      len = womenCategories.length;
    }

    for (int i = 0; i < len; i++) {
      if (i == n) {
        selected[i] = true;
      } else {
        selected[i] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Container(
          // margin: const EdgeInsets.all(8.0),
          height: MediaQuery.of(context).size.height,
          width: 150.0,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            // borderRadius: BorderRadius.circular(20.0)
          ),
          child: Stack(children: [
            Positioned(
              // top: 20,
              child: Column(
                children: widget.categoryType == "Women"
                    ? womenCategories
                        .map((e) => LeftItem(
                              itemName: e,
                              selected: selected[womenCategories.indexOf(e)],
                              onTap: () {
                                setState(() {
                                  select(womenCategories.indexOf(e),
                                      widget.categoryType);
                                });
                              },
                            ))
                        .toList()
                    : menCategories
                        .map((e) => LeftItem(
                              itemName: e,
                              selected: selected[menCategories.indexOf(e)],
                              onTap: () {
                                setState(() {
                                  select(womenCategories.indexOf(e),
                                      widget.categoryType);
                                });
                              },
                            ))
                        .toList(),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class LeftItem extends StatefulWidget {
  const LeftItem(
      {Key? key,
      required this.itemName,
      required this.onTap,
      required this.selected})
      : super(key: key);

  final String itemName;
  final Function onTap;
  final bool selected;

  @override
  State<LeftItem> createState() => _LeftItemState();
}

class _LeftItemState extends State<LeftItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap(),
      child: Container(
        color: !widget.selected ? Colors.transparent : Colors.white,
        child: Stack(children: [
          SizedBox(
            height: 40.0,
            width: 150.0,
            child: Center(
                child: Text(
              widget.itemName,
              style: const TextStyle(color: Colors.black),
            )),
          )
        ]),
      ),
    );
  }
}
