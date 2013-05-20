//
//  MVPLanguage.h
//  MVParser
//

#import <Foundation/Foundation.h>
#import "MVPLanguageExpressionOperator.h"
#import "MVPToken.h"
#import "MVPTokenCommand.h"
#import "MVPTokenizer.h"

@class MVPInterpreter;

@interface MVPLanguage : NSObject 

- (MVPLanguageExpressionOperator *) findExpressionOperatorByTag: (NSString *) tag;
- (MVPLanguageExpressionOperator *) findUnarExpressionOperatorByName: (NSString *) name;
- (Boolean) compareProrityExpressionOperator: (MVPLanguageExpressionOperator *) operator1
                                withOperator: (MVPLanguageExpressionOperator *) operator2;
- (MVPToken <MVPTokenStatementProtocol> *) executeCommand: (MVPTokenCommand *) command fromStatement: (MVPToken <MVPTokenizerProtocol> *) statement;

@property NSMutableArray * definition;
@property (weak) MVPInterpreter * interpreter;

@property (readonly) NSArray * whiteSpaces;                 // array of NSString
@property (readonly) NSArray * statementSeparators;         // array of NSString
@property (readonly) NSArray * singleLineCommentBoundaries; // array of NSString
@property (readonly) NSArray * multilineCommentBoundaries;  // array of NSString pairs
@property (readonly) NSArray * constants;                   // array of NSString
@property (readonly) NSArray * commands;                    // array of NSString
@property (readonly) NSArray * reservedWords;               // array of NSString

@property (readonly) NSArray * expressionOperators;         // array of MVPLanguageExpressionOperator
@property (readonly) NSArray * expressionBrackets;          // array of MVPLanguageExpressionOperator

@end
