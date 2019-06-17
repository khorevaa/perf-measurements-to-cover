
#Область ПрограммныйИнтерфейс

Функция МодулиСПокрытием( Знач пМассивФайловЗамеров, Знач пГенераторПутей ) Экспорт
	
	соотМодули = Новый Соответствие;
	
	Для каждого цФайлЗамера Из пМассивФайловЗамеров Цикл
		
		Чтение = Новый ЧтениеТекста();
		Чтение.Открыть( цФайлЗамера, КодировкаТекста.UTF8 );
		
		ПрочитатьПокрытиеИзДанныхФайла(соотМодули, Чтение.Прочитать());
		
		Чтение.Закрыть();
		
	КонецЦикла;
	
	соотМодулиСПокрытием = Новый Соответствие;
	
	Для каждого цЭлемент Из соотМодули Цикл
		
		файл = Новый Файл(пГенераторПутей.Путь(цЭлемент.Ключ));

		соотМодулиСПокрытием.Вставить( файл.ПолноеИмя, цЭлемент.Значение );
		
	КонецЦикла;
	
	Возврат соотМодулиСПокрытием;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПрочитатьПокрытиеИзДанныхФайла(Знач соотМодули, Знач ТекстФайлаЗамера)
	
	маркерНачалоИмениМодуля = "AAAAAAAAAAAAAAAAAAAAAAAAAAA=,""""},""";
	длинаНачалоИмениМодуля = СтрДлина( маркерНачалоИмениМодуля );
	
	маркерКонецИмениМодуля = """,";
	длинаКонецИмениМодуля = СтрДлина( маркерКонецИмениМодуля );
	
	маркерКонецНомераСтроки = ",";
	длинаКонецНомераСтроки = СтрДлина( маркерКонецНомераСтроки );
	
	указатель = 0;
	
	Пока Истина Цикл
		
		указатель = СтрНайти( ТекстФайлаЗамера, маркерНачалоИмениМодуля,, указатель + 1 );
		
		Если указатель = 0 Тогда
			
			Прервать;
			
		КонецЕсли;
		
		конецИмени = СтрНайти( ТекстФайлаЗамера, маркерКонецИмениМодуля, , указатель );
		
		указатель = указатель + длинаНачалоИмениМодуля;
		
		имяМодуля = Сред( ТекстФайлаЗамера, указатель, конецИмени - указатель);
		
		Если СтрЗаканчиваетсяНа( имяМодуля, ".Форма" ) Тогда
			
			имяМодуля = имяМодуля + ".Модуль";
			
		КонецЕсли;
		
		указатель = конецИмени + длинаКонецИмениМодуля;
		
		конецНомераСтроки = СтрНайти( ТекстФайлаЗамера, маркерКонецНомераСтроки, , указатель );
		
		номерСтроки = Сред( ТекстФайлаЗамера, указатель, конецНомераСтроки - указатель );
		
		параметрыМодуля = соотМодули.Получить( имяМодуля );
		
		Если параметрыМодуля = Неопределено Тогда
			
			параметрыМодуля = Новый Структура;
			параметрыМодуля.Вставить( "Имя", имяМодуля );
			параметрыМодуля.Вставить( "Строки", Новый Соответствие );
			
			соотМодули.Вставить( имяМодуля, параметрыМодуля );
			
		КонецЕсли;
		
		от = Новый ОписаниеТипов( "Число", Новый КвалификаторыЧисла( 10, 0, ДопустимыйЗнак.Любой ) );
		
		номерСтроки = от.ПривестиЗначение( номерСтроки );
		
		параметрыМодуля.Строки.Вставить( номерСтроки, Истина );
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти