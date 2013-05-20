//
//  MVPTokenVariable.m
//  MVParser
//

#import "MVPTools.h"

#import "MVPInterpreter.h"
#import "MVPTokenVariable.h"

@implementation MVPTokenVariable {}

#pragma mark -
#pragma mark Интерпретация

- (Class) tokenClass {
    return [MVPTokenVariable class];
}

- (MVPToken *) interpreter: (MVPInterpreter *) interpreter readFromReader: (MVPReader *) reader {

    [reader readRegExArray: interpreter.language.whiteSpaces options: 0];

    NSString * value = [reader readRegEx: @"$[_a-zA-Z][_a-zA-Z0-9]*" options: 0];
    if (value) {
        DAssertClass([[self class] tokenWithInterpreter: interpreter], MVPTokenVariable, res);
        res.variable = [interpreter.program variableWithName: value];
        res.startPosition = reader.position - value.length;
        res.length = value.length;
        return res;
    } else {
        return nil;
    }
}

#pragma mark -
#pragma mark Выполнение

- (MVPValue *) value {
    return self.variable.value;
}

- (void) setValue: (MVPValue *) value {
    self.variable.value = value;
}

@end
