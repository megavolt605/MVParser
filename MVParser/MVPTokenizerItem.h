//
//  MVPTokinizerItem.h
//  MVParser
//

#import <Foundation/Foundation.h>

#import "MVPToken.h"

typedef enum {
    sdcRoot,
    sdcOr,
    sdcAnd
} MVPTokenStatementDefCondition;

@interface MVPTokenizerItem : NSObject

+ (MVPTokenizerItem *) statementItemWithTokenDef: (MVPToken *) tokenDef andCondition: (MVPTokenStatementDefCondition) condition;
- (id) initWithTokenDef: (MVPToken *) tokenDef andCondition: (MVPTokenStatementDefCondition) condition;

@property MVPToken * tokenDef;
@property MVPTokenStatementDefCondition condition;

@end

