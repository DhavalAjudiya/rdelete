import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapidellete/api_repo/delete_repo.dart';
import 'package:rapidellete/api_repo/post_api_repo.dart';
import 'package:rapidellete/modal/post_data_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController number = TextEditingController();

  // TextEditingController color = TextEditingController();

  @override
  void dispose() {
    number.dispose();

    // color.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("New Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: number,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "mobil number",
                filled: true,
                fillColor: Colors.amber,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            SizedBox(height: screen.height * 0.02),
            // TextField(
            //   controller: color,
            //   decoration: InputDecoration(
            //     hintText: "Note constent",
            //     filled: true,
            //     fillColor: Colors.amber,
            //     enabledBorder: UnderlineInputBorder(
            //       borderSide: BorderSide.none,
            //     ),
            //     focusedBorder:
            //         UnderlineInputBorder(borderSide: BorderSide.none),
            //   ),
            // ),
            SizedBox(height: screen.height * 0.02),
            SizedBox(
              height: screen.height * 0.05,
              width: double.infinity,
              child: RaisedButton(
                color: Colors.green,
                onPressed: () async {
                  DataList.postapi(mobile: number.text);
                },
                child: Text(
                  "submit",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: screen.height * 0.02,
            ),
            Expanded(
              child: FutureBuilder(
                future: DataList.postapi(),
                builder: (context, AsyncSnapshot<Datamodal> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.data![index];
                        return Dismissible(
                          key: ValueKey(snapshot.data!.data![index].id),
                          onDismissed: (direction) {
                            DeleteDataList.deleteapi(
                                id: snapshot.data!.data![index].id);
                          },
                          direction: DismissDirection.horizontal,
                          confirmDismiss: (direction) async {
                            final result = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.amber,
                                title: Text("Warning"),
                                content:
                                    Text("Are you sure want to delete this "),
                                actions: [
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text("Yes"),
                                    splashColor: Colors.red,
                                  ),
                                  FlatButton(
                                    splashColor: Colors.green,
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text("No"),
                                  ),
                                ],
                              ),
                            );
                            return result;
                          },
                          child: ListTile(
                            tileColor: Colors.black,
                            title: Container(
                                height: screen.height * 0.05,
                                width: screen.width,
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.lightGreen),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${data.id}'),
                                    Text('${data.name}'),
                                    Text('${data.color}'),
                                  ],
                                )),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.purple,
                    ));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
