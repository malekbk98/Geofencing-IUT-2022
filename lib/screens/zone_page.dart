import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';

class ZonePage extends StatelessWidget {
  const ZonePage({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Les bornes'),
          centerTitle: true,
        ),
        body: 
        FutureBuilder(
          future: getTextData(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.network(
                          'https://placeimg.com/640/480/any',
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                      ),
                      Markdown(
                        physics: const NeverScrollableScrollPhysics(),
                        data: snapshot.data.toString(),
                        shrinkWrap: true,
                      )
                    ],
                  ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }
        ),
      );

  Future<String> getTextData() async{
    return '''
## Overview

### Philosophy

Markdown is intended to be as easy-to-read and easy-to-write as is feasible.

Readability, however, is emphasized above all else. A Markdown-formatted
document should be publishable as-is, as plain text, without looking
like it's been marked up with tags or formatting instructions. While
Markdown's syntax has been influenced by several existing text-to-HTML
filters -- including [Setext](http://docutils.sourceforge.net/mirror/setext.html), [atx](http://www.aaronsw.com/2002/atx/), [Textile](http://textism.com/tools/textile/), [reStructuredText](http://docutils.sourceforge.net/rst.html),
[Grutatext](http://www.triptico.com/software/grutatxt.html), and [EtText](http://ettext.taint.org/doc/) -- the single biggest source of
inspiration for Markdown's syntax is the format of plain text email.

## Block Elements

### Paragraphs and Line Breaks

A paragraph is simply one or more consecutive lines of text, separated
by one or more blank lines. (A blank line is any line that looks like a
blank line -- a line containing nothing but spaces or tabs is considered
blank.) Normal paragraphs should not be indented with spaces or tabs.

The implication of the "one or more consecutive lines of text" rule is
that Markdown supports "hard-wrapped" text paragraphs. This differs
significantly from most other text-to-HTML formatters (including Movable
Type's "Convert Line Breaks" option) which translate every line break
character in a paragraph into a `<br />` tag.

When you *do* want to insert a `<br />` break tag using Markdown, you
end a line with two or more spaces, then type return.

### Headers

Markdown supports two styles of headers, [Setext] [1] and [atx] [2].

Optionally, you may "close" atx-style headers. This is purely
cosmetic -- you can use this if you think it looks better. The
closing hashes don't even need to match the number of hashes
used to open the header. (The number of opening hashes
determines the header level.)
''';
  }
}
