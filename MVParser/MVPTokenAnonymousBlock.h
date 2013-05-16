//
//  MVPTokenAnonymousBlock.h
//  MVParser
//


#import "MVPToken.h"

@interface MVPTokenAnonymousBlock : MVPToken <MVPTokenExecutableProtocol>

#pragma mark -
#pragma mark Интерпретация

#pragma mark -
#pragma mark Выполнение

- (MVPVariable *) variableWithName: (NSString *) name;
- (void) run;

@property NSMutableArray * statements;
@property NSMutableArray * localVariables;

@end
