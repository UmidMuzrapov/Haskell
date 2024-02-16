## Squares
This is the requirements for the square.h
 Write a function drawSquares squares, of type [Square] -> IO () that prints an ASCII "image" of the Squares in the list squares.

A square is represented with a four-tuple that specifies the square's upper-left corner (x and y coordinates), its size (i.e., width and height—it's a square), and a two-character string that specifies the square's border and fill characters. For example, (8,4,5,"*+") specifies a square with its upper-left corner at (8,4); a width and height of 5; and '*' and '+' for its border and fill characters, respectively.

Like String on slide 155, Square is a type synonym:

type Square = (Int,Int,Int,[Char])

The upper-left corner of the ASCII "image" is (0,0). The bounds of the image are calculated such that it fully contains all the squares, and has an empty row/column on the bottom/right.

Make these assumptions:

    x and y coordinates are non-negative.
    The size of a square is always >= 2.
    The border and fill string always has a length of 2.
    drawSquares is never called with an empty list. 

Here's an example with one square:

```
> drawSquares [(2,2,5,"+-")]
........
........
..+++++.
..+---+.
..+---+.
..+---+.
..+++++.
........
```

Note that drawSquares, like printN and charbox in the section A little output (slide 167+), produces output. To avoid tangling with the details of I/O in Haskell for this problem, start your drawSquares function with the following three lines of code:

drawSquares :: [Square] -> IO ()
drawSquares squares = putStr result
    where
       ...some number of expressions and helper functions that
         build up `result`, a string...

The string result will need to have whatever characters and newlines are required, and that's the challenge of this problem—figuring out how to build up that multiline string!

To help—and hopefully not confuse—here's a trivial version of drawSquares that's "hardwired" for this one-Square list: [(1,1,3,"+-")]

drawSquaresHW _ = putStr result
    where
        result = ".....\n.+++.\n.+-+.\n.+++.\n.....\n"

Execution:
```
> drawSquaresHW () -- "unit" (slide 169) for its unused parameter
.....
.+++.
.+-+.
.+++.
.....
```

Again, I hope that drawSquaresHW doesn't confuse! It's intended to show the connection between

    Binding result to a string that represents the image.
    Calling putStr with result.
    The output being produced. 

Here's a drawing with four squares:
```
> drawSquares [(2,2,5,"Aa"), (12,0,4,"Bb"), (9,5,3,"C "),
               (17,8,2,"Dd")]
............BBBB....
............BbbB....
..AAAAA.....BbbB....
..AaaaA.....BBBB....
..AaaaA.............
..AaaaA..CCC........
..AAAAA..C C........
.........CCC........
.................DD.
.................DD.
....................
```

Due to character cells themselves not being square, the "squares" aren't square either. Their aspect ratio is actually close to 1:2 but we'll ignore that!

If squares overlap, squares appearing later in the list are drawn on top of earlier squares. Examples:
```
> drawSquares [(8,4,5,"**"), (1,1,10,"@@"), (3,5,3,"+ ")]
..............
.@@@@@@@@@@...
.@@@@@@@@@@...
.@@@@@@@@@@...
.@@@@@@@@@@**.
.@@+++@@@@@**.
.@@+ +@@@@@**.
.@@+++@@@@@**.
.@@@@@@@@@@**.
.@@@@@@@@@@...
.@@@@@@@@@@...
..............

> drawSquares (reverse [(8,4,5,"**"), (1,1,10,"@@"),
               (3,5,3,"+ ")])
..............
.@@@@@@@@@@...
.@@@@@@@@@@...
.@@@@@@@@@@...
.@@@@@@@*****.
.@@@@@@@*****.
.@@@@@@@*****.
.@@@@@@@*****.
.@@@@@@@*****.
.@@@@@@@@@@...
.@@@@@@@@@@...
..............
```

(See also: wikipedia.org/wiki/Z-order.)

The character '#' has special meaning when used as a fill character: it specifies a transparent fill. Here's the previous example, but with a transparent fill for the square. We can see through the @ square to the squares underneath it.
```
> drawSquares [(8,4,5,"**"), (1,1,10,"@#"), (3,5,3,"+ ")]
..............
.@@@@@@@@@@...
.@........@...
.@........@...
.@......**@**.
.@.+++..**@**.
.@.+ +..**@**.
.@.+++..**@**.
.@......**@**.
.@........@...
.@@@@@@@@@@...
..............

More examples

> drawSquares [(0,0,2,"a@"),(1,1,2,"b#"),(2,2,2,"c$"),(3,3,2,"d%")]
aa....
abb...
.bcc..
..cdd.
...dd.
......

> drawSquares [(0,0,12,"  "),(5,5,2,"Xy")] -- "  " is two spaces
            .
            .
            .
            .
            .
     XX     .
     XX     .
            .
            .
            .
            .
            .
.............

> drawSquares [(0,5,5,"##"),(50,0,5,"##")]
..................................................#####.
..................................................#...#.
..................................................#...#.
..................................................#...#.
..................................................#####.
#####...................................................
#...#...................................................
#...#...................................................
#...#...................................................
#####...................................................
........................................................
```
