//
//  MVPTokenExpression.m
//  MVParser
//

#import "MVPTools.h"
#import "MVPTokenExpression.h"
#import "MVPAkslop.h"
#import "MVPInterpreter.h"
#import "MVPTokenConstant.h"
#import "MVPTokenVariable.h"

@implementation MVPTokenExpression {}

#pragma mark -
#pragma mark Интерпретация

- (MVPToken *) interpreter: (MVPInterpreter *) interpreter readFromReader: (MVPReader *) reader {
    /*MVPAkslop * akslop = [MVPAkslop akslopWithLanguage: interpreter.language];
     return [akslop parseExpressionFromReader: reader];*/
    return [super interpreter: interpreter readFromReader: reader];
}

#pragma mark -
#pragma mark Выполнение

- (MVPValue *) value {
    if (_prepared.count == 0) {
        MVPAkslop * a = [MVPAkslop akslopWithLanguage: self.interpreter.language];
        [a prepareExpression: self];
    }
    return ((MVPToken <MVPTokenWithValue> *)self.prepared[0]).value;
}

#pragma mark -
#pragma mark Инициализация

- (id) init {
    if (self = [super init]) {
        // VALUE = CONST | VARIABLE
        // EXPR = ( VALUE | (OPERATOR VALUE) ) [ ( OPERATOR EXPR ) ]

        /*
         MVPTokenStatementDef * valueDef;
         MVPTokenStatementDef * operatorValueDef;
         MVPTokenStatementDef * operatorExprDef;
         MVPTokenStatementDef * valueOperatorValueDef;

         // CONST | VARIABLE
         valueDef = [MVPTokenStatementDef new];
         valueDef.rootToken = [MVPTokenConstant new];
         [valueDef addTokenDef: [MVPTokenVariableDef new] withCondition: sdcOr];

         // OPERATOR VALUE
         operatorValueDef = [MVPTokenStatementDef new];
         operatorValueDef.rootToken = [MVPTokenExpressionOperatorDef new];
         [operatorValueDef addTokenDef: valueDef withCondition: sdcAnd];

         // VALUE | ( OPERATOR VALUE )
         valueOperatorValueDef = [MVPTokenStatementDef new];
         valueOperatorValueDef.rootToken = valueDef;
         [valueOperatorValueDef addTokenDef: operatorValueDef withCondition: sdcOr];

         operatorExprDef = [MVPTokenStatementDef new];
         operatorExprDef.rootToken = [MVPTokenExpressionOperatorDef new];
         operatorExprDef.isOptional = true;
         [operatorExprDef addTokenDef: self withCondition: sdcAnd];

         self.rootToken = valueOperatorValueDef;
         [self addTokenDef: operatorExprDef withCondition: sdcAnd];
         */
        self.tokenizer.rootTokenDef = [MVPTokenConstant new];
        [self.tokenizer addTokenDef: [MVPTokenVariable new] withCondition: sdcOr];

        _prepared = [NSMutableArray new];
    }
    return self;
}

@end
