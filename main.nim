import os
import json, sequtils
import parsecsv

proc toJson(data: seq[tuple[k, v: string]]): JsonNode =
  ## Функция реализует преобразование строки данных в JSON-ноду

proc readCSV(filename: string): seq[JsonNode] =
  ## Функция реализует чтение данных из принятого файла
  ## и упаковывает их в последовательность Json-нод
  var csv: CsvParser
  # Загрузите заголовок
  # Зачитайте строки из файла, создайте Json-ноду и добавьте их в result
  # Для простоты, рекомендуется воспользоваться функцией zip из sequtils

proc loadCSV(filename: string) {. thread .} =
  ## На данный момент, функция всего лишь
  ## отображает результат чтения данных из CSV
  ## Именно эта функция должна вызываться в потоке
  echo (%* readCSV(filename)).pretty

when isMainModule:
  ## Обработайте файле в многопоточном режиме
  ## Количество потоков == количеству файлов в папке "data"
