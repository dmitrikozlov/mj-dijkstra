//
//  MJOrderDictionary.m
//  dijkstra
//
//  Created by Dmitri Kozlov on 21/02/13.
//  Copyright (c) 2013 Dmitri Kozlov. All rights reserved.
//

#import "MJPriorityDictionary.h"
#import <unordered_map>
#import <vector>
#include <stdexcept>

struct MJKeyHasher
{
    bool operator()(KeyType const &key) const
    {
        return [key hash];
    }
};

struct MJKeyEqual
{
    bool operator()(KeyType const &lhs, KeyType const &rhs) const
    {
        return [lhs isEqual:rhs];
    }
};

typedef std::unordered_map<KeyType, ObjType, MJKeyHasher, MJKeyEqual> Dictionary;
typedef std::pair<KeyType, ObjType> KVPair;
typedef std::vector<KVPair> Order;

//returns true if self is to be placed earlier than obj in a strict weak ordering operation.
bool val_compare_less(KVPair const &lhs, KVPair const &rhs)
{
    return [lhs.second compare:rhs.second] == NSOrderedAscending;
}

bool val_compare_more(KVPair const &lhs, KVPair const &rhs)
{
    return [lhs.second compare:rhs.second] == NSOrderedDescending;
}

@implementation MJPriorityDictionary
{
    Dictionary _dict;
    Order _order;
    bool _heapified;
    bool (*_val_compare)(KVPair const &lhs, KVPair const &rhs);
}

+(MJPriorityDictionary*)dictionary
{
    return [[[MJPriorityDictionary alloc] initAscending:YES] autorelease];
}

+(MJPriorityDictionary*)dictionaryAscending:(BOOL)asc
{
    return [[[MJPriorityDictionary alloc] initAscending:asc] autorelease];
}

-(id)initAscending:(BOOL)asc
{
    self = [super init];
    if (self)
        _val_compare = asc ? val_compare_less : val_compare_more;
    return self;
}

-(void)dealloc
{
    [self clear];
    [super dealloc];
}

- (void)buildheap
{
	std::make_heap(_order.begin(), _order.end(), _val_compare);
	_heapified = YES;

    //for (Order::iterator it = _order.begin(); it != _order.end(); ++it)
    //    NSLog(@"after buildheap {%@: %d}", it->first, [(NSNumber*)it->second integerValue]);
}

-(void)clear
{
    _dict.clear();
    _order.clear();
	_heapified = NO;
}

-(bool)empty
{
    return _dict.empty();
}

-(size_t)size
{
    return _dict.size();
}

//Calling this function on an empty container causes undefined behavior.
-(KVPair &)top_pair
{
    if (!_heapified)
        [self buildheap];
    
    while (true)
    {
        KVPair &v = _order.front();
        Dictionary::iterator it = _dict.find(v.first);
        if (it == _dict.end() || it->second != v.second)
        {
            //NSLog(@"Pop heap .............");
            std::pop_heap(_order.begin(), _order.end(), _val_compare);
            _order.pop_back();
        }
        else
            break;
    }
    return _order.front();
}

-(KeyType)top
{
    if (_dict.empty())
        return nil;
    
    KVPair &pair = [self top_pair];
    return pair.first;
}

-(void)pop
{
    if (_dict.empty())
        return;

    KeyType key = [self top];
    _dict.erase(key);
    std::pop_heap(_order.begin(), _order.end(), _val_compare);
    
    //for (Order::iterator it = _order.begin(); it != _order.end(); ++it)
    //    NSLog(@"after pop {%@: %d}", it->first, [(NSNumber*)it->second integerValue]);

    _order.pop_back();

    //NSLog(@"max heap after pop: %@", _order.front().first);
}

-(void)setObject:(ObjType)obj forKey:(KeyType)key
{
    _dict[key] = obj;
    
    if (2 * _dict.size() < _order.size())
    {
        //NSLog(@"Cleaning order... .............");
        _order.clear();
        _order.assign(_dict.begin(), _dict.end());
        [self buildheap];
    }
    else
    {
        _order.push_back(KVPair(key, obj));
        if (_heapified)
            std::push_heap(_order.begin(), _order.end(), _val_compare);
    }
    
    //for (Order::iterator it = _order.begin(); it != _order.end(); ++it)
    //    NSLog(@"after setobject {%@: %d}", it->first, [(NSNumber*)it->second integerValue]);
}

-(void)removeObjectForKey:(KeyType)key
{
    _dict.erase(key);
}

-(ObjType)objectForKey:(KeyType)key
{
    try
    {
        return _dict.at(key);
    }
    catch (std::out_of_range e)
    {
        return nil;
    } 
}

// Next two methods are to allow clang dictionary subscriptions
-(ObjType)objectForKeyedSubscript:(KeyType)key
{
    return [self objectForKey:key];
}

-(void)setObject:(ObjType)obj forKeyedSubscript:(KeyType)key
{
    [self setObject:obj forKey:key];
}

/*
// NSFastEnumeration protocol (KeyValPair)
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len
{
    if (state->state == 0)
    {
        // This enumeration allows mutation. Make mutationsPtr
        // point somewhere that's guaranteed not to change.
        state->mutationsPtr = (unsigned long *)self;

        // and update state to indicate that enumeration has started
        state->state = 1;
    }
    
    if (_dict.empty())
        return 0;
    
    KVPair &pair = [self top_pair];
    
        // otherwise, point itemsPtr at the node's value
        state->itemsPtr = &currentNode->value
        
    // we're returning exactly one item
    return 1;
}
*/

@end
