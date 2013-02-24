//
//  MJPriorityDictionary.h
//  dijkstra
//
//  Created by Dmitri Kozlov on 21/02/13.
//  Copyright (c) 2013 Dmitri Kozlov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id KeyType;
typedef id ObjType;
/*typedef struct
{
    KeyType _key;
    ObjType _val;
} KeyValPair;
*/

@interface MJPriorityDictionary : NSObject //<NSFastEnumeration>

+(MJPriorityDictionary*)dictionary;
+(MJPriorityDictionary*)dictionaryAscending:(BOOL)asc;
-(id)initAscending:(BOOL)asc;
-(void)dealloc;
-(bool)empty;
-(size_t)size;
-(KeyType)top;
-(void)pop;
-(void)clear;

-(void)setObject:(ObjType)obj forKey:(KeyType)key;
-(void)removeObjectForKey:(KeyType)key;
-(ObjType)objectForKey:(KeyType)key;

-(ObjType)objectForKeyedSubscript:(KeyType)key;
-(void)setObject:(ObjType)object forKeyedSubscript:(KeyType)key;

@end
