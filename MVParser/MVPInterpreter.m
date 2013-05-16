//
//  MVPInterpreter.m
//  MVParser
//

#import "MVPTools.h"

#import "MVPInterpreter.h"
#import "MVPTokenProgram.h"

#import "MVPTokenStatement.h"

@implementation MVPInterpreter

- (Boolean) parseFromReader: (MVPReader *) reader {
    NSMutableSet * validStatements = [NSMutableSet new];
    Boolean flag = true;
    MVPToken * token;
    MVPToken <MVPTokenStatementProtocol> * prevToken = nil;
    MVPTokenStatement * definition = nil;
    NSUInteger length;
    
    while (flag) {
        [validStatements removeAllObjects];
        for (MVPTokenStatement * def in _language.definition) {
            [reader savePosition];
            DLog(@"R: %@", reader);
            token = [def interpreter: self readFromReader: reader];
            if (token) {
                length = token.length + [reader skipCharactersInSet: self.language.whiteSpaces];
                NSUInteger separatorLength = [self parseEndOfStatementFromReader: reader];
                length += separatorLength;
                if (separatorLength) {
                    definition = def;
                    [validStatements addObject: definition];
                } else {
                    DLog(@"Missing end of statement sequence.");
                }
            }
            [reader restorePosition];
        }
        flag = validStatements.count == 1;
        if (flag) {
            DLog(@"I: %@", token);
            if (prevToken) {
                DAssertPrototol(token, MVPTokenStatementProtocol);
                prevToken.nextExecutableToken = res;
            }
            DAssertPrototol(token, MVPTokenStatementProtocol);
            [_program.statements addObject: res];
            reader.position += length + 1;
            prevToken = res;
        } else {
            if (!reader.endOfData) {
                DLog(@"Error!");
            }
            break;
        }
    }
    return reader.endOfData;
}

- (NSUInteger) parseEndOfStatementFromReader: (MVPReader *) reader {
    for (NSString * separator in self.language.statementSeparators) {
        [reader savePosition];
        if (![reader endOfData] && ([reader readStringUntilString: separator].length == 0)) {
            [reader commitPosition];
            return separator.length;
        }
        [reader restorePosition];
    }
    return 0;
}

#pragma mark -
#pragma mark Инициализация

+ (MVPInterpreter *) interpreterWithLanguage: (MVPLanguage *) language {
    return [[[self class] alloc] initWithLanguage: language];
}

- (id) initWithLanguage: (MVPLanguage *) language {
    if (self = [self init]) {
        _language = language;
        _program = [MVPTokenProgram new];
    }
    return self;
}


@end
