//
//  MVPLanguageExpressionOperator.h
//  MVParser
//

#import <Foundation/Foundation.h>

@interface MVPLanguageExpressionOperator : NSObject

@property (readonly) NSString * name;
@property (readonly) NSString * tag;
@property (readonly) Boolean isUnar;

@end

// Операторы

// Бинарные
@interface MVPLanguageExpressionOperatorPlus        : MVPLanguageExpressionOperator @end
@interface MVPLanguageExpressionOperatorMinus       : MVPLanguageExpressionOperator @end
@interface MVPLanguageExpressionOperatorMultiply    : MVPLanguageExpressionOperator @end
@interface MVPLanguageExpressionOperatorDivide      : MVPLanguageExpressionOperator @end
@interface MVPLanguageExpressionOperatorPower       : MVPLanguageExpressionOperator @end
@interface MVPLanguageExpressionOperatorModule      : MVPLanguageExpressionOperator @end

// Унарные
@interface MVPLanguageExpressionOperatorUnar        : MVPLanguageExpressionOperator     @end
@interface MVPLanguageExpressionOperatorUnarPlus    : MVPLanguageExpressionOperatorUnar @end
@interface MVPLanguageExpressionOperatorUnarMinus   : MVPLanguageExpressionOperatorUnar @end

// Скобки
@interface MVPLanguageExpressionOperatorBracket     : MVPLanguageExpressionOperator        @end
@interface MVPLanguageExpressionOperatorBracketOpen : MVPLanguageExpressionOperatorBracket @end
@interface MVPLanguageExpressionOperatorBracketClose: MVPLanguageExpressionOperatorBracket @end
