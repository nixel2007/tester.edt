<a name=TasksDelegation></a>В Тестере существует возможность формирования заданий на выполнение сценариев по требованию или расписанию на текущем или удаленном компьютере. Также, существует возможность формирования заданий через rest-сервис.

Функционал заданий может быть использован для решения следующих задач:

1.  Тестирование по расписанию. Например, можно составить расписание для еженочного запуска тестирования.
2.  Прогон тестов разных веток/версий конфигурации с формированием сборок в рамках методики непрерывной интеграции.
3.  Запуск тестов в процессе разработки. Например, программист в процессе кодирования, может создать задачу на выполнение ряда тестов на виртуальной машине. Такой делегированный процесс не будет отвлекать его от текущего процесса разработки, а последующий анализ прохождения тестов по заданию, даст специалисту понимание, как повлияли его последние изменения на работу программы.
4.  Запуск тестирования по событию. Например, можно разработать сценарий, алгоритм которого будет автоматически запускать процесс тестирования при изменении версии конфигурации.
5.  Выполнение регламентных операций в продуктивных базах. Например, можно разработать сценарий, который будет взаимодействовать с приложением в режиме пользователя, и выполнять определенную рутину (удаление помеченных, запуск проведений, формирование и рассылка отчетов, курсов валют, и так далее).

Для выполнения задания, требуется, чтобы на целевом компьютере была запущена сессия Тестера.

