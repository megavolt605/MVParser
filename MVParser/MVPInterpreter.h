//
//  MVPInterpreter.h
//  MVParser
//

#import <Foundation/Foundation.h>

#import "MVPReader.h"
#import "MVPTokenStatement.h"
#import "MVPLanguage.h"
#import "MVPTokenProgram.h"

@interface MVPInterpreter : NSObject

+ (MVPInterpreter *) interpreterWithLanguage: (MVPLanguage *) language;
- (id) initWithLanguage: (MVPLanguage *) language;

- (Boolean) parseFromReader: (MVPReader *) reader;

@property (strong) MVPLanguage * language;
@property (strong) MVPTokenProgram * program;

@end
