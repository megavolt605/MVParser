//
//  MVPTokenStatementWithValue.h
//  MVParser
//

#import "MVPTokenizer.h"
#import "MVPToken.h"

@interface MVPTokenStatementWithValue : MVPToken <MVPTokenizerProtocol, MVPTokenWithValue>

#pragma mark -
#pragma mark Интерпретация

@property (readonly) MVPTokenizer * tokenizer;

#pragma mark -
#pragma mark Выполнение

- (NSUInteger) startPosition;
- (NSUInteger) length;

@property (readonly) NSMutableArray * tokens;

@end
