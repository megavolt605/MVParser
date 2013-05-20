//
//  MVPLanguageLogo.m
//  MVParser
//

#import "MVPTools.h"

#import "MVPLanguageLogo.h"

#import "MVPToken.h"

#import "MVPTokenStatement.h"
#import "MVPTokenCommand.h"
#import "MVPTokenConstant.h"
#import "MVPTokenExpression.h"
#import "MVPTokenSymbols.h"

@implementation MVPLanguageLogo

- (MVPToken <MVPTokenStatementProtocol> *) executeCommand: (MVPTokenCommand *) command fromStatement: (MVPToken <MVPTokenizerProtocol> *) statement {
    NSArray * flat = [statement flatternTokens];
    NSMutableArray * tmp = [NSMutableArray new];
    for (int i = 1; i < flat.count; i++) {
        MVPToken * token = flat[i];
        if ([token conformsToProtocol: @protocol(MVPTokenWithValue)]) {
            [tmp addObject: (MVPToken <MVPTokenWithValue> *)token.value];
        } else {
            //!! error
        }
    }
    DLog(@"%@", [tmp componentsJoinedByString: @""]);
    return command.nextExecutableToken;
}


#pragma mark -
#pragma mark Инициализация

- (id) init {
    if (self = [super init]) {
        
        MVPTokenStatement * expr, * expr1;

//        expr = [MVPTokenStatementDef new];
//        expr.tokenizer.rootTokenDef = [MVPTokenCommandDef commandDefWithLanguage: self commandName: @"PRINT"];
//        [expr.tokenizer addTokenDef: [MVPTokenExpressionDef tokenDefWithLanguage: self] withCondition: sdcAnd];
//        [self.definition addObject: expr];

        expr = [MVPTokenStatement new];
        expr.tokenizer.rootTokenDef = [MVPTokenCommand commandDefWithLanguage: self commandName: @"PRINT"];
        [expr.tokenizer addTokenDef: [MVPTokenExpression tokenDefWithLanguage: self] withCondition: sdcAnd];

        expr1 = [MVPTokenStatement new];
        expr1.isOptional = true;
        expr1.tokenizer.rootTokenDef = [MVPTokenSymbols symbolsDefWithLanguage: self regExPattern: @","];
        [expr1.tokenizer addTokenDef: [MVPTokenExpression tokenDefWithLanguage: self] withCondition: sdcAnd];
        
        [expr.tokenizer addTokenDef: expr1 withCondition: sdcAnd];

        [self.definition addObject: expr];




    }
    return self;
}

@end
