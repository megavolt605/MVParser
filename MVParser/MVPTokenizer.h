//
//  MVPTokenizer.h
//  MVParser
//

#import <Foundation/Foundation.h>

#import "MVPToken.h"
#import "MVPTokenizerItem.h"

@protocol MVPTokenizerProtocol <NSObject>

- (void) assignTokensFromArray: (NSArray *) array;
- (NSMutableArray *) flatternTokens;
- (void) addTokensToArray: (NSMutableArray *) array;

@property (readonly) NSMutableArray * tokens;

@end

@interface MVPTokenizer : NSObject

- (MVPTokenizerItem *) addTokenDef: (MVPToken *) tokenDef withCondition: (MVPTokenStatementDefCondition) condition;
- (MVPToken *) interpreter: (MVPInterpreter *) interpreter readFromReader: (MVPReader *) reader forTokenDef: (MVPToken *) tokenDef;

@property MVPToken * rootTokenDef;
@property (readonly) NSMutableArray * items;

@end
