//
//  MVPAkslop.h
//  MVParser
//

#import <Foundation/Foundation.h>
#import "MVPLanguage.h"
#import "MVPReader.h"
#import "MVPTokenExpression.h"

@interface MVPAkslop : NSObject

@property (weak) MVPLanguage * language;

- (void) prepareExpression: (MVPTokenExpression *) expression;

+ (MVPAkslop *) akslopWithLanguage: (MVPLanguage *) language;
- (id) initWithLanguage: (MVPLanguage *) language;

@end
