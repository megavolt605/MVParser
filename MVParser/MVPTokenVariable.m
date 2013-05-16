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

    __block NSString * str;
    __block Boolean isError = false;
    __block NSUInteger startPosition = 0;
    __block NSUInteger length = 0;
    NSCharacterSet * validChars = [NSCharacterSet characterSetWithCharactersInString: @"_QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm0123456789"];

    [reader skipCharactersInSet: interpreter.language.whiteSpaces];

    str = [reader readCharacterStringWithBlock: ^Boolean(NSString * string, unichar character, NSUInteger characterIndex, Boolean * error) {
        Boolean validChar;
        if (characterIndex == 0) {
            validChar = character = '$';
            startPosition = reader.position - 1;
        } else {
            validChar = [validChars characterIsMember: character];
        }
        if (validChar) {
            str = string;
            return false;
        } else {
            if (characterIndex == 0) {
                *error = true;
                isError = true;
            } else {
                length = reader.position - startPosition - 1;
            }
            return true;
        }
    }];
    if (str && !isError) {
        DAssertClass([[self class] tokenWithInterpreter: interpreter], MVPTokenVariable, res);
        // to-do: поиск переменных по видимости
        res.variable = [interpreter.program variableWithName: str];
        res.startPosition = startPosition;
        res.length = length;
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
