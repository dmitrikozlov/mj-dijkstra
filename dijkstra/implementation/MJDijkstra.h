//
//  MJDijkstra.h
//  dijkstra
//
//  Created by Dmitri Kozlov on 19/02/13.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
// PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT
// OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>

//
// Dijkstra algorithm finds shortest paths from the start vertex to all
// vertices nearer than or equal to the end.
//
// The code is ported from Python implementation of Dijkstra algorithm
// proposed by Davis Eppstein:
// http://code.activestate.com/recipes/119466-dijkstras-algorithm-for-shortest-paths/?in=user-218935
//
// The input graph G is assumed to have the following
// representation: A vertex can be any object that can
// be used as an index into a dictionary (*).  G is a
// dictionary, indexed by vertices.  For any vertex v,
// G[v] is itself a dictionary, indexed by the neighbors
// of v.  For any edge v->w, G[v][w] is the length of
// the edge.  This is related to the representation in
// <http://www.python.org/doc/essays/graphs.html>
// where Guido van Rossum suggests representing graphs
// as dictionaries mapping vertices to lists of neighbors,
// however dictionaries of edges have many advantages
// over lists: they can store extra information (here,
// the lengths), they support fast existence tests,
// and they allow easy modification of the graph by edge
// insertion and removal.  Such modifications are not
// needed here but are important in other graph algorithms.
// Since dictionaries obey iterator protocol, a graph
// represented as described here could be handed without
// modification to an algorithm using Guido's representation.
// 
// Of course, G and G[v] need not be Objective C dictionary objects;
// they can be any other object that obeys dictionary protocol (**),
// for instance a wrapper in which vertices are URLs
// and a call to G[v] loads the web page and finds its links.
// 
// The output is a pair (D,P) where D[v] is the distance
// from start to v and P[v] is the predecessor of v along
// the shortest path from s to v.
// 
// Dijkstra's algorithm is only guaranteed to work correctly
// when all edge lengths are positive. This code does not
// verify this property for all edges (only the edges seen
// before the end vertex is reached), but will correctly
// compute shortest paths even for some graphs with negative
// edges, and will raise an exception if it discovers that
// a negative edge has caused it to make a mistake.
//

// Vertex class and Graph class should obey following protocols.
//
// * Vertex object should respond to selectors:
// - (NSUInteger)hash;
// - (BOOL)isEqual:(id)object;
// Should implement <NSCopying> protocol
//
// ** Graph object should respond to selectors:
// -(vertex_collection_type)objectForKeyedSubscript:(vertex_type)vertex;
//
// where vertex_collection_type is a dictionary object that implements
// <NSFastEnumeration> protocol and responds to selector
// -(NSInteger *)objectForKeyedSubscript:(vertex_type)vertex;
//

typedef struct
{
    NSDictionary *distances;
    NSDictionary *predecessors;
} MJDijkstraSolution;

MJDijkstraSolution Dijkstra(NSDictionary *G, id start, id end);
NSArray *shortestPath(NSDictionary *G, id start, id end);
