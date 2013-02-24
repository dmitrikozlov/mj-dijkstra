//
//  dijkstraLogicTests.m
//  dijkstraLogicTests
//
//  Created by Dmitri Kozlov on 19/02/13.
//  Copyright (c) 2013 Dmitri Kozlov. All rights reserved.
//

#import "dijkstraLogicTests.h"
#import "MJPriorityQueue.h"
#import "MJPriorityDictionary.h"
#import "MJDijkstra.h"

@implementation dijkstraLogicTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

#pragma mark PriorityQueue

- (void)testPriorityQueueEmpty
{
    MJPriorityQueue *q = [MJPriorityQueue queue];
    STAssertTrue([q empty], @"Queue should be empty");
}

- (void)testPriorityQueueSize
{
    MJPriorityQueue *q = [MJPriorityQueue queue];
    [q push:@"string"];
    STAssertTrue([q size] == 1, @"Queue size should be 1");
}

- (void)testPriorityQueuePush
{
    MJPriorityQueue *q = [MJPriorityQueue queue];
    [q push:@"string"];
    STAssertTrue([[q top] isEqual:@"string"], @"Queue top is wrong");
}

- (void)testPriorityQueuePop
{
    MJPriorityQueue *q = [MJPriorityQueue queue];
    [q push:@"string"];
    [q pop];
    STAssertTrue([q size] == 0, @"Queue size should be 0");
}

- (void)testPriorityQueueCleanup
{
    MJPriorityQueue *q = [MJPriorityQueue queue];
    [q push:@"string"];
    [q pop];
    STAssertTrue([q empty], @"Queue should be empty");
}

- (void)testPriorityQueueSort
{
    NSString *s1 = @"abc";
    NSString *s2 = @"def";
    NSString *s3 = @"zyx";
    MJPriorityQueue *q = [MJPriorityQueue queue];
    [q push:s1];
    [q push:s3];
    [q push:s2];
    
    STAssertTrue([[q top] isEqual:s3], @"Queue sorting failed");
    [q pop];
    STAssertTrue([[q top] isEqual:s2], @"Queue sorting failed");
    [q pop];
    STAssertTrue([[q top] isEqual:s1], @"Queue sorting failed");
    [q pop];
}

//
//
//

#pragma mark PriorityDictionary

- (void)testPriorityDictionaryEmpty
{
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    STAssertTrue([q empty], @"Dictionary should be empty");
}

- (void)testPriorityDictionarySize
{
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    [q setObject:@1 forKey:@"key"];
    STAssertTrue([q size] == 1, @"Dictionary size should be 1");
}

- (void)testPriorityDictionaryPush
{
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    [q setObject:@1 forKey:@"key"];
    STAssertTrue([[q top] isEqual:@"key"], @"Dictionary top is wrong");
}

- (void)testPriorityDictionarySubscripting
{
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    q[@"key"] = @1;
    STAssertTrue([[q top] isEqual:@"key"], @"Dictionary top is wrong");
}

- (void)testPriorityDictionaryPopSize
{
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    q[@"key"] = @1;
    [q pop];
    STAssertTrue([q size] == 0, @"Dictionary size should be 0");
}

- (void)testPriorityDictionaryPopEmpty
{
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    q[@"key"] = @1;
    [q pop];
    STAssertTrue([q empty], @"Dictionary should be empty");
}

- (void)testPriorityDictionaryClear
{
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    q[@"key1"] = @1;
    q[@"key2"] = @1;
    [q clear];
    STAssertTrue([q empty], @"Dictionary should be empty");
}

- (void)testPriorityDictionarySort1
{
    NSString *k1 = @"k1";
    NSString *k2 = @"k2";
    NSString *k3 = @"k3";
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    q[k1] = @1;
    q[k2] = @2;
    q[k3] = @3;
    
    STAssertTrue([[q top] isEqual:k3], @"Dictionary sorting failed");
    [q pop];
    STAssertTrue([[q top] isEqual:k2], @"Dictionary sorting failed");
    [q pop];
    STAssertTrue([[q top] isEqual:k1], @"Dictionary sorting failed");
    [q pop];
}

