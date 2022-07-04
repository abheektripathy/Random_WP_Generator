import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _randomwordpairs =
      <WordPair>[]; //creates a list/array of wordpair class(in imports)
  final _savedwordpairs = Set<
      WordPair>(); //another data structure set where repeated values not possible

  Widget _buildrow(WordPair pair) {
    //this widget has props of each tile,icon and color bleh bleh
    final alreadysaved = _savedwordpairs.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase, style: TextStyle(fontSize: 15)),
      trailing: Icon(alreadysaved ? Icons.favorite : Icons.favorite_border,
          color: alreadysaved ? Color.fromARGB(255, 199, 45, 34) : null),
      onTap: () {
        setState(() {
          alreadysaved
              ? _savedwordpairs.remove(
                  pair) // checks true false then(?) does if true (:) if false it does this
              : _savedwordpairs.add(pair);
        });
      },
    );
  }

  Widget _buildlist() {
    return ListView.builder(
      //creates list like thing seperated by divider(added manually)
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, int item) {
        if (item.isOdd) return Divider();

        final index = item ~/
            2; // i dunno what is context, but this randomly genertaes word pairs
        if (index >= _randomwordpairs.length) {
          _randomwordpairs.addAll(generateWordPairs().take(10));
        }
        return _buildrow(_randomwordpairs[index]);
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedwordpairs.map((WordPair pair) {
        return ListTile(
            title: Text(
          pair.asPascalCase,
          style: TextStyle(fontSize: 16),
        ));
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
          appBar: AppBar(title: Text('Saved WordPairs')),
          body: ListView(children: divided));
    })); //navigates to the next and has appbar and props of the next page.
  }

  @override //the main build func
  Widget build(BuildContext context) {
    return Scaffold(
      //scaffold contains widgets like appbar,body stuff
      appBar: AppBar(
        //confusion why we have two appbars?
        title: const Text(
          //normally styling the appbar here
          'WordPairs',
          style: TextStyle(
              fontSize: 20, color: Color.fromARGB(193, 255, 255, 255)),
        ),
        actions: <Widget>[
          IconButton(onPressed: _pushSaved, icon: Icon(Icons.list))
        ],
      ), //push saved navigates to next screen when clicked the list icon
      body: _buildlist(), //build list func controls body of home page
    );
  }
}
