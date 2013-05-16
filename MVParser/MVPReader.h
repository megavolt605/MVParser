//
//  MVPString.h
//  MVParser
//
//  Посимвольная обработка строки
//

static const unichar MVPReaderEndOfData = 0;

typedef Boolean(^MVPReaderReadStringBlock) (NSString * string, NSString * character, NSUInteger characterIndex, Boolean * error);
typedef Boolean(^MVPReaderReadCharacterStringBlock) (NSString * string, unichar character, NSUInteger characterIndex, Boolean * error);

@interface MVPReader : NSObject

+ (MVPReader *) stringWithString: (NSString *) string;
+ (MVPReader *) stringWithContentsOfFile: (NSString *) filename;
+ (MVPReader *) stringWithContentsOfURL: (NSURL *) url;

- (id) initWithString: (NSString *) string;
- (id) initWithContentsOfFile: (NSString *) filename;
- (id) initWithContentsOfURL: (NSURL *) url;

// чтение очередного символа
- (unichar) readCharacter;
- (NSString *) readStringCharacter;

// чтение набора последоватеьных символов,
// до тех пор, пока блок возвращает true,
// или пока не будет достигнут конец строки
- (NSString *) readStringWithBlock: (MVPReaderReadStringBlock) block;
- (NSString *) readCharacterStringWithBlock: (MVPReaderReadCharacterStringBlock) block;

// чтение набора последовательных символов,
// до тех пор пока не встретится указанный символ
- (NSString *) readStringUntilCharacter: (unichar) stopCharacter;

// чтение набора последовательных символов,
// до тех пор пока не встретится хотя бы один из символов
- (NSString *) readStringUntilCharacterInString: (NSString *) stopCharacterSet;

// чтение набора последовательных символов,
// до тех пор пока не встретится указанный символ
- (NSString *) readStringUntilString: (NSString *) stopString;

- (NSString *) readRegEx: (NSString *) pattern options: (NSRegularExpressionOptions) options;

// возвращаемся на шаг назад
- (void) unread;

// признак окончания данных
- (Boolean) endOfData;

// пропустить пустые символы (пробелы, табуляции, перевод строки и т.д.)
- (NSUInteger) skipCharactersInSet: (NSCharacterSet *) characters;

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
