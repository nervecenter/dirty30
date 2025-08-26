
List asciiHistogram := method(
  maxBarLen := 30
  freqs := self uniqueCount
  maxCount := freqs map(f, f last) max
  freqs sortInPlaceBy(block(a, b, a first < b first))
  freqs foreach(f,
    val := f first
    freq := f last
    proportion := (freq / (self size)) * 100.0
    barLen := ((freq / maxCount) * maxBarLen) ceil
    bar := "+" repeated(barLen)
    "#{val asString(3, 0)}\t#{freq asString(5, 0)}\t#{proportion asString(0, 1)}\t\t#{bar}" interpolate println
  )
)

rolld6 := method(
  (Random value * 6) ceil
)

rollNd6 := method(n,
  Range 1 to(n) map(rolld6)
)

dirtyN := method(numDice,
  numRolls := 0
  while(numDice > 0,
    numDice = rollNd6(numDice) select(d, d < 6) size
    numRolls = numRolls + 1
  )
  numRolls
)

dirty30 := method(dirtyN(30))

Range 1 to(100000) map(futureSend(dirty30)) asciiHistogram
