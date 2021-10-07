import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_supabase/providers/meta_collection_provider.dart';
import 'package:todo_supabase/providers/meta_info_provider.dart';
import 'package:todo_supabase/screens/webview_url.dart';
import 'package:todo_supabase/services/meta_info_service.dart';
import 'package:todo_supabase/utils/constants.dart';
import 'package:todo_supabase/widgets/create_new_collection.dart';
import 'package:todo_supabase/widgets/rounded_button.dart';

// ignore: non_constant_identifier_names
FutureBuilder<dynamic> MetaInfoDisplay(
    MetaInfoProvider url, GlobalKey<FormState> _key) {
  late String photoURL, title, description, type;
  TextEditingController _controller = TextEditingController();

  return FutureBuilder(
    future: MetaInfoService().getMetaInformation(url.url),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (!snapshot.hasData)
        return Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: LinearProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        );
      if (snapshot.hasData) {
        photoURL = snapshot.data['meta']['image'] == null
            ? snapshot.data['meta']['site']['favicon']
            : snapshot.data['meta']['image'];
        title = snapshot.data['meta']['title'] == null ||
                snapshot.data['meta']['title'] == ""
            ? snapshot.data['meta']['site']['name']
            : snapshot.data['meta']['title'];
        description = snapshot.data['meta']['description'] == null
            ? snapshot.data['meta']['site']['canonical']
            : snapshot.data['meta']['description'];
        type = snapshot.data['meta']["type"] == "profile" ? '🙍🏼‍♂️' : '📖';
      }
      return Consumer(
        builder: (context, watch, child) {
          // final addURLToCollection = watch(addUserURLToCollection);
          return Container(
            child: snapshot.data['result']['status'] == "OK"
                ? Padding(
                    padding: const EdgeInsets.all(.5),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                50,
                              ),
                              child: Image.network(
                                photoURL,
                                scale: 0.1,
                                width: 100,
                                height: 100,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                title,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                description,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Text(
                                type,
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            RoundedButtonWidget(
                              buttonText: "Open URL",
                              width: MediaQuery.of(context).size.width * 0.8,
                              onpressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewURL(
                                      url: url.url,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            AcceptRoundedButtonWidget(
                              buttonText: "Save URL",
                              width: MediaQuery.of(context).size.width * 0.8,
                              onpressed: () {
                                addURLToCollection(context, _controller,
                                    photoURL, title, type, url);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Text(
                    "Data not found",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          );
        },
      );
    },
  );
}

addURLToCollection(BuildContext context, TextEditingController _controller,
    String photoURL, String title, String type, MetaInfoProvider url) async {
  showModalBottomSheet(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    builder: (BuildContext context) {
      return Consumer(
        builder: (context, watch, child) {
          final userMetaCollection = watch(metaCollectionOfUser);
          return Column(
            children: [
              SizedBox(
                height: 25,
              ),
              RoundedButtonWidget(
                buttonText: "Create new collection",
                width: MediaQuery.of(context).size.width * 0.8,
                onpressed: () {
                  createNewCollection(context, _controller);
                },
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
                              width: MediaQuery.of(context).size.width * 0.9,
                              onpressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      title: Text(
                                        "Save to ${res.value.data[index]['collection_name']}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Text(
                                        "Are you sure!?",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      buttonPadding: EdgeInsets.all(
                                        10,
                                      ),
                                      actions: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Cancel"),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Theme.of(context)
                                                      .errorColor,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 25,
                                                    vertical: 15,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await supabase
                                                      .from("URLCollection")
                                                      .insert([
                                                    {
                                                      'created_by': supabase
                                                          .auth
                                                          .currentUser
                                                          ?.email,
                                                      'photoURL':
                                                          photoURL.toString(),
                                                      'title': title.toString(),
                                                      'type': type.toString(),
                                                      'url': url.url,
                                                    }
                                                  ]).execute();
                                                  Navigator.popUntil(
                                                    context,
                                                    (route) => route.isFirst,
                                                  );
                                                  // showSnackBar(context,
                                                  //     "Added to ${fetchedURLCollection['names'][i]['name']} collection!");
                                                },
                                                child: Text("OK"),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Theme.of(context)
                                                      .primaryColor,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 35,
                                                    vertical: 15,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
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
      );
    },
  );
}
