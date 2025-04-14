import os
import json, sequtils,strutils
import parsecsv

proc toJson(data: seq[tuple[k, v: string]]): JsonNode =
  result = newJObject()
  for item in data:
    result.add(item.k, %* item.v)

proc readCSV(filename: string): seq[JsonNode] =
  var csv: CsvParser
  csv.open(filename)
  csv.readHeaderRow()
  while  csv.readRow():
    result.add(toJson(zip(csv.headers,csv.row)))
  csv.close()

proc loadCSV(filename: string) {. thread .} =
  echo (%* readCSV(filename)).pretty

when isMainModule:
  let files = walkDirRec("data").toSeq.filter(proc(x: string): bool = x.splitFile.ext  == ".csv")
  var threads =  newSeq[Thread[string]](len(files))
  for i in threads.low .. threads.high:
    createThread(threads[i], loadCSV, files[i])
  joinThreads(threads)
