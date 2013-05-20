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
    NSUInteger separatorLength;
    
    while (flag) {
        [validStatements removeAllObjects];
        for (MVPTokenStatement * def in _language.definition) {
            [reader savePosition];
            DLog(@"R: %@", reader);
            token = [def interpreter: self readFromReader: reader];
            if (token) {
                [reader readRegExArray: self.language.whiteSpaces options: 0];
                length = reader.position - reader.lastSavedPosition;
                separatorLength = [self parseEndOfStatementFromReader: reader];
                length += separatorLength;
                if (separatorLength) {
                    definition = def;
                    [validStatements addObject: definition];
                } else {
                    DLog(@"Missing end of statement sequence.");
                    DLog(@"R: %@", reader);
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
            reader.position += length;
            prevToken = res;
        } else {
            [reader readRegExArray: self.language.whiteSpaces options: 0];
            if (!reader.endOfData) {
                DLog(@"Error!");
                return false;
            }
            return true;
        }
    }
    return reader.endOfData;
}

- (NSUInteger) parseEndOfStatementFromReader: (MVPReader *) reader {
    return [reader readRegExArray: self.language.statementSeparators options: 0].length;
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
