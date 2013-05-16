//
//  MVPToken.m
//  MVParser
//


#import "MVPTools.h"

#import "MVPToken.h"

@implementation MVPToken {}

#pragma mark -
#pragma mark Интерпретация

- (MVPToken *) interpreter: (MVPInterpreter *) interpreter readFromReader: (MVPReader *) reader {
    AbstractError;
    return nil;
}

#pragma mark -
#pragma mark Выполнение

#pragma mark -
#pragma mark Инициализация

+ (MVPToken *) tokenWithInterpreter: (MVPInterpreter *) interpreter {
    return [[[self class] alloc] initWithInterpreter: interpreter];
}

- (id) initWithInterpreter: (MVPInterpreter *) interpreter {
    if (self = [self init]) {
        _interpreter = interpreter;
    }
    return self;
}

+ (MVPToken *) tokenDefWithLanguage: (MVPLanguage *) language {
    return [[[self class] alloc] initWithLanguage: language];
}

- (id) initWithLanguage: (MVPLanguage *) language {
    if (self = [self init]) {
        _language = language;
    }
    return self;
}


#pragma mark -
#pragma Служебные

- (NSString *) description {
    return [NSString stringWithFormat: @"%@, abstract description", [self className]];
}

#pragma mark -
#pragma mark Протокол NSCoding

- (void) encodeWithCoder: (NSCoder *) aCoder {
    // сохраняем свойства
    //[aCoder encodeObject: ...];
}

- (id) initWithCoder: (NSCoder *) aDecoder {
    if (self = [self init]) {
        // читаем свойства
        // _prop = [aDecoder decodeObject];
    }
    return self;
}

@end
