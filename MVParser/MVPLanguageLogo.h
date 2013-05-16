//
//  MVPLanguageLogo.h
//  MVParser
//


/*
 {...} - тип данных:
    int
        [ + | - ] [0..9] ...
 
    float
        float_part = [0..9] ...
        [ + | - ] integer_part [ . float_part ]
 
    str
        " [ char ... ] "
 
    bool
        ( True | False )
 
 $v - variable
 
 Выражения:
    element = ( {var} | {int} | {float} | {str} ]
    operator = ( + | - | / | * | ^ )
    expression = element [ ( operator element | ( operator element ) ) ... ]
 
 List of commands
 
 Forward [{float} len]
    Перемещение вперед
    len - длина перемещения, по умолчанию 1.0
 
 Backward [{float} len]
    Перемещение назад
    len - длина перемещения, по умолчанию 1.0
 
 Left [{float} angle]
    Поворот против часовой стрелки
    angle - угол повората в градусах, по умолчанию 90
 
 Right [{float} angle]
    Поворот по часовой стрелке
    angle - угол повората в градусах, по умолчанию 90
 
 {float} currentAngle = Direction [{float} newAngle]
    Получение / установка напревления
    currentAngle - текущий угол в градусах (если указан y, то currentAngle = newAngle)
    newAngle - новый угол в градусах
 
 Center
    Установка координат по центру текущего поля
 
 Go {float} xPos, {float} yPos
    Перемещение по абсолютным координатам xPos, yPos
 
 {float} currentPosX = PosX {float} newPosX
    Перемещение / получение абсолютной горизонтальной координаты currentPosX 
    (если указано currentPosX, то newPosY = currentPosX)

 {float} y = PosY {float} z
    Перемещение / получение абсолютной вертикальной координаты currentPosY 
    (если указано currentPosY, то newPosY = currentPosY)
 
 PenPut [{bool} newState]
    Устанавливает состояние пера в "поднято" / "опущено"
    newState - новой состояние (по умолчанию True)
 
 PenPickup
    Устанавливает состояние пера в "поднято"
 
 {bool} currentState = PenState
    currentState - текущее состояние пера
 
 {float} currentSize = PenSize [{float} newSize]
    Установка / получение текущей толщины пера
    currentSize - текущая толщина пера (если указан newSize, то currentSize = newSize)
    newSize - новая толщина пера (если значение меньше 0.1, то оно принимается равным 0.1)
 
 currentColor = PenColor [{str} newColor]
    Установка / получение текущего цвета пера
    currentColor - название текущего цвета пера (если указан newColor, то currentColor = newColor)
    newColor - название нового цвета
 
 currentAlpha = PenColorAlpha [{float} newAlpha]
    Установка / получение степени прозрачности пера
    currentAlpha - текущая степень прозрачности пера (если указан newAplha, то currentAlpha = newAlpha)
    newAlpha - новая степень прозрачности пера (число в диапазоне от 0 до 1, 
               если оно меньше 0 то приравнивается к 0, если оно больше 1 - к 1)
 
 PenColorRGBA {float} newRed, {float} newGreen, {float} newBlue, {float} newAlpha
    Установка цвета и степени прозрачноасти пера по отдельным компонентам
    newRed - новое значение компоненты красного оттенка цвета пера
    newGreen - новое значение компоненты зеленого оттенка цвета пера
    newBlue - новое значение компоненты синего оттенка цвета пера
    newAplha - новое значение степени прозрачности пера
    если значение newRed, newGreen, newBlue или newAlpha менее 0, то значение игнорируется
 
 CanvasSize {float} newWidth, {float} newHeight
    Установка размера холста
    newWidth - новая ширина холста
    newHeight - новая высота холста
 
 {float} currentWidth = CanvasWidth [{float} newWidth]
    Устанавливает / возвращает текущую ширину холста
    currentWidth - текущая ширина холста (если указан newWidth, то currentWidth = newWidth)
    newHeight - новая ширина холста
 
 {float} currentHeight = CanvasHeight [{float} newHeight]
    Устанавливает / возвращает текущую высоту холста
    currentHeight - текущая высота холста (если указан newHeight, то currentHeight = newHeight)
    newHeight - новая высота холста
 
 {str} currentColor = CanvasColor {str} newColor
    
 CanvasColorRGB {float} newRed, {float} newGreen, {float} newBlue
    Установка цвета холста по отдельным компонентам
    newRed - новое значение компоненты красного оттенка цвета пера
    newGreen - новое значение компоненты зеленого оттенка цвета пера
    newBlue - новое значение компоненты синего оттенка цвета пера
    если значение newRed, newGreen или newBlue менее 0, то значение игнорируется

 Clear
    Очистка холста (заливка текущим цветом)
 
 Reset
    Сброс состояния в начальное состояние
 
 Show
    Показать перо
 
 Hide
    Скрыть перо
 
 {bool} currentVisible = Visible [{bool} newVisible]
    Установить / получить видимость пера
    currentVisible - текущая видимость пера (если указан параметр newVisible, 
                     то currentVisible = newVisible)
    newVisible - новая видимость пера
 
 Write {str} stringToPrint
    Написать надпись текущим шрифтом на поле
 
 Print {str} stringToPrint
    Разместить сообщение в протоколе работы
 
 {float} currentFontSize = FontSize {float} newFontSize
    Установка / получение текущего размера шрифта
 
 {int} i = Round {float} x              // округление
 {int} i = Trunc {float} x              // отбрасывание дробной части
 {int} i = Random {int} j               // случайное число в диапазоне 0..j-1
 {int} k = Module {int} i, {int} j      // остаток от деления
 {float} x = Sqrt {float} y             // корень числа
 {float} x = Sqr {float} y              // квадрат числа
 {float} x = Power {float} y {float} z  // степерь числа (z >= 0)
 {float} x = Pi                         // число Пи
 {float} x = Sin {float} y              // синус
 {float} x = Cos {float} y              // косинус
 {float} x = Tg {float} y               // тангенс
 {float} x = CTg {float} y              // котангенс
 {float} x = ASin {float} y             // арксинус
 {float} x = ACos {float} y             // арккосинус
 {float} x = ATg {float} y              // арктангенс
 {float} x = ACTg {float} y             // арккотангенс

 Message {str} s
    Окно с надписью
 
 {str} s = Ask {str} s
    Окно с надписью, строкой для ввода значения и двумя кнопками (Cancel, Ok)
 
 Wait {float} x
    Пауза на x секунд (x >= 0)
 
 {}
    Анонимный блок операторов
 
 if () {} [ else {} ]

 while () {}
 repeat $v {int} i times {}
 
 for $v = i to j [step k] {}
 
 break
 halt
 
 // ???
 remember c $v[, $v...] {}
 
*/

#import "MVPLanguage.h"

@interface MVPLanguageLogo : MVPLanguage

@end
