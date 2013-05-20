//
//  MVPString.h
//  MVParser
//
//  Обработка строки
//

static const unichar MVPReaderEndOfData = 0;

typedef Boolean(^MVPReaderReadStringBlock) (NSString * string, NSString * character, NSUInteger characterIndex, Boolean * error);
typedef Boolean(^MVPReaderReadCharacterStringBlock) (NSString * string, unichar character, NSUInteger characterIndex, Boolean * error);

@interface MVPReader : NSObject

+ (MVPReader *) readerWithString: (NSString *) string;
+ (MVPReader *) readerWithContentsOfFile: (NSString *) filename;
+ (MVPReader *) readerWithContentsOfURL: (NSURL *) url;

- (id) initWithString: (NSString *) string;
- (id) initWithContentsOfFile: (NSString *) filename;
- (id) initWithContentsOfURL: (NSURL *) url;

- (NSString *) readRegEx: (NSString *) pattern options: (NSRegularExpressionOptions) options;
- (NSString *) readRegExArray: (NSArray *) patternArray options: (NSRegularExpressionOptions) options;

- (NSUInteger) lastSavedPosition;

// признак окончания данных
- (Boolean) endOfData;

// сохранить текущую позицию указателя в стеке
- (void) savePosition;

// восстановить текущую позицию указателя из стека
- (void) restorePosition;

// закрепить текущую позицию указателя и удалить сохраненную ранее позицию из стека
- (void) commitPosition;

// текущая позиция
@property NSUInteger position;

// данные
@property (copy) NSString * string;

@end
