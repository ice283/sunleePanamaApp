import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/providers/navigation_provider.dart';
import 'package:sunlee_panama/src/providers/searching_provider.dart';

class CategoriesCarrousel extends StatelessWidget {
  const CategoriesCarrousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searching = Provider.of<SearchingProvider>(context, listen: true);
    var navigation = Provider.of<NavigationProvider>(context, listen: true);
    gotoTap() {
      if (navigation.currentIndex != 0) {
        navigation.currentIndexUpdate = 0;
      }
    }

    var cant = searching.categories.length;
    return Container(
      height: 40.0,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cant,
          itemBuilder: (BuildContext context, int index) {
            final _name =
                searching.categories[index]['category_name'].toString();
            final _id = searching.categories[index]['id_cat'].toString();
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 3.0),
              child: GestureDetector(
                onTap: () {
                  gotoTap();
                  searching.selectedCategorie = _id;
                  searching.searchingDataFn(searching.searchData);
                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: (_id == searching.selectedCategorie)
                        ? Colors.red[800]
                        : Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 2.0),
                    child: Center(
                      child: Text(
                        _name,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: (_id == searching.selectedCategorie)
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: (_id == searching.selectedCategorie)
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
