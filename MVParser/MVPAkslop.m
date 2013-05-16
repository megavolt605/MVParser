//
//  MVPAkslop.m
//  MVParser
//

#import "NSMutableArray+MVParser.h"

#import "MVPAkslop.h"
#import "MVPTokenStatement.h"
#import "MVPTokenExpressionOperator.h"

@implementation MVPAkslop {
    MVPTokenExpression * _expression;
    MVPToken * _lastToken;
    NSMutableArray * _temp;
    NSMutableArray * _tempPrepared;
}

- (void) prepareExpressionOperator: (MVPTokenExpressionOperator *) operator {

    MVPToken * token;

    // если нам досталась закрывающая скобка, то нам необходимо найти ей открывающуюся пару
    // в процессе поиска все, что находилось до нее переносим в результирующий стэк
    if ([operator.operator.name isEqualToString: @")"]) {
        while (_temp.count > 0) {
            token = (MVPToken *) [_temp popObject];
            if ([token isKindOfClass: [MVPTokenExpressionOperator class]]) {
                if ([((MVPTokenExpressionOperator *) token).operator.name isEqualToString: @"("]) {
                    break;
                } else {
                    [_tempPrepared pushObject: token];
                }
            }
        }
    } else
        if ([operator.operator.name isEqualToString: @"("]) {
            [_temp pushObject: operator];
            _lastToken = operator;
        } else {
            /*MVPLanguageExpressionOperator * unar = [_language findUnarExpressionOperatorByName: operator.operator.name];
            if ((unar) && ((!_lastToken) || [_lastToken isKindOfClass: [MVPTokenExpressionOperator class]])) {
                symbol.value = operator.name;
                [_prepared push: symbol];
            } else {*/
            MVPLanguageExpressionOperator * op;// = [_language findExpressionOperatorByTag: operator.operator.tag];

            while (_tempPrepared.count > 0) {
                op = (MVPLanguageExpressionOperator *) [_tempPrepared popObject];

                if ([_language compareProrityExpressionOperator:operator.operator withOperator: op]) {
                    [_temp pushObject: op];
                } else {
                    [_tempPrepared pushObject: op];
                    break;
                }
            }
            [_temp pushObject: operator];
            _lastToken = operator;
//            }
        }
}

- (void) prepareTokenWithValue: (MVPToken <MVPTokenWithValue> *) token {
    [_tempPrepared pushObject: token];
    _lastToken = token;
}

- (void) prepareExpression: (MVPTokenExpression *) expression {

    _expression = expression;
    _lastToken = nil;

    [_expression.prepared removeAllObjects];

    _temp = [_expression flatternTokens];
    _tempPrepared = [NSMutableArray new];

    MVPToken * token;
    while (_temp.count > 0) {
        token = (MVPToken *)[_temp popObject];
        if ([token isKindOfClass: [MVPTokenExpressionOperator class]]) {
            [self prepareExpressionOperator: (MVPTokenExpressionOperator *) token];
        } else {
            if ([token conformsToProtocol: @protocol(MVPTokenWithValue)]) {
                [self prepareTokenWithValue: (MVPToken <MVPTokenWithValue> *) token];
            }
        }
    }

    [_tempPrepared pushObjectsFromStack: _temp];
    [_expression.prepared pushObjectsFromStack: _tempPrepared];
}

#pragma mark -
#pragma mark Инициализация

+ (MVPAkslop *) akslopWithLanguage: (MVPLanguage *) language {
    return [[[self class] alloc] initWithLanguage: language];
}

- (id) initWithLanguage: (MVPLanguage *) language {
    if (self = [self init]) {
        _language = language;
    }
    return self;
}

@end
