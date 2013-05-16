//
//  MVPValue.m
//  MVParser
//

#import "MVPValue.h"

@implementation MVPValue

#pragma mark -
#pragma mark Инициализация

+ (MVPValue *) valueWithString: (NSString *) string {
    return [[[self class] alloc] initWithString: string];
}

- (id) initWithString: (NSString *) string {
    if (self = [self init]) {
        _stringValue = string;
    }
    return self;
}

#pragma mark -
#pragma Протокол NSCopying

- (id) copyWithZone: (NSZone *)zone {
    return [MVPValue valueWithString: [_stringValue copy]];
}

#pragma mark -
#pragma mark Служебные 

- (NSString *) description {
    return [NSString stringWithFormat: @"%@", _stringValue];
}

@end
