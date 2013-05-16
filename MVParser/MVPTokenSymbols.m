//
//  MVPTokenSymbols.m
//  MVParser
//

#import "MVPTools.h"
#import "MVPTokenSymbols.h"

@implementation MVPTokenSymbols {}

#pragma mark -
#pragma mark Интерпретация

- (Class) tokenClass {
    return [MVPTokenSymbols class];
}

- (MVPToken *) interpreter: (MVPInterpreter *) interpreter readFromReader: (MVPReader *) reader {
    NSString * value = [reader readRegEx: _regExPattern options: 0];
    if (value) {
        DAssertClass([[self class] tokenWithInterpreter: interpreter], MVPTokenSymbols, res);
        res.symbols = value;
        res.startPosition = reader.position - value.length;
        res.length = value.length;
        return res;
    } else {
        return nil;
    }
}

#pragma mark -
#pragma mark Инициализация

+ (MVPTokenSymbols *) symbolsDefWithLanguage: (MVPLanguage *) language regExPattern: (NSString *) regExPattern {
    return [[MVPTokenSymbols alloc] initWithLanguage: language regExPattern: regExPattern];
}

- (id) initWithLanguage: (MVPLanguage *) language regExPattern: (NSString *) regExPattern {
    if (self = [self initWithLanguage: language]) {
        _regExPattern = regExPattern;
    }
    return self;
}

#pragma mark -
#pragma mark Выполнение

#pragma mark -
#pragma mark Служебные

- (NSString *) description {
    return [NSString stringWithFormat: @"%@, symbols = '%@'", [self className], self.symbols];
}

@end
