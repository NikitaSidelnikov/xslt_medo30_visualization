# Описание
## Назначение
**XSLT-визуализатор цифровых документов** необходим для преобразования XML-файлов цифровых документов по процессу "Работа с поручением" в электронный документ формата PDF/A1?? с целью отражения информации из XML-документа в понятном и читабельном для человека виде. PDF/A1?? - стандарт ISO 19005-1:2005 для долгосрочного архивного хранения электронных документов.
## Архитектура
Визуализатор состоит из 2 самостоятельных и независимых друг от друга частей:
1. **Файл xsl-трансформации (xslt)** - xml-файл, описывающий правила преобразования и обработки входящего xml-документа с выводом результатов трансформации в html формате. XSLT файл не преобразует самостоятельно xml-документ, а лишь описывает правила преобразования, поэтому требует дополнительный инструмент для данного процесса (преобразование силами браузера или xslt-процессор).
2. **Конвертор xml2pdfA** преобразует xml-документ по описанным в приложенном файле xsl-трансформации правилам в электронный документ формата PDF/A1. Конвертор не зависит от xslt файла и может использоваться независимо от него для конвертации любого xml-документа при помощи любого xslt файла. Единственное условие использования конвертора с иными xml и xslt файлами - xslt файл должен описывать правила преобразования xml в html.

В свою очередь конвертор xml2pdfA состоит из 3 модулей:
1. xsltproc - простой xslt процессор поддерживающий xslt 1.0. Преобразует xml-документ на основе приложенному к нему файла xsl-трансформации в html-документ. [Источник](http://www.sagehill.net/docbookxsl/InstallingAProcessor.html)
2. wkhtmltopdf - инструмент командной строки с открытым исходным кодом для преобразования HTML в PDF. Берет результат работы xsltproc - html-документ,- и конвертирует его в PDF. [Источник](https://wkhtmltopdf.org/)
3. ghostscript - интерпретатор языка PostScript  и файлов PDF. Преобразует PDF документ, созданный при помощи wkhtmltopdf, в PDF/A1 для долгосрочного архивного хранения электронных документов. [Источник](https://www.ghostscript.com/)

## Информационное взаимодействие
Как говорилось ранее, визуализатор цифровых документов состоит из двух независимых частей: файл xsl-трансформации цифровых документов (расположен в  xslt_visualizer) и конвертор xml2pdfA. Конвертор может работать отдельно от всего визуализатора для трансформации иных xml-документов при помощи соответствующих xslt файлов.

**Входящие потоки визуализатора:**
- XML-документ по процессу "Работа по поручению"
- XSLT-файл трансформации

**Исходящие потоки визуализатора:**
- Файл визуализации xml-документа в формате PDF/A1
# Инструкция к использованию
## Требования к системе
Особых требований к системе не предъявляется. Система должна быть на базе Windows. 
*(проверялось работа только на 10ке. Было бы не плохо проверить на голой 10ке, других окнах и собрать еще все под Линукс)*
## Установка
Cкачать проект и разместить в любой папке.
В папке examples представлены примеры актуальных цифровых документов по процессу "Работа с поручением" и не требуется для нормальной работы визуализатора.
## Использование
Перед началом использования:
* Разместите xslt файл из папки xslt_visualizator в папку, где находятся необходимые для конвертации цифровые документы.
* Убедитесь, что xslt-файл имеет наименование "edocument.xslt"

Визуализатор может работать в двух режимах:
* Интерактивный
* Консольный

**Интерактивный**

Для начала конвертации xml-документа в электронный документ формата PDF/A1 выделите необходимый(ые) xml файл(ы) и перетащите на xml2pdfA.bat. Дождитесь окончания конвертации.

**Консольный**

В командной строке введите следующую команду:

`xml2pdfA.bat [xml1] [xml2] [xml3] ... [xmlX]`

, где xmlX - полный путь к xml-документу
Кол-во передаваемых параметров не ограничено, параметры должны быть разделены пробелом.


# See soon...
* Работа визуализатора на платформах под Linux
