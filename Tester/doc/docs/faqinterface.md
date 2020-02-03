Где синтаксическая подсветка кода?
----------------------------------

Можно установить Visual Studio Code, редактируемые там сценарии будут синхронизироваться с тестером в обе стороны. Подробнее см. в документации [Интеграция с Visual Studio Code](vscode.md). При наборе кода сценария, кроме привычного IntelliSense работают подсказки к методам Тестера; разработанный плагин взаимодействует с Тестером для получения полей тестируемого приложения.

Например, при наборе `Нажать ( “` плагин покажет в выпадающем списке редактора vscode, какие кнопки можно нажать в текущем окне тестируемого приложения:

![](/img/2018_07_04_19_44_172.png)

Или, при установке текущий формы, подсказка будет такой:

![](/img/2018_07_04_19_44_533.png)

А как отлаживать сценарии?
--------------------------

Для запуска сценария в режиме отладки, используется комбинация `Alt+F5`, либо контекстное меню в редакторе сценария `Запустить отладку`.

Для установки точек останова, используется метод [ОтладкаСтарт](api.md#DebugStart). С его помощью можно остановить сценарий в нужном месте, либо сделать это по определенному условию:

    попытка
    	Ввести ( "!МоеЧисловоеПоле", 10 );
    исключение
    	// Если что-то пошло не так,
    	// с этого места Тестер начнет отладку
    	// и будет ждать действий пользовтеля
    	ОтладкаСтарт ();
    конецпопытки;

Как по-быстрому прогнать пару сценариев?
----------------------------------------

Если в ходе работ вы хотите не отвлекаясь прогнать ряд тестов – используйте механизм заданий. Это позволяет делегировать прогон сценария другой машине. Впоследствии, через журнал задач, вы cможете определить статус прохождения тестов, и при необходимости, проанализировать ситуацию отчетом `Сводка`, журналом ошибок или логом выполнения. Подробнее см. [Механизм заданий](jobs.md).

Как узнать, когда последний раз запускался сценарий, кем, и был ли запуск успешным?
-----------------------------------------------------------------------------------

Находясь в сценарии:

![](/img/2018_07_04_19_36_351.png)

Каждый из пунктов предназначен для соответствующего анализа. Эти же функции доступны в контекстом меню дерева сценариев.

Я редактирую тест и хочу его запустить на другой машине, я должен его предварительно помещать в хранилище?
----------------------------------------------------------------------------------------------------------

Не обязательно. Если на другой машине тест будет выполнять ваш пользовательский профиль, тогда тестер автоматом возьмет последнюю сохраненную вами версию теста. Если другой, тогда перед запуском задания, тестер предложит поместить сценарии в репозиторий.

Как производить рефакторинг сценариев в процессе разработки?
------------------------------------------------------------

При активной разработке могут пересматриваться идентификаторы объектов, интерфейс, строки и сообщения, что в свою очередь влечет падение тестов. Чтобы не откладывать тестирование на последний момент, уговаривая себя, что больше ничего не поменяется, можно использовать несколько подходов:

Подход 1. В сценариях, вместо строкового представления, используйте идентификаторы.

Например, вместо `Ввести ( “Покупатель”, “Рога и копыта” )` используйте: `Ввести ( “!Контрагент”, “Рога и копыта” )`.

Таким образом, заполнение поля будет выполнено по идентификатору, и не будет зависеть от представления (которое обычно меняется чаще, чем идентификатор) и/или языка интерфейса пользователя, что критично важно при тестировании многоязычных конфигураций.

Подход 2. Поиск используемого фрагмента в дереве сценариев, например так:

![](/img/2018_07_09_21_00_571.png)

Подход 3. Использование отчета `Сценарии` для точного поиска выражения:

![](/img/2018_07_09_21_02_502.png)

Подход 4. Рекомендуемый. Так как Тестер умеет автоматически зеркалировать сценарии на файловую систему, можно использовать богатые возможности внешних текстовых редакторов, например, Microsoft Visual Studio Code:

![](/img/2018_07_09_21_06_363.png)

На картинке показан пример замены идентификатора `Партнер` на `Контрагент`. После замены и сохранения модифицированных сценариев, Тестер загрузит их автоматически обратно в базу тестов.

Как вы работаете в vscode, там ведь кроме набора текста больше никаких удобств?
-------------------------------------------------------------------------------

Разработка сценариев в Visual Studio Code может стать очень удобным инструментом, хотя и требует определенной практики и изучение возможностей среды.

Вот список наиболее полезных комбинации клавиш для работы с кодом сценария:

`Ctrl + E`. Открывает окно нечеткого поиска сценария для его открытия в новой вкладке.

`Ctrl + Shift + E`. Активация дерева файлов проекта.

`Alt + F12`. Открытие в сплывающем окне модуля процедуры, функции или сценария. Удобно использовать для беглого просмотра когда связанного сценария.

`Ctrl + Shift + O`. Быстрый переход к процедуре/функции кода сценария.

`Ctrl + Shift + F`, `Ctrl + Shift + H`. Глобальный поиск и глобальная замена. Важной способностью этих функций является возможность указания начальной папки (поле чувствительно к регистру) поиска/замены.