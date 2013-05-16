//
//  MVPTokenizer.m
//  MVParser
//

#import "MVPTools.h"
#import "MVPTokenizer.h"
#import "MVPTokenStatement.h"

@implementation MVPTokenizer

- (void) setRootTokenDef: (MVPToken *) rootTokenDef {
    [_items removeAllObjects];
    [_items addObject: [MVPTokenizerItem statementItemWithTokenDef: rootTokenDef andCondition: sdcRoot]];
}

- (MVPToken *) rootTokenDef {
    if (_items.count > 0) {
        return ((MVPTokenizerItem *)_items[0]).tokenDef;
    } else {
        return nil;
    }
}

- (MVPTokenizerItem *) addTokenDef: (MVPToken *) tokenDef withCondition: (MVPTokenStatementDefCondition) condition {
    MVPTokenizerItem * item = [MVPTokenizerItem statementItemWithTokenDef: tokenDef andCondition: condition];
    [_items addObject: item];
    return item;
}

- (MVPToken *) interpreter: (MVPInterpreter *) interpreter readFromReader: (MVPReader *) reader forTokenDef: (MVPToken *) tokenDef {
    NSMutableArray * validTokens = [NSMutableArray new];
    Boolean error = false;

    DLogEnter();

    for (MVPTokenizerItem * item in self.items) {
        MVPToken * token = nil;
        if (item.condition == sdcOr && validTokens.count) {
            break;
        }

        [reader savePosition];

        DHLog(@"S: Reader state: %@", reader);
        DHLog(@"S: Try tokenDef %@", [item.tokenDef class]);

        token = [item.tokenDef interpreter: interpreter readFromReader: reader];
        error = false;

        if (token) {
            DHLog(@"S: Reader state: %@", reader);
            DHLog(@"S: Found token: %@", [token class]);
        }

        if (!token) {
            error = !item.tokenDef.isOptional;// || item.condition == sdcAnd;
        } else {
            error = false;
        }

        if (!error && token) {
            [validTokens addObject: token];
            [reader commitPosition];
        } else {
            [reader restorePosition];
        }

        if (error) {
            break;
        }
    }

    if (error && !reader.endOfData) {
        DLog(@"S: %@, error", self);
    }

    DLogLeave();

    if (!error && validTokens.count > 0) {
        MVPToken * tmp = [[tokenDef class] tokenWithInterpreter: interpreter];
        DAssertPrototol(tmp, MVPTokenizerProtocol);
        [res assignTokensFromArray: validTokens];
        return res;
    } else {
        return nil;
    }
}

#pragma mark -
#pragma mark Инициализация

- (id) init {
    if (self = [super init]) {
        _items = [NSMutableArray new];
    }
    return self;
}

@end
