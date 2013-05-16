//
//  MVPTokenAnonymousBlock.m
//  MVParser
//


#import "MVPTools.h"

#import "MVPTokenAnonymousBlock.h"

@implementation MVPTokenAnonymousBlock {}

#pragma mark -
#pragma mark Интерпретация

#pragma mark -
#pragma mark Выполнение

- (void) addStatement: (MVPToken <MVPTokenExecutableProtocol> *) statement {
    [_statements addObject: statement];
}

- (MVPVariable *) variableWithName: (NSString *) name {
    for (MVPVariable * variable in self.localVariables) {
        if ([name isEqualToString: variable.name]) {
            return variable;
        }
    }
    return nil;
}

- (void) run {
    if (self.statements.count) {
        MVPToken * token = self.statements[0];

        DAssertPrototol(token, MVPTokenStatementProtocol);
        DLog(@"Strated");
        while (res) {
            res = [res executeFromStatement: nil];
        }
        DLog(@"Finished");
    } else {
        DLog(@"Empty program");
    }
}

#pragma mark -
#pragma mark Инициализация

- (id) init {
    if (self = [super init]) {
        _statements = [NSMutableArray new];
        _localVariables = [NSMutableArray new];
    }
    return self;
}

#pragma mark -
#pragma mark Служебные

- (NSString *) description {
    return [self.statements componentsJoinedByString: @"\n"];
}

@end
