import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie/utils/providers.dart';
import 'package:movie/utils/styles.dart' as Style;
import 'package:movie/views/more_lists/more_lists.dart';
import 'package:movie/views/widgets/app_bar.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController _searchController = TextEditingController();
  List popularSearch = [
    'Avenger : Infinity War',
    'Iron Man'
  ];
  List recentSearch = [];

  @override
  Widget build(BuildContext context) {
    
    this.recentSearch = context.watch<Providers>().recentSearch == null ? [] : jsonDecode(context.watch<Providers>().recentSearch);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(context, 'Search'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Container(
                    child: TextFormField(
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (_) async {
                        String searchText = _searchController.text;
                        if(searchText != '' && !RegExp(r'^\s$').hasMatch(searchText)){
                          await Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context){
                              return MoreList(
                                type: 'Search',
                                url: searchText.trim(),
                              );
                            }
                          ));
                          recentSearch.remove(searchText);
                          recentSearch.add(searchText.trim());
                          context.read<Providers>().setRecentSearch(jsonEncode(recentSearch));
                        }
                      },
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 15,
                      ),
                      decoration: Style.textField1.copyWith(
                        fillColor: Theme.of(context).backgroundColor,
                        hintText: "Search",
                        hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 14,
                        ),
                      )
                    )
                  )
                ),
                recentSearch.length != 0 ? Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Text(
                    'Recent searches',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'FiraSans',
                    ),
                  ),
                ): Container(),
                recentSearch.length != 0 ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: recentSearch.length,
                  itemBuilder: (context, index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {    
                            String tapText = recentSearch[recentSearch.length - (index + 1)];
                            await Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context){
                                return MoreList(
                                  type: 'Search',
                                  url: tapText.trim(),
                                );
                              }
                            ));
                            recentSearch.remove(tapText);
                            recentSearch.add(tapText);
                            context.read<Providers>().setRecentSearch(jsonEncode(recentSearch));                   
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Icon(
                                        Icons.watch_later_outlined,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      recentSearch[recentSearch.length - (index + 1)],
                                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                                        fontSize: 15,
                                        fontFamily: 'FiraSans',
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: (){
                                      recentSearch.remove(recentSearch[recentSearch.length - (index + 1)]);
                                      context.read<Providers>().setRecentSearch(jsonEncode(recentSearch));
                                    },
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.delete_outline,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ): Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}