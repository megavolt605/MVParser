//
//  MVPTokenStatement.h
//  MVParser
//

#import <Foundation/Foundation.h>

#import "MVPToken.h"
#import "MVPTokenizer.h"

@interface MVPTokenStatement : MVPToken <MVPTokenStatementProtocol, MVPTokenizerProtocol>

#pragma mark -
#pragma mark Интерпретация

@property (readonly) MVPTokenizer * tokenizer;

#pragma mark -
#pragma mark Выполнение

- (NSUInteger) startPosition;
- (NSUInteger) length;

@property MVPToken <MVPTokenStatementProtocol> * nextExecutableToken;
@property NSMutableArray * tokens;

@end
