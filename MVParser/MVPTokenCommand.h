//
//  MVPTokenCommand.h
//  MVParser
//

#import "MVPTokenStatement.h"

@interface MVPTokenCommand : MVPToken <MVPTokenStatementProtocol>

@property NSString * commandName;

#pragma mark -
#pragma mark Интерпретация

+ (MVPTokenCommand *) commandDefWithLanguage: (MVPLanguage *) language commandName: (NSString *) commandName;
- (id) initWithLanguage: (MVPLanguage *) language commandName: (NSString *) commandName;

#pragma mark -
#pragma mark Выполнение

@property MVPToken <MVPTokenStatementProtocol> * nextExecutableToken;

@end