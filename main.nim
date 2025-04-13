import os
import json, sequtils,strutils
import parsecsv

proc toJson(data: seq[tuple[k, v: string]]): JsonNode =
  var s = "{"
  for item in data:
    s.add(""""$1":"$2",""" % [item.k,item.v])
  s.add("}")
  parseJson(s)
  
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
  var threads: array[9 ,Thread[string]]
  var i = 0
  for item in walkDir("data"):
    createThread(threads[i],loadCSV,item.path)
    i += 1
  joinThreads(threads)
