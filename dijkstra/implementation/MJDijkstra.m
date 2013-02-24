//
//  MJDijkstra.m
//  dijkstra
//
//  Created by Dmitri Kozlov on 19/02/13.
//  Copyright (c) 2013 Dmitri Kozlov. All rights reserved.
//
//  This is a port of Dijkstra algorithm implemented in Python.
//  The Python implementation was suggested by David Eppstein.
//  http://code.activestate.com/recipes/119466-dijkstras-algorithm-for-shortest-paths/?in=user-218935
//

#import "MJDijkstra.h"
#import "MJPriorityDictionary.h"

/*
 Find shortest paths from the start vertex to all
 vertices nearer than or equal to the end.
 
 The input graph G is assumed to have the following
 representation: A vertex can be any object that can
 be used as an index into a dictionary.  G is a
 dictionary, indexed by vertices.  For any vertex v,
 G[v] is itself a dictionary, indexed by the neighbors
 of v.  For any edge v->w, G[v][w] is the length of
 the edge.  This is related to the representation in
 <http://www.python.org/doc/essays/graphs.html>
 where Guido van Rossum suggests representing graphs
 as dictionaries mapping vertices to lists of neighbors,
 however dictionaries of edges have many advantages
 over lists: they can store extra information (here,
 the lengths), they support fast existence tests,
 and they allow easy modification of the graph by edge
 insertion and removal.  Such modifications are not
 needed here but are important in other graph algorithms.
 Since dictionaries obey iterator protocol, a graph
 represented as described here could be handed without
 modification to an algorithm using Guido's representation.
 
 Of course, G and G[v] need not be Python dict objects;
 they can be any other object that obeys dict protocol,
 for instance a wrapper in which vertices are URLs
 and a call to G[v] loads the web page and finds its links.
 
 The output is a pair (D,P) where D[v] is the distance
 from start to v and P[v] is the predecessor of v along
 the shortest path from s to v.
 
 Dijkstra's algorithm is only guaranteed to work correctly
 when all edge lengths are positive. This code does not
 verify this property for all edges (only the edges seen
 before the end vertex is reached), but will correctly
 compute shortest paths even for some graphs with negative
 edges, and will raise an exception if it discovers that
 a negative edge has caused it to make a mistake.
 */

MJDijkstraSolution Dijkstra(NSDictionary *graph, id start, id end)
{
    
    NSMutableDictionary *dist = [NSMutableDictionary dictionary];	// dictionary of final distances
    NSMutableDictionary *pred = [NSMutableDictionary dictionary];	// dictionary of predecessors
    MJPriorityDictionary *prio = [MJPriorityDictionary dictionaryAscending:NO];// estimated dist. of non-final vert.
    MJDijkstraSolution res = {};
    
    prio[start] = @0;
    
    for (id vtx1 = [prio top]; vtx1; vtx1 = [prio top])
    {
        dist[vtx1] = prio[vtx1];
        [prio pop];
        
        if ([vtx1 isEqual:end])
            break;
        
        NSDictionary *neighbours = [graph objectForKey:vtx1];
        for (id vtx2 in neighbours)
        {
            int vwLength = [dist[vtx1] integerValue] + [neighbours[vtx2] integerValue];
            
            if (dist[vtx2] != nil)
            {
                if (vwLength < [dist[vtx2] integerValue])
                {
                    NSLog(@"Dijkstra: found better path to already-final vertex");
                    return res;
                }
            }
            else if (prio[vtx2] == nil || vwLength < [prio[vtx2] integerValue])
            {
                prio[vtx2] = [NSNumber numberWithInt:vwLength];
                pred[vtx2] = vtx1;
            }
        }
    }
    
    res.distances = dist;
    res.predecessors = pred;
    return res;
}

// Find a single shortest path from the given start vertex
// to the given end vertex.
// The input has the same conventions as Dijkstra().
// The output is a list of the vertices in order along
// the shortest path.
NSArray *shortestPath(NSDictionary *graph, id start, id end)
{
    NSMutableArray *path = [NSMutableArray array];
    MJDijkstraSolution solution = Dijkstra(graph, start, end);
    id e = end;
    while (true)
    {
        [path addObject:e];
        if ([e isEqual:start])
            break;
        e = solution.predecessors[e];
    }
    
    int l = [path count] - 1;
    for (int i = 0; i < l-i; ++i)
        [path exchangeObjectAtIndex:i withObjectAtIndex:l-i];

    return path;
}

