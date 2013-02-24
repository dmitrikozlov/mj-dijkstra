//
//  MJPriorityQueue.m
//  dijkstra
//
//  Created by Dmitri Kozlov on 19/02/13.
//  Copyright (c) 2013 Dmitri Kozlov. All rights reserved.
//
//  Using good for even more good :-)
//  Inspired by Mike Ash http://www.mikeash.com/pyblog/using-evil-for-good.html
//  Credit to Phil Jordan http://philjordan.eu/article/mixing-objective-c-c++-and-objective-c++
//

#import "MJPriorityQueue.h"
#include <queue>

struct MJLessThan
{
    //returns true if self is to be placed earlier than obj in a strict weak ordering operation.
    bool operator()(id const &lhs, id const &rhs)
    {
        return [lhs compare:rhs] == NSOrderedAscending;
    }
};

@implementation MJPriorityQueue
{
    std::priority_queue<id, std::vector<id>, MJLessThan > _queue;
}

+(MJPriorityQueue*)queue
{
    return [[[MJPriorityQueue alloc] init] autorelease];
}

-(id)init
{
    self = [super init];
    return self;
}

-(void)dealloc
{
    [self clear];
    [super dealloc];
}

-(void)clear
{
    while (!_queue.empty())
        [self pop];
}

-(bool)empty
{
    return _queue.empty();
}

-(size_t)size
{
    return _queue.size();
}

-(id)top
{
    return _queue.top();
}

-(void)push:(id)obj
{
    _queue.push(obj);
}

-(void)pop
{
    _queue.pop();
}


@end
