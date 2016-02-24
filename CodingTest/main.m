//
//  main.m
//  CodingTest
//
//  Created by Gene Dahilig on 2/24/16.
//  Copyright © 2016 Gene Dahilig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdio.h>


#import <Foundation/Foundation.h>
#define MAX_X 3
#define MAX_Y 4
#define VISITED -1
#define INVALID_MOVE 9

int a[3][4] = {
    {1, 9, 0, 0} ,   /*  initializers for row indexed by 0 */
    {0, 0, 0, 0} ,   /*  initializers for row indexed by 1 */
    {0, 9, 0, 1}   /*  initializers for row indexed by 2 */
};

@interface Node : NSObject
{
}
@property (strong)    NSMutableArray<Node*> *adjecentNodes;
@property int Value;
-initWithValue:(int)value;

@end

@implementation Node

-(id)initWithValue:(int)value
{
    _adjecentNodes = [[NSMutableArray alloc] initWithCapacity:100];
    _Value = value;
    return self;
}

-(void)dealloc
{
    _adjecentNodes = nil;
}

@end

// custom build graph.
// given more time, could write method to build graph given an arbitrary input array describing the possible moves. tbd
Node* buildGraph1()
{
    Node* root;
    
    Node* nodeA, *nodeB, *nodeC;
    
    root = [[Node alloc] initWithValue:0];
    
    nodeA = [[Node alloc] initWithValue:5];
    [root.adjecentNodes addObject:nodeA];
    
    nodeB = [[Node alloc] initWithValue:9];
    
    [nodeA.adjecentNodes addObject:nodeB];
    
    nodeB = [[Node alloc] initWithValue:6];
    
    [nodeA.adjecentNodes addObject:nodeB];
    
    nodeA = nodeB;
    nodeB = [[Node alloc] initWithValue:7];
    [nodeA.adjecentNodes addObject:nodeB];
    
    nodeA = nodeB;
    nodeB = [[Node alloc] initWithValue:3];
    [nodeA.adjecentNodes addObject:nodeB];
    
    nodeC = [[Node alloc] initWithValue:11];
    [nodeA.adjecentNodes addObject:nodeC];
    
    nodeA = nodeB;
    nodeB = [[Node alloc] initWithValue:4];
    [nodeA.adjecentNodes addObject:nodeB];
    
    nodeA = nodeC;
    nodeB = [[Node alloc]initWithValue:12];
    [nodeA.adjecentNodes addObject:nodeB];
    
    return root;
}

/*
    returns 0 if found
    returns -1 if dead end.
 */

#define FOUND (0)
#define DEAD_END (-1)

// recurses through the graph and outputs the path in reverse order.
int findPath(Node* node, int endingNode)
{
    int result = DEAD_END;
    if (node.Value == endingNode)
    {
        NSLog(@"%d",node.Value);
        return FOUND;
    }
    else
    {
        for (Node* adjecent in node.adjecentNodes)
        {
            result = findPath(adjecent, endingNode);
            if (result == FOUND)
            {
                NSLog(@"%d",node.Value);
                return FOUND;
            }
        }
    }
    
    
    return result;
}

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        Node * root = buildGraph1();
        
        int result = findPath(root, 12);
        NSLog(@"result = %d", result);
    }
}

