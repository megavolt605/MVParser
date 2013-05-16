//
//  NSMutableArray+MVParserStack.h
//  MVParser
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MVParser)

- (void) pushObject: (NSObject *) object;
- (NSObject *) popObject;
- (void) pushObjectsFromStack: (NSMutableArray *) stack;

@end
