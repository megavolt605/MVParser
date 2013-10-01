//
//  MVPString.m
//  MVParser
//


#import "MVPTools.h"

#import "NSMutableArray+MVParser.h"

#import "MVPReader.h"

@implementation MVPReader {
    NSMutableArray * _positionStack;
}

- (NSString *) readRegEx: (NSString *) pattern options: (NSRegularExpressionOptions) options {
    NSError * e;
    NSRegularExpression * regEx = [NSRegularExpression regularExpressionWithPattern: pattern options: options error: &e];
    @try {
        NSRange r = [regEx rangeOfFirstMatchInString: self.string
                                             options: 0
                                               range: NSMakeRange(self.position, self.string.length - self.position)];
        if (r.length > 0 && r.location == self.position) {
            DLog(@"Range for %@: %lu, %lu", pattern, r.location, r.length);
            self.position += r.length;
            return [self.string substringWithRange: r];
        } else {
            return nil;
        }
    }
    @catch (NSException * exception) {
        return nil;
    }
}

- (NSString *) readRegExArray: (NSArray *) patternArray options: (NSRegularExpressionOptions) options {
    NSString * res;
    for (NSString * pattern in patternArray) {
        [self savePosition];
        res = [self readRegEx: pattern options: options];
        if (res.length != 0) {
            [self commitPosition];
            return res;
        }
        [self restorePosition];
    }
    return 0;
}

- (NSUInteger) lastSavedPosition {
    if (_positionStack.count > 0) {
        return ((NSNumber *)[_positionStack lastObject]).integerValue;
    } else {
        return 0;
    }
}

- (Boolean) endOfData {
    return (self.position >= _string.length);
}

- (void) savePosition {
    [_positionStack pushObject: [NSNumber numberWithUnsignedInteger: _position]];
}

- (void) restorePosition {
    _position = ((NSNumber *)[_positionStack popObject]).integerValue;
}

- (void) commitPosition {
    [_positionStack popObject];
}

#pragma mark -
#pragma mark Инициализация

+ (MVPReader *) readerWithString: (NSString *) string {
    return [[[self class] alloc] initWithString: string];
}

+ (MVPReader *) readerWithContentsOfFile: (NSString *) filename {
    return [[[self class] alloc] initWithContentsOfFile: filename];
}

+ (MVPReader *) readerWithContentsOfURL: (NSURL *) url {
    return [[[self class] alloc] initWithContentsOfURL: url];
}

- (id) init {
    if (self = [super init]) {
        _position = 0;
        _positionStack = [NSMutableArray new];
    }
    return self;
}

- (id) initWithString: (NSString *) string {
    if (self = [self init]) {
        _string = [string copy];
    }
    return self;
}

- (id) initWithContentsOfFile: (NSString *) filename {
    if (self = [self init]) {
        _string = [NSString stringWithContentsOfFile: filename encoding: NSUnicodeStringEncoding error: nil];
    }
    return self;
}

- (id) initWithContentsOfURL: (NSURL *) url {
    if (self = [self init]) {
        _string = [NSString stringWithContentsOfURL: url encoding: NSUnicodeStringEncoding error: nil];
    }
    return self;
}

#pragma mark -
#pragma mark Служебные

- (NSString *) description {
    if (_position == 0) {
        return [NSString stringWithFormat: @"|%@", _string];
    } else
    if ([self endOfData]) {
        return [NSString stringWithFormat: @"%@|", _string];
    } else {
        return [NSString stringWithFormat: @"%@|%@", [_string substringToIndex: _position], [_string substringFromIndex: _position]];
    }
}

@end
