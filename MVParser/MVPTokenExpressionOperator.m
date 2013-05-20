//
//  MVPTokenExpressionOperator.m
//  MVParser
//

#import "MVPTools.h"

#import "MVPTokenExpressionOperator.h"
#import "MVPInterpreter.h"

@implementation MVPTokenExpressionOperator {}


#pragma mark -
#pragma mark Интерпретация

- (MVPToken *) interpreter: (MVPInterpreter *) interpreter readFromReader: (MVPReader *) reader {

    NSString * str;
    MVPLanguageExpressionOperator * found = nil;
    NSUInteger startPosiiton = reader.position;

    NSMutableArray * operators = [NSMutableArray arrayWithArray: interpreter.language.expressionOperators];
    [operators addObjectsFromArray:interpreter.language.expressionBrackets];

    [reader readRegExArray: interpreter.language.whiteSpaces options: 0];

    for (MVPLanguageExpressionOperator * operator in operators) {
        str = [reader readRegEx: operator.name options: NSRegularExpressionCaseInsensitive];
        if (str) {
            found = operator;
            break;
        }
    }

    if (str && found) {
        DAssertClass([[self class] tokenWithInterpreter: interpreter], MVPTokenExpressionOperator, res);
        res.operator = found;
        res.startPosition = startPosiiton;
        res.length = str.length;
        return res;
    } else {
        return nil;
    }
}

#pragma mark -
#pragma mark Выполнение

@end
