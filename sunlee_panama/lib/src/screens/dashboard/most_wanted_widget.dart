import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/providers/searching_provider.dart';

class MostWantedWidget extends StatelessWidget {
  const MostWantedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searching = Provider.of<SearchingProvider>(context, listen: true);
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 220.0,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: searching.wanted.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/detailProduct',
                  arguments: searching.wanted[index],
                ),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black12,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            searching.wanted[index].getImgUrl(),
                          ),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.bottomCenter),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            searching.wanted[index].productName,
                            maxLines: 3,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            searching.wanted[index].refProdCode,
                            maxLines: 1,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 11,
                            ),
                          ),
                        ],
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
