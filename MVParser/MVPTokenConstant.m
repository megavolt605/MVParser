//
//  MVPTokenConstant.m
//  MVParser
//

#import "MVPTools.h"

#import "MVPValue.h"
#import "MVPInterpreter.h"
#import "MVPTokenConstant.h"

@implementation MVPTokenConstant {
    MVPValue * _internalValue;
}


#pragma mark -
#pragma mark Интерпретация

- (MVPToken *) interpreter: (MVPInterpreter *) interpreter readFromReader: (MVPReader *) reader {

    [reader readRegExArray: interpreter.language.whiteSpaces options: 0];

    NSString * value = [reader readRegExArray: interpreter.language.constants options: 0];
    if (value) {
        DAssertClass([[self class] tokenWithInterpreter: interpreter], MVPTokenConstant, res);
        res.value = [MVPValue valueWithString: value];
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
    return _internalValue;
}

- (void) setValue: (id) value {
    _internalValue = [value copy];
}

- (id) init {
    if (self = [super init]) {
        _internalValue = [MVPValue new];
    }
    return self;
}

#pragma mark -
#pragma Служебные

- (NSString *) description {
    return [NSString stringWithFormat: @"%@, value = %@", [self className], self.value];
}

@end
