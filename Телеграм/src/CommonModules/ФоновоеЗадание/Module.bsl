#Область ОтветНаСообщение
Процедура РегламентноеЗадание() Экспорт
	Ответ = ЧтениеСообщенийСервер.ОбновитьСообщенияНаСервере();
	ОбработатьОтвет(Ответ);
КонецПроцедуры

Процедура ОбработатьОтвет(Ответ)
	Набор = РегистрыСведений.ОтветыПользователям.СоздатьНаборЗаписей();
	Для Каждого Строка Из Ответ Цикл
		
		Запрос = Новый Запрос;
		Запрос.Текст =
			"ВЫБРАТЬ
			|	ОтветыПользователям.Команда
			|ИЗ
			|	РегистрСведений.ОтветыПользователям КАК ОтветыПользователям
			|ГДЕ
			|	ОтветыПользователям.ИДОбновления = &ИДОбновления";
		
		Запрос.УстановитьПараметр("ИДОбновления", Строка.ИДОбновления);
		
		РезультатЗапроса = Запрос.Выполнить();
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Если Не ВыборкаДетальныеЗаписи.Следующий() Тогда
			СтрокаНаборы = Набор.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаНаборы, Строка);
		Иначе
			Строка.Отправлено = Истина;
		КонецЕсли;
		
	КонецЦикла;
	Набор.Записать();
	ОтправитьОтвет(Ответ);
КонецПроцедуры

Процедура ОтправитьОтвет(ТаблицаДанных)
	Для Каждого Строка Из ТаблицаДанных Цикл
		Если Не Строка.Отправлено Тогда
			ОбменСообщениямиСервер.ОтправитьСообщение(Строка.ИДСобеседника, "ок!");
		КонецЕсли;	
	КонецЦикла;
КонецПроцедуры
#КонецОбласти