//
//  NSMutableArray+MVParserStack.m
//  MVParser
//

#import "NSMutableArray+MVParser.h"

#import "MVPTools.h"

@implementation NSMutableArray (MVParser)

- (void) pushObject: (NSObject *) object {
    [self insertObject: object atIndex: 0];
}

- (NSObject *) popObject {
    if (!self.count) {
        DLog(@"Out of stack! %@", self);
        return nil;
    } else {
        NSObject * res = self[0];
        [self removeObjectAtIndex: 0];
        return res;
    }
}

- (void) pushObjectsFromStack: (NSMutableArray *) stack {
    for (NSObject * obj in stack) {
        [self pushObject: [stack popObject]];
    }
}

@end
