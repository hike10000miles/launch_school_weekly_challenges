## Weekly challenges from launch school
Each rb file is one single challenge, each challenge comes with a test file. Except the battleship game, which do not have test.

Challenges include:

battleship.rb, a game of battleship runs in your console.

circular_buffer.rb, creat a circlar buffer data structures.

luhn.rb, the Luhn Algorithm, a simple checksum formula used to validate a variety of identification numbers, such as credit card numbers and Canadian Social Insurance Numbers.
The formula verifies a number against its included check digit, which is usually appended to a partial number to generate the full number. This number must pass the following test:
Counting from rightmost digit (which is the check digit) and moving left, double the value of every second digit.
For any digits that thus become 10 or more, subtract 9 from the result.
1111 becomes 2121.
8763 becomes 7733 (from 2×6=12 → 12-9=3 and 2×8=16 → 16-9=7).
Add all these digits together.
1111 becomes 2121 sums as 2+1+2+1 to give a check digit of 6.
8763 becomes 7733, and 7+7+3+3 is 20.
If the total ends in 0 (put another way, if the total modulus 10 is congruent to 0), then the number is valid according to the Luhn formula; else it is not valid. So, 1111 is not valid (as shown above, it comes out to 6), while 8763 is valid (as shown above, it comes out to 20).

minesweeper.rb, like the old game minesweeper,
input:
+-----+
| * * |
|  *  |
|  *  |
|     |
+-----+
output:
+-----+
|1*3*1|
|13*31|
| 2*2 |
| 111 |
+-----+

octal.rb, implement octal to decimal conversion. Given an octal input string, your program should produce a decimal output.

pig_latin.rb, 
Pig Latin is a made-up children's language that's intended to be confusing. It obeys a few simple rules (below), but when it's spoken quickly it's really difficult for non-children (and non-native speakers) to understand.

Rule 1: If a word begins with a vowel sound, add an "ay" sound to the end of the word.
Rule 2: If a word begins with a consonant sound, move it to the end of the word, and then add an "ay" sound to the end of the word.

protein_translation.rb, Lets write a program that will translate RNA sequences into proteins. RNA can be broken into three nucleotide sequences called codons, and then translated to a polypeptide like so:
RNA: "AUGUUUUCU" => translates to

Codons: "AUG", "UUU", "UCU"
=> which become a polypeptide with the following sequence =>

Protein: "Methionine", "Phenylalanine", "Serine"

queen_attack.rb, 
In the game of chess, a queen can attack pieces which are on the same row, column, or diagonal.

A chessboard can be represented by an 8 by 8 array.

So if you're told the white queen is at (2, 3) and the black queen at (5, 6), then you'd know you've got a set-up like so:

_ _ _ _ _ _ _ _
_ _ _ _ _ _ _ _
_ _ _ W _ _ _ _
_ _ _ _ _ _ _ _
_ _ _ _ _ _ _ _
_ _ _ _ _ _ B _
_ _ _ _ _ _ _ _
_ _ _ _ _ _ _ _
You'd also be able to answer whether the queens can attack each other. In this case, that answer would be yes, they can, because both pieces share a diagonal.

secret_handshake.rb,
You and your fellow cohort of those in the "know" when it comes to binary decide to come up with a secret "handshake".

1 = wink
10 = double blink
100 = close your eyes
1000 = jump


10000 = Reverse the order of the operations in the secret handshake.
handshake = SecretHandshake.new 9
handshake.commands # => ["wink","jump"]

handshake = SecretHandshake.new "11001"
handshake.commands # => ["jump","wink"]
The program should consider strings specifying an invalid binary as the value 0.

series.rb,
Write a program that will take a string of digits and give you all the possible consecutive number series of length n in that string.

For example, the string "01234" has the following 3-digit series:

- 012
- 123
- 234
And the following 4-digit series:

- 0123
- 1234

sieve.rb,
Write a program that uses the Sieve of Eratosthenes to find all the primes from 2 up to a given number.

The Sieve of Eratosthenes is a simple, ancient algorithm for finding all prime numbers up to any given limit. It does so by iteratively marking as composite (i.e. not prime) the multiples of each prime, starting with the multiples of 2.

Create your range, starting at two and continuing up to and including the given limit. (i.e. [2, limit]).

The algorithm consists of repeating the following over and over:

take the next available unmarked number in your list (it is prime)
mark all the multiples of that number (they are not prime)
Repeat until you have processed each number in your range. When the algorithm terminates, all the numbers in the list that have not been marked are prime. The wikipedia article has a useful graphic that explains the algorithm: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes

simulator.rb,
## Step 1

The robot factory manufactures robots that have three possible
movements:

- turn right
- turn left
- advance

Robots are placed on a hypothetical infinite grid, facing a particular
direction (north, east, south, or west) at a set of {x,y} coordinates,
e.g., {3,8}.

## Step 2

Robots can pivot left and right.

The robot factory manufactures robots that have three possible
movements:

- turn right
- turn left
- advance

The factory's test facility needs a program to verify robot movements.

There are a number of different rooms of varying sizes, measured in
Robot Units, the distance a robot moves when you instruct it to
`advance`.

The floor of the room is a grid, each square of which measures 1 square
RU (Robot Unit).

The rooms are always oriented so that each wall faces east, south, west,
and north.

The test algorithm is to place a robot at a coordinate in the room,
facing in a particular direction.

The robot then receives a number of instructions, at which point the
testing facility verifies the robot's new position, and in which
direction it is pointing.

## Step 3

The robot factory manufactures robots that have three possible
movements:

- turn right
- turn left
- advance

The robot factory's test facility has a simulator which can take a
string of letters and feed this into a robot as instructions.

- The letter-string "RAALAL" means:
  - Turn right
  - Advance twice
  - Turn left
  - Advance once
  - Turn left yet again
- Say a robot starts at {7, 3} facing north. Then running this stream
  of instructions should leave it at {9, 4} facing west.