- (void)testPriorityDictionarySort2
{
    NSString *k1 = @"k1";
    NSString *k2 = @"k2";
    NSString *k3 = @"k3";
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    q[k2] = @2;
    q[k1] = @1;

    STAssertTrue([[q top] isEqual:k2], @"Dictionary sorting failed");
    [q pop];

    q[k3] = @3;
    
    STAssertTrue([[q top] isEqual:k3], @"Dictionary sorting failed");
    
    [q removeObjectForKey:k3];
    
    STAssertTrue([[q top] isEqual:k1], @"Dictionary sorting failed");
    [q pop];
}

- (void)testPriorityDictionarySort3
{
    NSArray *keys = @[@"k1",@"k2",@"k3",@"k4",@"k5",@"k6",@"k12",@"k11",@"k10",@"k9",@"k8",@"k7"];
    NSArray *vals = @[@1,@2,@3,@4,@5,@6,@12,@11,@10,@9,@8,@7];
    NSArray *ordered = [vals sortedArrayUsingComparator:^(id o1, id o2){return [o2 compare:o1];}];
    
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    
    for (int i = 0; i < [keys count]; ++i)
    {
        q[keys[i]] = vals[i];
    }
    
    NSString *key;
    for (int i = 0; (key = [q top]); ++i)
    {
        STAssertTrue([q[key] isEqual:ordered[i]],
                     @"Dictionary sorting failed for {%@: %d}. Value should be %d",
                     key, [(NSNumber*)q[key] integerValue], [ordered[i] integerValue]);

        [q pop];
    }
}

- (void)testPriorityDictionarySort4
{
    NSArray *keys = @[@"k1",@"k2",@"k3",@"k4",@"k5",@"k6",@"k12",@"k11",@"k10",@"k9",@"k8",@"k7"];
    NSArray *vals = @[@1,@2,@3,@4,@5,@6,@12,@11,@10,@9,@8,@7];
    
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    
    for (int i = 0; i < [keys count]; ++i)
    {
        q[keys[i]] = vals[i];
    }
    
    int last = [keys count] - 3;
    for (int i = 0; i < last; ++i)
    {
        [q removeObjectForKey:keys[i]];
    }
    
    NSString *t = [q top];
    STAssertTrue([[q top] isEqual:keys[last]], @"Dictionary sorting failed");
    
    for (int i = 0; i < [keys count]; ++i)
    {
        q[keys[i]] = vals[i];
    }

    t = [q top];

    STAssertTrue([[q top] isEqual:@"k12"], @"Dictionary sorting failed");
    
}

#pragma mark Dijkstra

/*
 As an example of the input format, here is the graph from Cormen, Leiserson, and Rivest (Introduction to Algorithms, 1st edition), page 528:
 <pre> G = {'s':{'u':10, 'x':5}, 'u':{'v':1, 'x':2}, 'v':{'y':4}, 'x':{'u':3, 'v':9, 'y':2}, 'y':{'s':7, 'v':6}} </pre>
 The shortest path from s to v is ['s', 'x', 'u', 'v'] and has length 9.
 */
-(void)testSortestPath
{
    NSDictionary *G = @{@"s":@{@"u":@10, @"x":@5},
                        @"u":@{@"v":@1, @"x":@2},
                        @"v":@{@"y":@4},
                        @"x":@{@"u":@3, @"v":@9, @"y":@2},
                        @"y":@{@"s":@7, @"v":@6}};
    
    NSString *start = @"s";
    NSString *end = @"v";
    
    NSArray *answer = @[@"s", @"x", @"u", @"v"];
    NSArray *path = shortestPath(G, start, end);

    STAssertTrue([answer count] == [path count], @"Wrong length of the found path.");

    if ([answer count] != [path count])
        return;
    
    for (int i = 0; i < [answer count]; ++i)
    {
        STAssertTrue(answer[i] == path[i], @"Wrong vertex in the found path.");
    }
}

-(void)testDijkstra
{
    NSDictionary *G = @{@"s":@{@"u":@10, @"x":@5},
                        @"u":@{@"v":@1, @"x":@2},
                        @"v":@{@"y":@4},
                        @"x":@{@"u":@3, @"v":@9, @"y":@2},
                        @"y":@{@"s":@7, @"v":@6}};
    
    NSString *start = @"s";
    NSString *end = @"v";
    
    //NSArray *answer = @[@"s", @"x", @"u", @"v"];
    MJDijkstraSolution res = Dijkstra(G, start, end);
    
    STAssertTrue([res.distances[end] integerValue] == 9, @"Wrong length of a found path.");
}

@end
