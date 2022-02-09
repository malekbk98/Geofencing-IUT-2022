import 'package:flutter/material.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';

class ZonesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Les zones'),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(34, 36, 43, 1.0),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: const BoxDecoration(color: Color.fromARGB(255, 78, 81, 92)),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        'Test',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 30
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .6), BlendMode.dstATop),
                        image: NetworkImage('https://placeimg.com/640/480/any'),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        'Test',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 30
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .6), BlendMode.dstATop),
                        image: NetworkImage('https://placeimg.com/640/480/any'),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        'Test',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 30
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .6), BlendMode.dstATop),
                        image: NetworkImage('https://placeimg.com/640/480/any'),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        'Test',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 30
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .6), BlendMode.dstATop),
                        image: NetworkImage('https://placeimg.com/640/480/any'),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        'Test',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 30
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .6), BlendMode.dstATop),
                        image: NetworkImage('https://placeimg.com/640/480/any'),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        'Test',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 30
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .6), BlendMode.dstATop),
                        image: NetworkImage('https://placeimg.com/640/480/any'),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        'Test',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 30
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .6), BlendMode.dstATop),
                        image: NetworkImage('https://placeimg.com/640/480/any'),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
