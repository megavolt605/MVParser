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

    __block NSString * str;
    __block NSUInteger startPosition = 0;
    __block MVPLanguageExpressionOperator * found = nil;

    NSMutableArray * operators = [NSMutableArray arrayWithArray: interpreter.language.expressionOperators];
    [operators addObjectsFromArray:interpreter.language.expressionBrackets];

    [reader skipCharactersInSet: interpreter.language.whiteSpaces];

    str = [reader readCharacterStringWithBlock: ^Boolean(NSString * string, unichar character, NSUInteger characterIndex, Boolean * error) {

        NSUInteger leftCount = operators.count;
        if (characterIndex == 0) {
            startPosition = reader.position;
        }

        for (MVPLanguageExpressionOperator * operator in operators) {
            if ([operator.name isEqualToString: string]) {
                found = operator;
                return true;
            }
            if (operator.name.length <= str.length) {
                leftCount--;
            }
        }

        if (leftCount == 0) {
            *error = true;
            return true;
        }

        return false;
    }];

    if (str && found) {
        DAssertClass([[self class] tokenWithInterpreter: interpreter], MVPTokenExpressionOperator, res);
        res.operator = found;
        res.startPosition = startPosition;
        res.length = str.length;
        return res;
    } else {
        return nil;
    }
}

#pragma mark -
#pragma mark Выполнение

@end
