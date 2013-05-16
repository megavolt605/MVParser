//
//  MVPTokinizerItem.m
//  MVParser
//

#import "MVPTokenizerItem.h"

@implementation MVPTokenizerItem

#pragma mark -
#pragma mark Инициализация

+ (MVPTokenizerItem *) statementItemWithTokenDef: (MVPToken *) tokenDef andCondition: (MVPTokenStatementDefCondition) condition {
    return [[[self class] alloc] initWithTokenDef: tokenDef andCondition: condition];
}

- (id) initWithTokenDef: (MVPToken *) tokenDef andCondition: (MVPTokenStatementDefCondition) condition {
    if (self = [self init]) {
        _tokenDef = tokenDef;
        _condition = condition;
    }
    return self;
}

@end
