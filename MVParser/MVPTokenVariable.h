//
//  MVPTokenVariable.h
//  MVParser
//

#import "MVPToken.h"
#import "MVPVariable.h"

@interface MVPTokenVariable : MVPToken

#pragma mark -
#pragma mark Интерпретация

#pragma mark -
#pragma mark Выполнение

@property (weak) MVPVariable * variable;

@end
