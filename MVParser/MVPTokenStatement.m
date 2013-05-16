//
//  MVPTokenStatement.m
//  MVParser
//

#import "MVPTokenStatement.h"

#import "MVPTools.h"

@implementation MVPTokenStatement {}
#pragma mark -
#pragma mark Интерпретация

- (MVPToken *) interpreter: (MVPInterpreter *) interpreter readFromReader: (MVPReader *) reader {
    return [self.tokenizer interpreter: interpreter readFromReader: reader forTokenDef: self];
}

#pragma mark -
#pragma mark Выполнение

- (NSUInteger) startPosition {
    MVPToken * token = self.tokens[0];
    return token.startPosition;
}

- (NSUInteger) length {
    MVPToken * token = self.tokens[self.tokens.count - 1];
    return token.startPosition + token.length - self.startPosition;
}

- (void) addTokensToArray: (NSMutableArray *) array {
    for (MVPToken * token in self.tokens) {
        if ([token conformsToProtocol: @protocol(MVPTokenizerProtocol)]) {
            [(id <MVPTokenizerProtocol>) token addTokensToArray: array];
        } else {
            [array addObject: token];
        }
    }
}

- (NSArray *) flatternTokens {
    NSMutableArray * res = [NSMutableArray new];
    [self addTokensToArray: res];
    return res;
}

#pragma mark -
#pragma mark Протокол MVPTokenExecutableProtocol

- (MVPToken <MVPTokenStatementProtocol> *) executeFromStatement: (MVPTokenStatement *) statement {
    MVPToken * tempToken = self.tokens[0];
    DAssertPrototol(tempToken, MVPTokenStatementProtocol);
    res = [res executeFromStatement: self];
    if (res) {
        return res;
    } else {
        return self.nextExecutableToken;
    }
}

#pragma mark -
#pragma mark Протокол MVPTokenizerProtocol

- (void) assignTokensFromArray: (NSArray *) array {
    for (MVPToken * token in array) {
        [self.tokens addObject: token];
    }
}

#pragma mark -
#pragma mark Инициализация

- (id) init {
    if (self =[super init]) {
        _tokens = [NSMutableArray new];
        _tokenizer = [MVPTokenizer new];
    }
    return self;
}

#pragma mark -
#pragma Служебные

- (NSString *) description {
    return [NSString stringWithFormat: @"%@: %@", [self className], [_tokens componentsJoinedByString: @", "]];
}

@end
