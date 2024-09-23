import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostList {
  int userId;
  int id;
  String title;
  String body;

  // default constructor with required parameters
  PostList(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body});

  // factory method which helps to create instance of same class
  factory PostList.fromJson(dynamic json) => PostList(
      id: json["id"],
      userId: json["userId"],
      title: json["title"],
      body: json["body"]);
}

// Declare an empty List of Post
List<PostList> list = [];

// future function to call http.get method to retrive the response ("https://jsonplaceholder.typicode.com/posts")
Future<List<PostList>> getProductData() async {
  //here we are quering to endpoint which returns Post data as response
  http.Response response =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
  // check if the response is OK
  if (response.statusCode == 200) {
    try {
      // here we convert that response in json format with the help of jsonDecode() method and store it into data variable
      var data = jsonDecode(response.body) as List;
      //List Class which is used to iterate on
      // every element of list and here we iterate on every elemet of data(which is list)
      //and with the help of factory method
      // we create instance of PostList class and add it to list
      list = data.map((e) => PostList.fromJson(e)).toList();
    } catch (e) {
      log("messsage", error: e.toString());
    }
  }
  return list;
}

class fetchData extends StatefulWidget {
  const fetchData({super.key});

  @override
  _fetchDataState createState() => _fetchDataState();
}

class _fetchDataState extends State<fetchData> {
  
  //refresh method
  Future<void> _refreshData() async {
    // Refresh the data
    await getProductData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest Api Demo'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder(
          future: getProductData(),
          builder: (context, AsyncSnapshot<List<PostList>> postSnapshot) {
            if (postSnapshot.hasData) {
              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: postSnapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(postSnapshot.data![index].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        )),
                    subtitle: Text(postSnapshot.data![index].body),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
