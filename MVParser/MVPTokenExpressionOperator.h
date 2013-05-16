//
//  MVPTokenExpressionOperator.h
//  MVParser
//

#import "MVPToken.h"
#import "MVPLanguageExpressionOperator.h"

@interface MVPTokenExpressionOperator : MVPToken {}

#pragma mark -
#pragma mark Интерпретация

#pragma mark -
#pragma mark Выполнение

@property (weak) MVPLanguageExpressionOperator * operator;

@end
