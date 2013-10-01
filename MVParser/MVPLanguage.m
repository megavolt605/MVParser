//
//  MVPLanguage.m
//  MVParser
//

#import "MVPTools.h"

#import "MVPLanguage.h"
#import "MVPLanguageExpressionOperator.h"

@implementation MVPLanguage

- (MVPLanguageExpressionOperator *) findExpressionOperatorByTag: (NSString *) tag {
    for (MVPLanguageExpressionOperator * operator in self.expressionOperators) {
        if ([operator.tag isEqualToString: tag]) {
            return operator;
        }
    }
    return nil;
}

- (MVPLanguageExpressionOperator *) findUnarExpressionOperatorByName: (NSString *) name {
    for (MVPLanguageExpressionOperator * operator in self.expressionOperators) {
        if (operator.isUnar && [operator.name isEqualToString: name]) {
            return operator;
        }
    }
    return nil;
}

- (Boolean) compareProrityExpressionOperator: (MVPLanguageExpressionOperator *) operator1
                                withOperator: (MVPLanguageExpressionOperator *) operator2 {
    NSInteger i1, i2;
    i1 = i2 = -1;
    MVPLanguageExpressionOperator * operator;
    for (int i = 0; i < self.expressionOperators.count; i++) {
        operator = self.expressionOperators[i];
        if ([operator.tag isEqualToString: operator1.tag]) i1 = i;
        if ([operator.tag isEqualToString: operator2.tag]) i2 = i;
        if (i1 >= 0 && i2 >= 0) break;
    }
    return (i1 >= i2);
}

- (MVPToken <MVPTokenStatementProtocol> *) executeCommand: (MVPTokenCommand *) command fromStatement: (MVPToken <MVPTokenizerProtocol> *) statement {
    DLog(@"Command {%@}: %@", command.commandName, ((MVPToken *) statement.tokens[1]).value);
    return command.nextExecutableToken;
}

#pragma mark -
#pragma mark Инициализация

- (id) init {
    if (self = [super init]) {
        _definition = [NSMutableArray new];
        
        _whiteSpaces = [NSArray arrayWithObject: @"\\s+"];
        _statementSeparators = [NSArray arrayWithObject: @"\\;"];
        _singleLineCommentBoundaries = [NSArray arrayWithObject: @"#"];
        _multilineCommentBoundaries = [NSArray arrayWithObjects: @"/*", @"*/", nil];
        _constants = [NSArray arrayWithObjects: @"[-+]?([0-9]*\\.[0-9]*|[0-9]+)",  @"'.*'"
                      //@"\"([^\"]|(\\\\\"))*\""
                      //@"(''(?:[^''\r\n]*(?:'''')*[^''\r\n]*)*?''(?!'')|\"(?:[^\"\r\n]*(?:"")*[^\"\r\n]*)*?\"(?!\"))"
                      //@"(?<=\\').*(?=\\')"
                      //@"(?<='abc')"
                      , nil];
        _commands = [NSArray new];

        _reservedWords = [NSArray new];
        
        // операторы указаны в порядке возрастания приоритета выполнения
        _expressionOperators = [NSMutableArray arrayWithObjects:
                                [MVPLanguageExpressionOperatorUnarPlus new],
                                [MVPLanguageExpressionOperatorUnarMinus new],
                                [MVPLanguageExpressionOperatorPlus new],
                                [MVPLanguageExpressionOperatorMinus new],
                                [MVPLanguageExpressionOperatorMultiply new],
                                [MVPLanguageExpressionOperatorDivide new],
                                [MVPLanguageExpressionOperatorPower new],
                                [MVPLanguageExpressionOperatorModule new],
                                nil];
        _expressionBrackets = [NSMutableArray arrayWithObjects:
                               [MVPLanguageExpressionOperatorBracketOpen new],
                               [MVPLanguageExpressionOperatorBracketClose new],
                               nil];
    }
    return self;
}

@end
