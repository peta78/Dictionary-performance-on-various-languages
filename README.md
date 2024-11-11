# Performance of various programming languages on basic dictionary + random generation operations

Comparing various programming languages on a [dictionary](https://en.wikipedia.org/wiki/Associative_array) and [random generation operations](https://en.wikipedia.org/wiki/Linear_congruential_generator) - performance of language (lower is better) on a Lenovo IdeaPad laptop.

This was supposed to be single-threaded test, but Go language & Java use a bit more than one thread on a CPU, hence measured times are adjusted to give more fair time scores (adjusted time).

Custom C++ (maincustom.c++) is just to show that in C++ you can often write your own code for your scenario to even further improve performance of your code. It has custom random operations, custom dictionary and custom string to achieve this. Speed improvements can be quite significant. You can probably do so also in C#, but with higher level languages, you probably do not want to spend time on this.

![comp](./images/perfcomp_final.png)

Lower is better - on operating system Alpine Linux (Linux-6.6.50-0-lts-x86_64) on 2024-09-12:

|       Language       |                     Version                     | Adjusted time based on CPU usage (seconds) | Average time (seconds) | Average CPU usage (%) | Average memory usage (%) |
|----------------------|-------------------------------------------------|--------------------------------------------|------------------------|---------------------------|------------------------------|
| custom c++ |                      (0,0)                      |                   0.541                    |         0.476          |           7.103           |            26.341            |
|     c#     |                     8.0.401                     |                   1.317                    |         1.077          |           7.645           |            21.842            |
|    rust    |       rustc 1.81.0 (eeb90cda1 2024-09-04)       |                   1.618                    |         1.378          |           7.339           |            21.044            |
|    c++     | g++ (Alpine 13.2.1_git20240309) 13.2.1 20240309 |                   2.314                    |         1.942          |           7.448           |            21.227            |
| javascript |                     v20.15.1                    |                   2.642                    |         2.081          |           7.937           |            21.443            |
|     go     |         go version go1.23.1 linux/amd64         |                   3.775                    |         2.300          |           10.258          |            21.836            |

One of the runs:

![comp](./images/cpumem1.png)

And on Manjaro Linux:

|  Language  |              Version               | Adjusted time based on CPU usage (seconds) | Average time (seconds) | Average CPU usage (%) | Average memory usage (%) |
|----------------------|-------------------------------------------------|--------------------------------------------|------------------------|---------------------------|------------------------------|
| custom c++ |               (0,0)                |                   0.381                    |         0.285          |           8.366           |            23.972            |
|    rust    |      1.82.0 (6511 2024-10-15)      |                   1.207                    |         0.877          |           8.603           |            19.536            |
|     c#     |              8.0.403               |                   1.270                    |         0.951          |           8.342           |            19.684            |
|    pypy    |  2.7.18 (7253,  30 2024, 08:27:53) |                   1.323                    |         0.938          |           8.816           |            18.939            |
|    c++     |       ++ () 14.2.1 20240910        |                   2.328                    |         1.637          |           8.888           |            19.058            |
|    java    |          22.0.2 2024-07-16         |                   2.330                    |         0.807          |           18.047          |            28.384            |
|     go     |              1.23.3 /64            |                   4.109                    |         2.233          |           11.500          |            19.768            |
|   julia    |                1.10.5              |                   4.715                    |         3.318          |           8.881           |            17.671            |
|    perl    |    5,  40,  0 (5.40.0)   86_64---  |                   5.101                    |         3.719          |           8.573           |            20.312            |
|  python3   |               3.13.0               |                   16.933                   |         11.189         |           9.459           |            18.084            |

![comp](./images/perfcomp_final_manjaro.png)