Функционал заданий может быть задействован в задаче [Запуск тестов по расписанию](#Schedule), где вместо системного планировщика событий, может быть использована агентская сессия Тестера.

Права
-----

Для возможности работы с заданиями, включая их запуск и создание, пользователям необходимо добавить право `Использование заданий`:

![](/img/2018_06_10_03_53_101.png)

(см. `Меню / Пользователи`).

Пользователь, который будет выполнять делегированные ему задачи, называется `Агент`.

Чтобы пользователь стал агентом, необходимо в его профиле установить признак `Агент`:

![](/img/2018_06_10_03_59_123.png)

На этой же вкладке, в таблице задаются пользователи, которые будут иметь право формирования заданий для данного агента.

После того как пользователь стал агентом, его сессию необходимо перезапустить (если она уже была запущена). Для перезапуска нужно переключиться в сессию агента и выполнить `Меню / Сервис / Перезапуск`

Создание
--------

Задание может быть создано несколькими способами:

1.  Непосредственно через журнал `Меню / Задания`
2.  Через подменю `Запустить` на верхней панели окна редактирования сценария
3.  Через контекстное меню в дереве сценариев

Пример создания задания из формы редактирования сценария:

![](/img/2018_06_10_04_17_415.png)

![](/img/2018_06_10_04_50_216.png)

В диалоговой форме задания, необходимо указать параметры запуска. Важно обратить внимание на следующие реквизиты:

1.  `Агент` и `Компьютер`. В связи с тем, что один и тот же агент может быть запущен на разных компьютерах, в задании можно указать, для какого компьютера оно должно выполняться. Если компьютер задан не будет, задание будет выполнено первым свободным компьютером с запущенной на нем сессией указанного агента.
2.  Если в качестве варианта запуска задания будет указано расписание, тогда следует дополнительно обратить внимание на флаг `Игнорировать завершение`. По умолчанию, данный флаг выключен. Это означает, что Тестер не будет формировать очередное задание, пока предыдущее не будет выполнено. Если флаг будет включён, Тестер будет создавать и ставить в очередь задания, несмотря на факт их выполнения.
3.  Последовательность сценариев в таблице будет соблюдаться при их запуске. Если в таблице указан сценарий, который на момент запуска редактируется, или этот сценарий вызывает другие сценарии, которые в свою очередь находятся в режиме редактирования, агент будет получать их последние версии (по сценариям ведется версионирование). Таким образом, если требуется запуск сценариев с последними изменениями, их нужно предварительно поместить в хранилище.

Изменение
---------

При сохранении задания, оно помещается в очередь на выполнение и больше не подлежит изменению. Изменить можно только расписание для заданий по расписанию. Задания можно копировать и удалять. При удалении задания, которое выполняется в текущий момент, агент прервет выполнение сценария с соответствующей записью в журнале запуска и ошибок.

Создание заданий через rest-сервис
----------------------------------

Некоторые сценарии требуют взаимосвязь разнородных информационных систем. Для предоставления интерфейса по формированию заданий, в Тестере реализован rest-сервис `Job`. С его помощью, внешняя среда может формировать Тестеру задания с передачей необходимых параметров.

Например, стоит задача протестировать получение заказов через веб-магазин (обычный сайт на `php`), и загрузку этих данных в прикладное решение Управление Торговлей (УТ). При этом, нужно протестировать как работу API сайта, так и механизм загрузки данных в УТ. В упрощенном виде, такой сценарий должен вначале загрузить данные на сайт используя его Rest API (способы тестирования веб-сайтов выходят за рамки этой документации), а затем, дать задание Тестеру на запуск тестирования механизма загрузки данных прикладного решения.

Инфраструктура со стороны Тестера должна выглядеть таким образом:

1.  Информационная база с Тестером публикуется на веб-сервере для возможности вызова его rest-сервиса. Подробнее о публикации, читайте в [официальной документации](https://its.1c.ru/db/v8312doc#bookmark:adm:TI000000194).
2.  В тестовом окружении, должен быть запущен менеджер тестирования под агентом-пользователем, который фактически и будет выполнять сценарное тестирование.

Весь цикл будет примерно таким:

1.  Используя специальный фреймворк или собственную разработку, front-end разработчик, эмулируя действия пользователя, выполняет наполнение данными тестируемый веб-сайт.
2.  Затем, его сценарий (на php или любом другом языке) вызывает rest-сервис Тестера и просит его выполнить сценарий уже в контексте сценарного тестирования 1С. Выполняя POST-запрос, веб-разработчик указывает идентификатор сценария, приложение и агента.
3.  Rest-сервис Тестера, создаст в информационной базе задание на тестирование. Тут важно отметить, что сервис не запускает сценарий на выполнение, а лишь формирует задание и ставит его в очередь.
4.  Выполнение сценариев осуществляется “на клиенте”, на тестовом сервере, отдельно запущенной сессией менеджера тестирования (в той же информационной базе) под пользователем-агентом. Эта сессия будет выполнять задания из очереди.
5.  По окончании тестирования в Тестере, код сценария может выполнить http-запрос на продолжение/уведомление инфраструктуры тестового окружения веб-сайта.

Пример вызова POST-запроса на создание задания. Код приведен на языке 1С, но может быть легко адаптирован под php, javascript или другой язык:

    // Адрес опубликованного Тестера на веб-сервере, где:
    //  localhost: имя или IP-адрес хоста
    //  tester: имя опубликованного приложения
    address = "localhost/tester";
    
    // Имя и пароль пользователя в Тестере, который имеет
    // право создавать задания. Например, это может быть
    // ваш профиль, под которым вы работаете в Тестере
    user = "Разработчик";
    pswd = "0123456";
    
    connection = new HTTPConnection ( address + "/hs", , user, pswd );
    
    // Так называется rest-сервис
    request = new HTTPRequest ( "/Job" );
    
    // Структура параметров, которая будет преобразована в JSON
    // {
    // "Agent": null,
    // "Scenario": null,
    // "Application": null,
    // "Parameters": null,
    // "Computer": null,
    // "Memo": null
    // }
    params = new Structure ( "Agent, Scenario, Application, Parameters, Computer, Memo" );
    
    // Имя пользователя-агента, который будет выполнять сценарий на клиенте.
    // Его сессия должна быть запущена.
    params.Agent = "animal";
    
    // Идентификатор сценария в базе тестов Тестера
    params.Scenario = "Документы.ЗаказПокупателя.ЗагрузкаСВеб";
    
    // Тестируемое приложение
    params.Application = "УТ";
    
    // Параметры, которые можно передать заданию.
    // Пример доступа к этим параметрам из кода сценария см. ниже
    params.Parameters = new Structure ( "Параметр1", "Значение параметра 1" );
    
    // Произвольные заметки
    params.Memo = "Это моё задание";
    
    request.SetBodyFromString ( Conversion.ToJSON ( params ) );
    connection.Post ( request );

Для доступа к параметрам на уровне сценария Документы.ЗаказПокупателя.ЗагрузкаСВеб, можно использовать следующий код:

    // Получаем ссылку на задание из служебной переменной Debug
    задание = Debug.Job.Job;
    
    // Получаем параметры, они там находятся в строке JSON
    данные = DF.Pick ( задание, "Parameters" );
    
    // Преобразуем их в структуру
    параметры = Conversion.FromJSON ( данные );
    
    // Вывод результата
    Сообщить ( параметры.Параметр1 );

> Пример создания задания выполнен полностью на английском для простоты перевода кода на любой другой язык (php-например). Второй пример, получение параметров, выполнен на русском (кроме системных методов), потому что это происходит только в контексте сценария Тестера.

Пример вызова get-запроса уже из самого кода сценария в Тестере. Пример не выполняет полезных действий с точки зрения логики сценария, но демонстрирует возможность коммуникации сценария с внешней средой:

    подключение = новый HTTPСоединение ( "httpbin.org" );
    запрос = новый HTTPЗапрос ( "/ip" );
    результат = подключение.Получить ( запрос );
    статус = результат.StatusCode;
    если ( статус = 200 ) тогда
    	данные = Conversion.FromJSON ( результат.ПолучитьТелоКакСтроку () );
    	Сообщить ( "Ваш IP: " + данные.Origin );
    иначе
    	Стоп ( "Ошибка, статус возврата: " + статус );
    конецесли;

Вместо получения IP-адреса, вы можете сообщить об успехе выполнения теста.

Запуск тестов по расписанию<a name=Schedule></a>
===========================

В данном разделе описывается методика создания заданий с использованием возможностей планировщика заданий операционной системы. В свою очередь, Тестер поддерживает собственный механизм заданий, который может быть использован вместо системного планировщика. Однако, для этого требуется постоянный запуск сессии агента Тестера. Выбор методики остается на усмотрении специалистов тестирования. При использовании механизма заданий (см. [Механизм заданий](#TasksDelegation)), все приведенные ниже скрипты, могут быть перенесены в код сценариев, с соответствующей адаптацией.

Задачу тестирования по расписанию можно разложить на три составляющие:

1.  Безопасность
2.  Подготовка базы для тестирования
3.  Запуск тестирования

Безопасность
------------

С точки зрения безопасности, желательно разнести серверную и клиентскую части инфраструктуры тестирования по разным серверам. Серверная часть, это часть, где находится тестируемая база, сервер приложений 1С, сервер базы данных. Клиентская часть, это место откуда будет запускаться Тестер и тонкий клиент тестируемого приложения.

В общем случае, выполнение кода сценариев может быть небезопасным, особенно при групповой разработке. Теоретически, можно создать зловредный сценарий, который в тестируемой базе подключит и выполнит обработку, которая в свою очередь закачает и установит вирус, либо прочтет скрытые данные и запишет их в базу или вышлет по почте. Поэтому, желательно, чтобы сервер, который будет обслуживать клиентскую часть (на котором будут выполняться сценарии), не содержал секретных данных, баз данных клиентов, имел ограничения по выходу в интернет и другие меры по предотвращению возможной утечки или порче информации. Кроме этого, не устанавливайте на этом сервере толстый клиент и компоненты доступа к серверу. Закройте неиспользуемые порты и настройте запуск тестируемых приложений через web-сервер по http-протоколу.

Соответственно, на серверной части, публикуйте базы для работы с ними только через веб-сервер по http-протоколу. Закрывайте доступ из-вне к портам сервера 1С. Если на вашем сервере есть уникальные конфигурации с открытым исходным кодом, базы клиентов, конфигурационные файлы, нежелательные для просмотра и другие чувствительные данные – убедитесь, что сценарным тестом эти данные получить не удастся.

Например, если вы установите толстый клиент на сервер, где будет производиться тестирование, ничто не помешает злоумышленнику, создать сценарий, который запустит конфигуратор в пакетном режиме для выгрузки конфигурации и/или базы данных.

Подготовка базы для тестирования
--------------------------------

Подготовка базы для тестирования производится на серверной части и состоит из двух этапов:

1.  Загрузка начальной базы данных (подробнее о начальной базе см. [здесь](implementation.md#InitialDB))
2.  Обновление начальной базы данных актуальными изменениями в конфигурации

Для автоматизации этих операций рекомендую использовать командные cmd-файлы.

### worker.cmd

Первый файл будет называться `worker.cmd`. Он будет служить в качестве “процедуры”, в которую мы будем передавать параметры. Расположите этот файл в некоторой общей папке, например `c:\testing`.

Вот содержимое `worker.cmd`:

![](/img/2017_09_07_19_31_113.png)

    set _1c="C:\Program Files (x86)\1cv8\%1\bin\1cv8.exe"
    set ibname=%2
    set ibuser=%3
    set ibpswd=%4
    set initdb=%5
    set repouser=%6
    set repopswd=%7
    set repoaddr=%8
    
    
    %_1C% designer /IBname %ibname% /N %ibuser% /p %ibpswd% /DisableStartupMessages /RestoreIB %initdb% /ConfigurationRepositoryN %repouser% /ConfigurationRepositoryP %repopswd% /ConfigurationRepositoryF %repoaddr%
    %_1C% designer /IBname %ibname% /N %ibuser% /p %ibpswd% /DisableStartupMessages /ConfigurationRepositoryUpdateCfg -force /ConfigurationRepositoryN %repouser% /ConfigurationRepositoryP %repopswd% /ConfigurationRepositoryF %repoaddr%
    %_1C% designer /IBname %ibname% /N %ibuser% /p %ibpswd% /DisableStartupMessages /UpdateDBCfg /ConfigurationRepositoryN %repouser% /ConfigurationRepositoryP %repopswd% /ConfigurationRepositoryF %repoaddr%
    

Где:

| Параметр            | Описание                                                                                                                                                                                                                  |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1CVersion           | Версия 1С:Предприятие. Например: 8.3.10.2252 (без кавычек)                                                                                                                                                                |
| IBName              | Имя базы в списке информационных баз стартера 1С. Например: “Бухгалтерия предприятия КОРП (демо)”                                                                                                                         |
| user                | Имя пользователя в начальной базе. Этот пользователь должен обладать административными правами в информационной базе                                                                                                      |
| password            | Пароль пользователя в начальной базе                                                                                                                                                                                      |
| DTFile              | Путь к файлу-выгрузке с начальной базой. Файл с расширением dt. **Важно!** Выгрузка начальной базы не должна быть подключена к  хранилищу конфигурации. Перед созданием dt-файла, отключите конфигурацию от хранилища 1С. |
| repouser            | Имя пользователя в хранилище конфигурации 1С, откуда будут получены последние изменения конфигурации. Предварительно, создайте специального для целей тестирования пользователя.                                          |
| repopassword        | Пароль пользователя в хранилище конфигурации 1С                                                                                                                                                                           |
| reposerver/reponame | Путь к хранилищу конфигурации с указанием названия приложения. Например: tcp://repositoryserver/myapplication или tcp://repositoryserver**:1641**/myapplication                                                           |

Этот скрипт, по переданным параметрам, выполнит загрузку данных, скачает последние изменения из хранилища и применит их к базе данных.

### prepare.cmd

Далее, необходимо создать еще один скрипт, который будет запускать `worker.cmd` и передавать ему нужные параметры.

Назовем этот скрипт prepare.cmd, содержимое будет таким:

    rem chcp 1251 >nul
    
    c:\testing\worker.cmd 8.3.10.2252 "MyApplication" admin 123456 "C:\Users\Administrator\Desktop\MyApplication\init.dt" tester 654321 "tcp://server/myapplication"

Примечание: удалите rem в первой строке, если у вас используются русские символы и ваша операционная система неверно их интерпретирует в командной строке.

Данный скрипт, вызовет worker.cmd, передаст ему параметры, тот в свою очередь подготовит базу для тестирования. Используя такой подход, можно организовать тестирование нескольких приложений, разместив служебные данные по папкам.

### Запуск сервера 1С

Несколько слов о запуске сервера 1С:Предприятие. Я рекомендую на серверной части тестовой среды ставить сервер приложений как обычное приложение, а не как сервис. Используйте ярлык запуска `ragent.exe` (установщик платформы создает такие ярлыки автоматически), скопируйте его в общую папку `c:\testing`. Так, у вас будет возможность тестировать приложения разных версий, без того, чтобы использовать специальные средства размещения сервисов разных версий. Очевидно, что сервер приложений должен быть запущен заранее.

### Планирование запуска

На данном этапе, структура папок и файлов готова. Осталось подготовить задание, которое будет запускаться по расписанию каждую ночь (например).

Это задание должно запуститься и выполниться раньше, чем клиентская часть тестирования начнет прогон сценариев. Поэтому время запуска задание запланируйте на час раньше времени запуска задания в клиентской части среды тестирования. При решении этой задачи, можно использовать два подхода: (рекомендованный) [механизм заданий](#TasksDelegation) или планировщик операционной системы. Для полноты картины, в этом параграфе приведен пример с системным планировщиком.

В операционной системе, при помощи механизма планирования задач, создаем задачу на подготовку базы данных для тестирования:

![](/img/2017_08_23_21_08_331.png)

### Итог

Подытожу описанные знания краткой последовательностью действий:

1.  Создаем папку `c:\testing`
2.  Создаем там файл `worker.cmd`
3.  Опционально: размещаем ярлык запуска сервера 1С как приложения, с нужной версией сервера 1С. Запускаем сервер 1С
4.  Создаем еще одну папку, под тестируемую конфигурацию, например `c:\Users\Administrator\Desktop\MyApplication`
5.  В эту папку кладем:
    1.  Скрипт `prepare.cmd`
    2.  Файл выгрузки `init.dt`
6.  Используя [Механизм заданий](#TasksDelegation) или планировщик операционной системы, создаем задачу по расписанию и пускаем её за час до начала прогона сценариев.

Переходим к настройке клиентской части окружения тестовой среды.

Запуск тестирования
-------------------

На сервере с клиентской частью, необходимо установить тонкий клиент нужной для тестов версии.

Запуск тестов по расписанию возможен за счет [механизма заданий](http://test1c.com/#TasksDelegation) или настройки планировщика запуска программ средствами операционной системы.

Например, в операционной системе Windows, для этого можно воспользоваться программой Планировщик задач.

В общем случае, для запуска требуется выполнить следующую команду:

    "C:\Program Files (x86)\1cv8\8.3.8.2088\bin\1CV8C.exe" /IBName"Тестер" /N"Администратор" /C"ЗапуститьERP2тесты" /TESTMANAGER

Где:

`C:\Program Files (x86)\1cv8\8.3.8.2088\bin\1CV8C.exe`

путь к запускаемой версии платформы

`/IBName"Тестер"`

название информационной базы в списке информационных баз

`/N"Администратор"`

имя пользователя (используйте `/P` если нужно задать пароль)

`/C"ЗапуститьERP2тесты"`

путь к запускаемому сценарию. Также, есть возможность явного указания приложения, в таком формате: `/C"ERP2#ЗапуститьERP2тесты"`

Пример:

![](/img/2016_11_17_16_11_481.png)

В коде самого теста, может быть произведен запуск тестируемого приложения, например так:

    // Запуск клиента тестирования
    команда = """C:\Program Files (x86)\1cv8\8.3.8.2088\bin\1CV8C.exe"" /S""localhost\erp2"" /N""Бухлалтер"" /TESTCLIENT";
    ЗапуститьПриложение ( команда );
    
    // Ждем 5 секунд, пока запустится
    Пауза ( 5 );
    
    // И дальше пошли выполнять тесты
    Подключить ();
    
    // и т.д.

Более полный пример сценарного теста, который запускает все остальные тесты смотрите в демонстрационной базе, тест называется `ЗапуститьERP2тесты`, либо на [github](https://github.com/grumagargler/ERP2/blob/master/%D0%97%D0%B0%D0%BF%D1%83%D1%81%D1%82%D0%B8%D1%82%D1%8CERP2%D1%82%D0%B5%D1%81%D1%82%D1%8B.1c.bsl)
