Dijkstra algorithm
==================

An implementation of Dijkstra algorithm in Objective C

Dijkstra algorithm finds all shortest paths from a vertex to each other vertex in a graph.

The input graph G is assumed to have the following representation: A vertex can be any object that can
be used as an index into a dictionary.  G is a dictionary, indexed by vertices.  For any vertex v,
G[v] is itself a dictionary, indexed by the neighbors of v.  For any edge v->w, G[v][w] is the length of	the edge.
  
This code is a port of a Python implementation of Dijkstra algorithm suggested by David Eppstein.

See http://code.activestate.com/recipes/119466-dijkstras-algorithm-for-shortest-paths/?in=user-218935

It also provides an implementation of a priority dictionary: a key value map which is also ordered by values.

The implementation relies on C++ stl. stl::map and stl::make_heap do most of heavy lifting.
New feature of clang is used to keep C++ out of Objective-C headers: ivars in class extensions.

The project incliudes unit tests.

Example
=======
NSDictionary *G = @{@"s":@{@"u":@10, @"x":@5},
                        @"u":@{@"v":@1, @"x":@2},
                        @"v":@{@"y":@4},
                        @"x":@{@"u":@3, @"v":@9, @"y":@2},
                        @"y":@{@"s":@7, @"v":@6}};
    
    NSString *start = @"s";
    NSString *end = @"v";    
    MJDijkstraSolution res = Dijkstra(G, start, end);
    NSArray *path = shortestPath(G, start, end);
    
---
This is free and unencumbered software released into the public domain.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
