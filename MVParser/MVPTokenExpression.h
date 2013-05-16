//
//  MVPTokenExpression.h
//  MVParser
//

#import "MVPTokenStatementWithValue.h"

@interface MVPTokenExpression : MVPTokenStatementWithValue

#pragma mark -
#pragma mark Интерпретация

#pragma mark -
#pragma mark Выполнение

@property (readonly) NSMutableArray * prepared;

@end
