var cups = new scala.collection.mutable.DoubleLinkedList[Integer]
cups.append(Source.fromFile("sampleinput.txt").getLines().head.split("").map(_.toInt).toList)

val CUPS = 999999
val TIMES = 10 * 1000 * 1000

cups += (cups.max).upto(CUPS)

(1 to TIMES).foreach {
  val cc = cups.head
  cups.remove()
  val newCups = cups.drop(1).take(3)

  val finder = if (cc - 1 == 0) CUPS else cc - 1
  val cursor = cups.dropWhile(_ != finder)
  cursor.insert(newCups)

  cups.append(scala.collection.mutable.LinkedList[Integer](cc))
}

print(cups)
