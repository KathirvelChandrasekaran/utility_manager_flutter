import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_supabase/providers/meta_collection_provider.dart';
import 'package:todo_supabase/screens/single_collection_view.dart';
import 'package:todo_supabase/widgets/rounded_button.dart';

class UrlManager extends StatefulWidget {
  UrlManager({Key? key}) : super(key: key);

  @override
  _UrlManagerState createState() => _UrlManagerState();
}

class _UrlManagerState extends State<UrlManager> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final userMetaCollection = watch(metaCollectionOfUser);

        return Scaffold(
            appBar: AppBar(
              title: Text(
                "URL Manager",
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addURL');
              },
              child: Icon(
                Icons.link_rounded,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
            ),
            body: Center(
              child: watch(metaCollectionOfUser).map(
                data: (res) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      userMetaCollection.map(
                        data: (res) {
                          return Flexible(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: res.value.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    WhiteButton(
                                      buttonText: res.value.data[index]
                                          ['collection_name'],
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      onpressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SingleCollectionView(
                                                    collectionName: res
                                                            .value.data[index]
                                                        ['collection_name']),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 15),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                        loading: (_) => SizedBox(
                          width: 300.0,
                          child: LinearProgressIndicator(
                            backgroundColor: Theme.of(context).accentColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        error: (_) => Text(
                          _.error.toString(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                loading: (_) => SizedBox(
                  width: 300.0,
                  child: LinearProgressIndicator(
                    backgroundColor: Theme.of(context).accentColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                error: (_) => Text(
                  _.error.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ));
      },
    );
  }
}
