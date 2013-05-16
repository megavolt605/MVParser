//
//  MVPTokenCommand.m
//  MVParser
//
x
#import "MVPTools.h"
#import "MVPInterpreter.h"
#import "MVPLanguage.h"
#import "MVPTokenizer.h"
#import "MVPTokenCommand.h"

@implementation MVPTokenCommand {}

#pragma mark -
#pragma mark Интерпретация

- (MVPToken *) interpreter: (MVPInterpreter *) interpreter readFromReader: (MVPReader *) reader {
    NSString * value = [reader readRegEx: @"[_a-zA-Z][_a-zA-Z0-9]*" options: 0];
    if (value && ([[value uppercaseString] isEqualToString: self.commandName])) {
        DAssertClass([[self class] tokenWithInterpreter: interpreter], MVPTokenCommand, res);
        res.commandName = value;
        res.startPosition = reader.position - value.length;
        res.length = value.length;
        return res;
    } else {
        return nil;
    }
}

#pragma mark -
#pragma mark Выполнение

#pragma mark -
#pragma mark Протокол MVPTokenExecutableProtocol

- (MVPToken <MVPTokenStatementProtocol> *) executeFromStatement: (MVPTokenStatement *) statement {
    return [self.interpreter.language executeCommand: self fromStatement: statement];
}

#pragma mark -
#pragma mark Инициализация

+ (MVPTokenCommand *) commandDefWithLanguage: (MVPLanguage *) language commandName: (NSString *) commandName {
    return [[[self class] alloc] initWithLanguage: language commandName: commandName];
}

- (id) initWithLanguage: (MVPLanguage *) language commandName: (NSString *) commandName {
    if (self = [super initWithLanguage: language]) {
        _commandName = [commandName uppercaseString];
    }
    return self;
}

#pragma mark -
#pragma Служебные

- (NSString *) description {
    return [NSString stringWithFormat: @"%@, name = %@", [self className], self.commandName];
}

@end
