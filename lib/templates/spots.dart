import 'package:flutter/material.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';
class SpotsPage extends StatelessWidget {
  const SpotsPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Les bornes'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 39, 40, 43),
        ),
        body: Container(
          decoration: const BoxDecoration(color: Color.fromARGB(255, 78, 81, 92)),
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
                    image: NetworkImage('https://placeimg.com/640/480/any'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ]
          ),
        ),
      );
}
