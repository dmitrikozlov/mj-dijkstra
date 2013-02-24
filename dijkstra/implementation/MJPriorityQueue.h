//
//  MJPriorityQueue.h
//  dijkstra
//
//  Created by Dmitri Kozlov on 19/02/13.
//  Copyright (c) 2013 Dmitri Kozlov. All rights reserved.
//
//  Using good for even more good :-)
//  Inspired by Mike Ash http://www.mikeash.com/pyblog/using-evil-for-good.html
//  Credit to Phil Jordan http://philjordan.eu/article/mixing-objective-c-c++-and-objective-c++
//

#import <Foundation/Foundation.h>

@interface MJPriorityQueue : NSObject

+(MJPriorityQueue*)queue;
-(id)init;
-(void)dealloc;
-(void)clear;
-(bool)empty;
-(size_t)size;
-(id)top;
// Pushes obj into the queue. Obj should not be mutable.
-(void)push:(id)obj;
-(void)pop;

@end
