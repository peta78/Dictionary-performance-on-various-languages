# Performance of various programming languages on basic dictionary + random generation operations

Comparing various programming languages on a [dictionary](https://en.wikipedia.org/wiki/Associative_array) and [random generation operations](https://en.wikipedia.org/wiki/Linear_congruential_generator) - performance of language (lower is better) on a machine with main components:

This was supposed to be single-threaded test, but Go language & Java use a bit more than one thread on a CPU, hence measured times are adjusted to give more fair time scores (adjusted time).

Custom C++ (maincustom.c++) is just to show that in C++ you can often write your own code for your scenario to even further improve performance of your code. It has custom random operations, custom dictionary and custom string to achieve this. Speed improvements can be quite significant. You can probably do so also in C#, but with higher level languages, you probably do not want to spend time on this.

On arch linux:

|  Language  |              Version               | Adjusted time based on CPU usage (seconds) | Average time (seconds) | Average CPU usage (%) | Average memory usage (%) |
|----------------------|-------------------------------------------------|--------------------------------------------|------------------------|---------------------------|------------------------------|
| custom c++ |               (0,0)                |                   0.280                    |         0.271          |           6.465           |            22.407            |
|    rust    |     1.83.0 (9035623 2024-11-26)    |                   0.856                    |         0.831          |           6.441           |            16.267            |
|     c#     |              9.0.101               |                   0.949                    |         0.911          |           6.510           |            16.953            |
|    pypy    |  2.7.18 (7253,  30 2024, 08:27:53) |                   0.952                    |         0.917          |           6.486           |            17.257            |
|    c++     |       ++ () 14.2.1 20240910        |                   1.555                    |         1.503          |           6.466           |            16.287            |
| javascript |               23.1.0               |                   1.655                    |         1.580          |           6.548           |            16.567            |
|    java    |            23 2024-09-17           |                   1.863                    |         0.788          |           14.778          |            26.487            |
|     go     |              1.23.4 /64            |                   2.850                    |         1.969          |           9.047           |            17.740            |
|   julia    |                1.11.2              |                   3.298                    |         3.193          |           6.455           |            15.235            |
|    perl    |    5,  40,  0 (5.40.0)   86_64---  |                   4.037                    |         3.874          |           6.513           |            17.477            |
|  python3   |               3.12.7               |                   11.504                   |         10.831         |           6.638           |            16.336            |

![comp](./images/perfcomp_final_manjaro.png)
