<?xml version = "1.0" encoding="UTF-8"?>

<!-- xsl stylesheet declaration with xsl namespace: 
Namespace tells the xlst processor about which 
element is to be processed and which is used for output purpose only 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:ДОК="urn:D001:v0.0.1" 
xmlns:СП1="urn:D001:R001:v1.0.0"
xmlns:СП2="urn:D001:R002:v1.0.0" 
xmlns:ТМ="urn:D000:v0.0.1" 
xmlns:ДМ="urn:D002:P001:v0.0.1">
<xsl:output method="html" encoding="UTF-8" indent="yes" />

	<xsl:template match="/">
		<html><body><div>
			<!--Шапка "Документ № от" -->
			<xsl:apply-templates select="//ДМ:РеквизитыДоклада|//ДМ:Поручение[1]/ДМ:РеквизитыДокументаСПоручением|//ДМ:РеквизитыОбъяснения|//ДМ:РеквизитыДокументаЗапрос"/>
			<!--Шапка "Вид документа" -->
			<xsl:apply-templates select="//СП1:ВидДокумента"/>
			
			<!-- тело документа -->
			<div style="font-size:14pt;margin-left:20px"> <p style="margin-top:60px">			
				<xsl:apply-templates select="//ДОК:БлокДанных"  mode="body"/>
			</p></div> 	
		</div></body></html>
	</xsl:template>
	
	
	<!--Шапка "Документ № от" -->
	<xsl:template match="ДМ:РеквизитыДоклада|ДМ:РеквизитыДокументаСПоручением|ДМ:РеквизитыОбъяснения|ДМ:РеквизитыДокументаЗапрос">
		<h2 align="center">
			<strong>
				<xsl:text> Документ №</xsl:text>
				<xsl:value-of select="ДМ:Номер"/>
				<xsl:text> от </xsl:text>
				<xsl:value-of select="ДМ:Дата"/>
			</strong>
		</h2>
	</xsl:template>
	
	<!--Шапка Вид документа -->
	<xsl:template match="СП1:ВидДокумента">
		<h4 align="center" style="margin-left:200px;margin-right:200px">
				<xsl:value-of select="."/>
		</h4>
	</xsl:template>
	
	
	<!-- Тело документа -->
	<xsl:template match="ДОК:БлокДанных" mode="body">
		<!--ДокументПоручение -->	
		<xsl:apply-templates select="//ДМ:ПостановкаПорученияНаКонтроль"  mode="data"/>
		<!--ДокументДоклад -->
		<xsl:apply-templates select="//ДМ:НаправлениеДокладаОбИсполнении" mode="data"/>
		<!--ДокументДокладСоисполнителя -->
		<xsl:apply-templates select="//ДМ:НаправлениеДокладаСоисполнителя" mode="data"/>
		<!--ДокументОбъяснение -->
		<xsl:apply-templates select="//ДМ:ОбъяснениеОПричинахНеисполненияВСрок" mode="data"/>
		<!--ДокументПредложениеОКорСрока -->
		<xsl:apply-templates select="//ДМ:ПредложениеОКорректировкеСрока" mode="data"/>
		<!--ДокументУведомлениеОНазначенииОтв -->
		<xsl:apply-templates select="//ДМ:НазначениеОтветственногоЛица" mode="data"/>
		<!--ДокументУведомлениеОСнятииСКонтроля -->
		<xsl:apply-templates select="//ДМ:СнятиеПорученияСКонтроля" mode="data"/>
		<!--ДокументНазначениеНовСрока-->
		<xsl:apply-templates select="//ДМ:НазначениеНовогоСрокаИнициатором" mode="data"/>
		<!--ДокументНазначениеНовСрока_отказ -->
		<xsl:apply-templates select="//ДМ:ЗапросОбъясненияНеисполненияВСрок" mode="data"/>
	</xsl:template>
	
	
	
	<!-- ДокументПоручение -->	
	<xsl:template match="ДМ:ПостановкаПорученияНаКонтроль" mode="data">
		<h3><p style="margin:20px;margin-bottom:0px"><strong><xsl:text>Поручение </xsl:text></strong></p></h3>
		<xsl:apply-templates select="//ДМ:Поручение"  mode="data"/>
	</xsl:template>
	
	<xsl:template match="ДМ:Поручение" mode="data">
		<div style="margin-bottom:50px;margin-left:40px">
			<!--Данные -ПунктПоручения - НомерПункта -->
			<xsl:apply-templates select="./ДМ:ПунктПоручения/ДМ:НомерПункта"/>
			<!--Данные -РеквизитыВышестоящегоПоручения -->
			<xsl:apply-templates select="./ДМ:РеквизитыВышестоящегоПоручения"/>
			<!--Данные -ПунктПоручения - ТекстПоручения-->
			<xsl:apply-templates select="./ДМ:ПунктПоручения/ДМ:ТекстПоручения"/>
			
			
			<div style="margin-left:40px">
				<!--Данные -Отправитель/получатель -->
				<xsl:apply-templates select="."  mode="contacts"/>
			</div>
			
			<!--Данные -Срок исполнения -->
			<xsl:apply-templates select="./ДМ:ПунктПоручения/ДМ:ОписаниеСрока"  mode="deadline"/>
		</div>
	</xsl:template>
	

	
	<!--ДокументПоручение - ПунктПоручения - ТекстПоручения -->
	<xsl:template match="ДМ:ТекстПоручения">
		<div style="margin-top:10px;margin-bottom:0px"><strong><xsl:text>Текст поручения: </xsl:text></strong></div>
		<div><xsl:value-of select="."/></div>	
	</xsl:template>
	
	<!--ДокументПоручение - РеквизитыВышестоящегоПоручения-->
	<xsl:template match="ДМ:РеквизитыВышестоящегоПоручения">
		<div style="margin-top:10px;margin-bottom:0px">
			<xsl:text>Документ основание №</xsl:text>
			<xsl:value-of select="ДМ:Номер"/>
			<xsl:text> от </xsl:text>		
			<xsl:value-of select="ДМ:Дата"/>
		</div>
	</xsl:template>
	
		<!--ДокументПоручение -Отправитель/получатель -->
	<xsl:template match="ДМ:Поручение" mode="contacts">
	<div style="margin-top:20px">
		<div style="display: inline-block;vertical-align: top;">
			<strong><xsl:text>Инициатор</xsl:text></strong>
			<p><xsl:value-of select="./ДМ:ОрганизацияИнициатор"/></p>
		</div>
		<div style="display: inline-block;vertical-align: top;margin-left:80px">
			<strong><xsl:text>Исполнитель</xsl:text></strong>
			<p><xsl:value-of select="./ДМ:ОрганизацияИсполнитель"/></p>
		</div>
		<div style="display: inline-block;vertical-align: top;margin-left:80px">
			<strong><xsl:text>Соисполнитель(и)</xsl:text></strong>
			<xsl:for-each select="./ДМ:ОрганизацииСоисполнители/ДМ:ОрганизацияСоисполнитель">
				<p><xsl:value-of select="position()"/>
				<xsl:text>. </xsl:text>
					<xsl:value-of select="."/>
					<xsl:if test="position() != last()">; </xsl:if>
				</p>
			</xsl:for-each>
		</div>
		</div>
	</xsl:template>
	
			<!--ДокументПоручение -Срок исполнения -->
	<xsl:template match="ДМ:ОписаниеСрока" mode="deadline">
		<div style="margin-top:10x;">
			<strong><xsl:text>Срок исполнения: </xsl:text></strong>
			<xsl:value-of select="./ДМ:ДатаИсполнения"/>
			<xsl:text> (</xsl:text>
			<xsl:value-of select="./ДМ:Срочность"/>
			<xsl:text> )</xsl:text></div>
	</xsl:template>
	
	
	
	
	<!--ДокументДоклад -->
	<xsl:template match="ДМ:НаправлениеДокладаОбИсполнении" mode="data">
		<p style="margin:20px;margin-bottom:10px"><strong><xsl:text>Доклад </xsl:text></strong></p>
		<div style="margin-left:40px">
			<!--Данные -Пункт поручения -->
			<xsl:apply-templates select="ДМ:ПунктПоручения/ДМ:НомерПункта"/>
			<!--Данные -Исполнитель -->
			<xsl:apply-templates select="ДМ:ОрганизацияИсполнитель"  mode="executor"/>
			<!--Данные -Текст доклада -->
			<xsl:apply-templates select="ДМ:ТекстДоклада"/>
		</div>
	</xsl:template>
	
			<!--ДокументДоклад -Текст доклада -->
	<xsl:template match="ДМ:ТекстДоклада">
			<p style="margin-bottom:0px"><strong><xsl:text>Текст доклада: </xsl:text></strong></p>
			<p style="margin-top:5px"><xsl:value-of select="."/></p>
	</xsl:template>
	
	<!--ДокументДокладСоисполнителя -->
	<xsl:template match="ДМ:НаправлениеДокладаСоисполнителя" mode="data">
		<p style="margin:20px;margin-bottom:10px"><strong><xsl:text>Доклад соисполнителя </xsl:text></strong></p>
		<div style="margin-left:40px">
			<!--Данные -Пункт поручения -->
			<xsl:apply-templates select="ДМ:ПунктПоручения/ДМ:НомерПункта"/>
			<!--Данные -Исполнитель -->
			<xsl:apply-templates select="ДМ:ОрганизацияСоисполнитель"  mode="executor"/>
			<!--Данные -Текст доклада -->
			<xsl:apply-templates select="ДМ:ТекстДоклада"/>
		</div>
	</xsl:template>
	
	<!--ДокументОбъяснение -->
	<xsl:template match="ДМ:ОбъяснениеОПричинахНеисполненияВСрок" mode="data">
		<p style="margin:20px;margin-bottom:10px"><strong><xsl:text>Объяснение о причинах неисполнения в срок </xsl:text></strong></p>
		<div style="margin-left:40px">
			<!--Данные -Пункт поручения -->
			<xsl:apply-templates select="./ДМ:ПунктПоручения/ДМ:НомерПункта"/>
			<!--Данные -Исполнитель -->
			<xsl:apply-templates select="ДМ:ОрганизацияИсполнитель"  mode="executor"/>
			<!--Данные -Текст доклада -->
			<xsl:apply-templates select="./ДМ:Объяснение/ДМ:ТекстОбъясненияНарушения"/>
		</div>
	</xsl:template>
	
		<!--ДокументОбъяснение -Причина -->
	<xsl:template match="ДМ:ТекстОбъясненияНарушения">
			<p style="margin-bottom:0px"><strong><xsl:text>Текст объяснения: </xsl:text></strong></p>
			<p style="margin-top:5px"><xsl:value-of select="."/></p>
	</xsl:template>
	
	
	
	<!--ДокументПредложениеОКорСрока -->
	<xsl:template match="ДМ:ПредложениеОКорректировкеСрока" mode="data">
		<p style="margin:20px;margin-bottom:10px"><strong><xsl:text>Предложение о корректировки запроса </xsl:text></strong></p>
		<div style="margin-left:40px">
			<!--Данные -Пункт поручения -->
			<xsl:apply-templates select="ДМ:ПунктПоручения/ДМ:НомерПункта"/>
			<!--Данные -Исполнитель -->
			<xsl:apply-templates select="ДМ:ОрганизацияИсполнитель"  mode="executor"/>
			<!--Данные -Желаемый срок -->
			<xsl:apply-templates select="ДМ:Запрос/ДМ:ЖелаемаяДата" />
			<!--Данные -Причина -->
			<xsl:apply-templates select="ДМ:Запрос/ДМ:ПричинаИзмененияСрока" />
		</div>
	</xsl:template>
	
		<!--ДокументПредложениеОКорСрока - Желаемый срок-->
	<xsl:template match="ДМ:ЖелаемаяДата">
			<p style="margin-bottom:0px"><strong><xsl:text>Желаемая дата: </xsl:text></strong></p>
			<p style="margin-top:5px"><xsl:value-of select="."/></p>
	</xsl:template>
	
		<!--ДокументПредложениеОКорСрока - Причина-->
	<xsl:template match="ДМ:ПричинаИзмененияСрока">
			<p style="margin-bottom:0px"><strong><xsl:text>Причина изменения срока: </xsl:text></strong></p>
			<p style="margin-top:5px"><xsl:value-of select="."/></p>
	</xsl:template>
	
	
	
	<!--ДокументУведомлениеОНазначенииОтв -->
	<xsl:template match="ДМ:НазначениеОтветственногоЛица" mode="data">
		<p style="margin:20px;margin-bottom:10px"><strong><xsl:text>Назачение ответственного лица</xsl:text></strong></p>
		<div style="margin-left:40px">
			<!--Данные -ПунктПоручения - НомерПункта -->
			<xsl:apply-templates select="./ДМ:ПунктПоручения/ДМ:НомерПункта"/>
			<!--Данные -Исполнитель -->
			<xsl:apply-templates select="ДМ:ОрганизацияИсполнитель"  mode="executor"/>
			<!--Данные -ОтветственноеЛицо -->
			<xsl:apply-templates select="ДМ:ОтветственноеЛицо" />
		</div>
	</xsl:template>
	
		<!--ДокументУведомлениеОНазначенииОтв - ОтветственноеЛицо-->
	<xsl:template match="ДМ:ОтветственноеЛицо">
			<p style="margin-bottom:0px;margin-top:5px"><strong><xsl:text>Должность: </xsl:text></strong>
			<xsl:value-of select="./ДМ:Должность"/></p>
			<p style="margin-bottom:0px;margin-top:5px"><strong><xsl:text>ФИО: </xsl:text></strong>
			<xsl:value-of select="./ДМ:ФИО"/></p>
			<!--Данные -ОтветственноеЛицо - КонтактнаяИнформация -->
			<xsl:apply-templates select="ДМ:КонтактнаяИнформация" />
	</xsl:template>
	
			<!--Данные -ОтветственноеЛицо - КонтактнаяИнформация -->
	<xsl:template match="ДМ:КонтактнаяИнформация">
			<p style="margin-bottom:0px;margin-top:5px"><strong><xsl:text>КонтактныйТелефон: </xsl:text></strong>
			<xsl:value-of select="./ДМ:КонтактныйТелефон"/></p>
			<p style="margin-bottom:0px;margin-top:5px"><strong><xsl:text>Email: </xsl:text></strong>
			<xsl:value-of select="./ДМ:Email"/></p>
	</xsl:template>
	
	
	
	<!--ДокументУведомлениеОСнятииСКонтроля -->
	<xsl:template match="ДМ:СнятиеПорученияСКонтроля" mode="data">
		<p style="margin:20px;margin-bottom:10px"><strong><xsl:text>Снятие с контроля </xsl:text></strong></p>
		<div style="margin-left:40px">
			<!--Данные -ПунктПоручения - НомерПункта -->
			<xsl:apply-templates select="./ДМ:ПунктПоручения/ДМ:НомерПункта"/>
			<!--Данные -Исполнитель -->
			<xsl:apply-templates select="ДМ:ОрганизацияИсполнитель"  mode="executor"/>
			<!--Данные -Причина -->
			<xsl:apply-templates select="ДМ:ПричинаСнятияСКонтроля" />
		</div>
	</xsl:template>
	
		<!--ДокументУведомлениеОСнятииСКонтроля - Причина-->
	<xsl:template match="ДМ:ПричинаСнятияСКонтроля">
			<p style="margin-bottom:0px"><strong><xsl:text>Причина снятия с контроля: </xsl:text></strong></p>
			<p style="margin-top:5px"><xsl:value-of select="."/></p>
	</xsl:template>
	
	
	<!--ДокументНазначениеНовСрока_отказ/ДокументНазначениеНовСрока -->
	<xsl:template match="ДМ:НазначениеНовогоСрокаИнициатором" mode="data">
		<xsl:apply-templates select="ДМ:ОтклонениеЗапроса" />
		<xsl:apply-templates select="ДМ:НазначениеСрока" />
		
		<div style="margin-left:40px">
			<!--Данные -ПунктПоручения - НомерПункта -->
			<xsl:apply-templates select="ДМ:ПунктПоручения/ДМ:НомерПункта"/>
			<!--Данные -Исполнитель -->
			<xsl:apply-templates select="ДМ:ОрганизацияИсполнитель"  mode="executor"/>
			<!--Данные -ПричинаОтказа -->
			<xsl:apply-templates select="ДМ:ОтклонениеЗапроса/ДМ:ПричинаОтклоненияЗапроса" />
			<!--Данные -НазначениеСрока -->
			<xsl:apply-templates select="ДМ:НазначениеСрока/ДМ:ДатаИсполнения" />
		</div>
	</xsl:template>
	
	<!--ДокументНазначениеНовСрока_отказ - Причина-->
	<xsl:template match="ДМ:ОтклонениеЗапроса">
			<p style="margin:20px;margin-bottom:10px"><strong><xsl:text>Назначение нового срока - Отказ </xsl:text></strong></p>
	</xsl:template>
	
	<!--ДокументНазначениеНовСрока - Причина-->
	<xsl:template match="ДМ:НазначениеСрока">
			<p style="margin:20px;margin-bottom:10px"><strong><xsl:text>Назначение нового срока </xsl:text></strong></p>
	</xsl:template>
	
		<!--ДокументНазначениеНовСрока_отказ - Причина-->
	<xsl:template match="ДМ:ПричинаОтклоненияЗапроса">
			<p style="margin-bottom:0px"><strong><xsl:text>Причина отклонения запроса: </xsl:text></strong></p>
			<p style="margin-top:5px"><xsl:value-of select="."/></p>
	</xsl:template>
	
			<!--ДокументНазначениеНовСрока - НовыйСрок-->
	<xsl:template match="ДМ:ДатаИсполнения">
			<p style="margin-bottom:0px"><strong><xsl:text>Срок исполнения: </xsl:text></strong></p>
			<p style="margin-top:5px"><xsl:value-of select="."/></p>
	</xsl:template>
	
	
	<!--ДокументЗапросОбъяснения -->
	<xsl:template match="ДМ:ЗапросОбъясненияНеисполненияВСрок" mode="data">
		<p style="margin:20px;margin-bottom:10px"><strong><xsl:text>Запрос объяснения неисполнения в срок </xsl:text></strong></p>
		<div style="margin-left:40px">
			<!--Данные -Пункт поручения -->
			<xsl:apply-templates select="ДМ:ПунктПоручения/ДМ:НомерПункта"/>
			<!--Данные -Исполнитель -->
			<xsl:apply-templates select="ДМ:ОрганизацияИсполнитель"  mode="executor"/>
			<!--Данные -Причина -->
			<xsl:apply-templates select="./ДМ:Запрос/ДМ:ТекстЗапросаОбъясненияНарушения" />
		</div>
	</xsl:template>
	
		<!--ДокументЗапросОбъяснения - ТекстЗапроса-->
	<xsl:template match="ДМ:ТекстЗапросаОбъясненияНарушения">
			<p style="margin-bottom:0px"><strong><xsl:text>Текст запроса: </xsl:text></strong></p>
			<p style="margin-top:5px"><xsl:value-of select="."/></p>
	</xsl:template>
	
	
	<!--УНИВЕРСАЛЬНЫЕ ТЕГИ-->
		<!--Исполнитель-->
	<xsl:template match="ДМ:ОрганизацияИсполнитель" mode="executor">
			<p style="margin-bottom:0px"><strong><xsl:text>Исполнитель: </xsl:text></strong></p>
			<p style="margin-top:5px"><xsl:value-of select="./ТМ:Наименование"/></p>
	</xsl:template>
	
	<xsl:template match="ДМ:ОрганизацияСоисполнитель" mode="executor">
			<p style="margin-bottom:0px"><strong><xsl:text>Соисполнитель: </xsl:text></strong></p>
			<p style="margin-top:5px"><xsl:value-of select="./ТМ:Наименование"/></p>
	</xsl:template>
	
		<!--ПунктПоручения - НомерПункта -->
	<xsl:template match="ДМ:НомерПункта">
			<div style="margin-top:10px;margin-bottom:0px"><strong><xsl:text>Пункт №</xsl:text>
			<xsl:value-of select="."/></strong></div>		
	</xsl:template>
	
			<!--ДокументДоклад -Текст доклада -->
	<xsl:template match="ДМ:ТекстДоклада">
			<p style="margin-bottom:0px"><strong><xsl:text>Текст доклада: </xsl:text></strong></p>
			<p style="margin-top:5px"><xsl:value-of select="."/></p>
	</xsl:template>
</xsl:stylesheet>