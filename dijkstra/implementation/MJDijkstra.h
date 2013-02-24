//
//  MJDijkstra.h
//  dijkstra
//
//  Created by Dmitri Kozlov on 19/02/13.
//  Copyright (c) 2013 Dmitri Kozlov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct
{
    NSDictionary *distances;
    NSDictionary *predecessors;
} MJDijkstraSolution;

MJDijkstraSolution Dijkstra(NSDictionary *G, id start, id end);
NSArray *shortestPath(NSDictionary *G, id start, id end);
