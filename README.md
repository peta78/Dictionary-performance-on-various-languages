# Performance of various programming languages on basic dictionary + random generation operations

Comparing various programming languages on a [dictionary](https://en.wikipedia.org/wiki/Associative_array) and [random generation operations](https://en.wikipedia.org/wiki/Linear_congruential_generator) - performance of language (lower is better) on a machine with main components:

This was supposed to be single-threaded test, but Go language & Java use a bit more than one thread on a CPU, hence measured times are adjusted to give more fair time scores (adjusted time).

Custom C++ (maincustom.c++) is just to show that in C++ you can often write your own code for your scenario to even further improve performance of your code. It has custom random operations, custom dictionary and custom string to achieve this. Speed improvements can be quite significant. You can probably do so also in C#, but with higher level languages, you probably do not want to spend time on this.

On [CachyOS](https://cachyos.org/) with [Arch Linux](https://archlinux.org/):

|  Language  |              Version               | Adjusted time based on CPU usage (seconds) | Average time (seconds) | Average CPU usage (%) | Average memory usage (%) |
|----------------------|-------------------------------------------------|--------------------------------------------|------------------------|---------------------------|------------------------------|
| custom c++ | (0,0) | 0.272 | 0.267 | 6.348 | 21.823 |
| c# | 9.0.101 | 0.924 | 0.901 | 6.407 | 17.765 |
| pypy |  2.7.18 (7253,  30 2024, 08:27:53) | 0.930 | 0.912 | 6.370 | 17.993 |
| javascript | 23.3.0 | 1.479 | 1.439 | 6.425 | 18.894 |
| c++ | ++ () 14.2.1 20240910 | 1.555 | 1.527 | 6.365 | 18.301 |
| java |  23 2024-09-17 | 1.835 | 0.785 | 14.620 | 28.451 |
| go |   1.23.4 /64 | 2.820 | 1.999 | 8.815 | 17.977 |
| julia |   1.11.2 | 3.236 | 3.173 | 6.373 | 16.006 |
| perl |    5,  40,  0 (5.40.0)   86_64--- | 3.601 | 3.551 | 6.338 | 18.814 |
| python3 |  3.12.7 | 12.209 | 11.837 | 6.447 | 17.901 |
