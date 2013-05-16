//
//  MVPTokenSymbols.h
//  MVParser
//

#import "MVPToken.h"

@interface MVPTokenSymbols : MVPToken {}

#pragma mark -
#pragma mark Интерпретация

+ (MVPTokenSymbols *) symbolsDefWithLanguage: (MVPLanguage *) language regExPattern: (NSString *) regExPattern;
- (id) initWithLanguage: (MVPLanguage *) language regExPattern: (NSString *) regExPattern;

@property NSString * regExPattern;

#pragma mark -
#pragma mark Выполнение

@property NSString * symbols;

@end
