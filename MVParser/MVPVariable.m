//
//  MVPVariable.m
//  MVParser
//

#import "MVPVariable.h"

@implementation MVPVariable

#pragma mark -
#pragma mark Инициализация

- (id) init {
    if (self = [super init]) {
        _value = [MVPValue new];
    }
    return self;
}

@end
