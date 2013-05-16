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

- (unichar) readCharacter {
    if ([self endOfData]) {
        return MVPReaderEndOfData; // признак окончания данных
    } else {
        return [_string characterAtIndex: _position++];
    }
}

- (NSString *) readStringCharacter {
    if ([self endOfData]) {
        return nil; // признак окончания данных
    } else {
        return [_string substringWithRange: NSMakeRange(_position++, 1)];
    }
}

- (NSString *) readStringWithBlock: (MVPReaderReadStringBlock) block {
    NSString * c;
    NSString * currentString = @"";
    Boolean done = false;
    Boolean error = false;
    NSUInteger index = 0;
    
    // сохраняем позицию для последующего восстановления если что-то пойдет не так
    [self savePosition];
    
    while (!done && !error) {
        if ((c = [self readStringCharacter])) {
            NSString * tempString = [currentString stringByAppendingString: c];
            done = block(tempString, c, index++, &error);
            if (!done && !error) {
                currentString = tempString;
            }
        } else {
            // результат блока нам не важен, так как мы просто
            // информируем его о том, что данные кончились            
            block(currentString, nil, index, &error);
            done = true;
        }
    }
    
    // если мы не дошли до конца, значит мы "захватили лишний символ",
    // возвращаем позицию на один символ обратно
    if (done && !error && c) {
        [self unread];
    }
    
    if (error || !currentString.length) {
        // если произошла ошибка, значит нам нужно восстановить позицию на ту,
        // которую мы запомнили в начале метода и венуть nil
        [self restorePosition];
        return nil;
    } else {
        // фиксируем текщую позицию и возвращаем накопленную строку
        [self commitPosition];
        return [currentString copy];
    }
}

// метод, аналогичный предыдущему, но для unichar
- (NSString *) readCharacterStringWithBlock: (MVPReaderReadCharacterStringBlock) block {
    unichar c;
    NSString * currentString = @"";
    Boolean done = false;
    Boolean error = false;
    NSUInteger index = 0;
    
    [self savePosition];
    
    while (!done && !error) {
        c = [self readCharacter];
        if (c != MVPReaderEndOfData) {
            NSString * tempString = [currentString stringByAppendingFormat: @"%c", c];
            done = block(tempString, c, index++, &error);
            if (!done && !error) {
                currentString = tempString;
            }
        } else {
            block(currentString, MVPReaderEndOfData, index, &error);
            done = true;
        }
    }
    
    if (done && !error && (c != MVPReaderEndOfData)) {
        [self unread];
    }
    
    if (error || !currentString.length) {
        [self restorePosition];
        return nil;
    } else {
        [self commitPosition];
        return currentString;
    }
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

- (NSString *) readStringUntilCharacter: (unichar) stopCharacter {
    return [self readCharacterStringWithBlock: ^Boolean(NSString * string, unichar character, NSUInteger characterIndex, Boolean * error) {
        return character == stopCharacter;
    }];
}

- (NSString *) readStringUntilCharacterInString: (NSString *) stopCharacterSet {
    NSCharacterSet * charSet = [NSCharacterSet characterSetWithCharactersInString: stopCharacterSet];
    
    return [self readCharacterStringWithBlock: ^Boolean(NSString * string, unichar character, NSUInteger characterIndex, Boolean * error) {
        return [charSet characterIsMember: character];
    }];
}

- (NSString *) readStringUntilString: (NSString *) stopString {
    return [self readCharacterStringWithBlock: ^Boolean(NSString * string, unichar character, NSUInteger characterIndex, Boolean * error) {
        return [string rangeOfString: stopString].length > 0;
    }];
}

- (void) unread {
    --self.position;
}

- (Boolean) endOfData {
    return (self.position >= _string.length);
}

- (NSUInteger) skipCharactersInSet: (NSCharacterSet *) characters {
    return [self readCharacterStringWithBlock: ^Boolean(NSString * string, unichar character, NSUInteger characterIndex, Boolean * error) {
        return ![characters characterIsMember: character];
    }].length;
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

+ (MVPReader *) stringWithString: (NSString *) string {
    return [[[self class] alloc] initWithString: string];
}

+ (MVPReader *) stringWithContentsOfFile: (NSString *) filename {
    return [[[self class] alloc] initWithContentsOfFile: filename];
}

+ (MVPReader *) stringWithContentsOfURL: (NSURL *) url {
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
