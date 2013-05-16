//
//  MVPTokenProtocols.h
//  MVParser
//

@class MVPToken, MVPTokenStatement, MVPVariable, MVPValue;

@protocol MVPTokenStatementProtocol <NSObject>

- (MVPToken <MVPTokenStatementProtocol> *) executeFromStatement: (MVPTokenStatement *) statement;

@property MVPToken <MVPTokenStatementProtocol> * nextExecutableToken;

@end

@protocol MVPTokenExecutableProtocol <NSObject>

- (MVPVariable *) variableWithName: (NSString *) name;
- (void) run;

@property NSMutableArray * statements;
@property NSMutableArray * localVariables;

@end

@protocol MVPTokenWithValue <NSObject>

@property MVPValue * value;

@end
