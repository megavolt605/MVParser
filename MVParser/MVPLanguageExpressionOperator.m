//
//  MVPLanguageExpressionOperator.m
//  MVParser
//

#import "MVPTools.h"
#import "MVPLanguageExpressionOperator.h"

@implementation MVPLanguageExpressionOperator

- (NSString *) name {
    AbstractError;
    return nil;
}

- (NSString *) tag {
    return self.name;
}

- (Boolean) isUnar {
    return false;
}

@end

#pragma mark -
#pragma mark Скобки

@implementation MVPLanguageExpressionOperatorBracket : MVPLanguageExpressionOperator @end

@implementation MVPLanguageExpressionOperatorBracketOpen : MVPLanguageExpressionOperatorBracket

- (NSString *) name { return @"("; }

@end

@implementation MVPLanguageExpressionOperatorBracketClose : MVPLanguageExpressionOperatorBracket

- (NSString *) name { return @")"; }

@end

#pragma mark -
#pragma mark Операторы
#pragma mark Бинарные

@implementation MVPLanguageExpressionOperatorPlus : MVPLanguageExpressionOperator

- (NSString *) name { return @"+"; }

@end

@implementation MVPLanguageExpressionOperatorMinus : MVPLanguageExpressionOperator

- (NSString *) name { return @"-"; }

@end

@implementation MVPLanguageExpressionOperatorMultiply : MVPLanguageExpressionOperator

- (NSString *) name { return @"*"; }

@end

@implementation MVPLanguageExpressionOperatorDivide : MVPLanguageExpressionOperator

- (NSString *) name { return @"/"; }

@end

@implementation MVPLanguageExpressionOperatorPower : MVPLanguageExpressionOperator

- (NSString *) name { return @"^"; }

@end

@implementation MVPLanguageExpressionOperatorModule : MVPLanguageExpressionOperator

- (NSString *) name { return @"%"; }

@end

#pragma mark Унарные

@implementation MVPLanguageExpressionOperatorUnar : MVPLanguageExpressionOperator

- (Boolean) isUnar { return true; }

@end

@implementation MVPLanguageExpressionOperatorUnarPlus : MVPLanguageExpressionOperatorUnar

- (NSString *) name { return @"+"; }
- (NSString *) tag { return @"%MVP%+++%MVP%"; }

@end

@implementation MVPLanguageExpressionOperatorUnarMinus : MVPLanguageExpressionOperatorUnar

- (NSString *) name { return @"-"; }
- (NSString *) tag { return @"%MVP%---%MVP%"; }

@end
