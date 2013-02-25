dijkstra
========

An implementation of Dijkstra algorithm in Objective C

Dijkstra algorithm finds all shortest paths from a vertex to each other vertex in a graph.
This repository is a port of a Python implementation of Dijkstra algorithm suggested by David Eppstein.

See http://code.activestate.com/recipes/119466-dijkstras-algorithm-for-shortest-paths/?in=user-218935

It also provides an implementation of a priority dictionary: a key value map also ordered by values.

The implementation relies on C++ stl. stl::map and stl::make_heap do most of heavy lifting.
New feature of clang is used to keep C++ out of Objective-C headers: ivars in class extensions.

The project incliudes unit tests.
