# Performance of various programming languages on basic dictionary + random generation operations

Comparing various programming languages on a [dictionary](https://en.wikipedia.org/wiki/Associative_array) and [random generation operations](https://en.wikipedia.org/wiki/Linear_congruential_generator) - performance of language (lower is better) on a machine with main components:

* Motherboard: [MPG B550 GAMING CARBON WIFI motherboard](https://www.msi.com/Motherboard/MPG-B550-GAMING-CARBON-WIFI)
* CPU: [AMD Ryzen 5 3600X (12) @ 3.800GHz processor](https://www.amd.com/en/products/cpu/amd-ryzen-5-3600x)
* RAM: [CORSAIR](https://www.corsair.com/us/en/) - [128 GB SDRAM DDR4 3200 memory](https://www.newegg.com/corsair-64gb-288-pin-ddr4-sdram/p/N82E16820236586)

This was supposed to be single-threaded test, but Go language & Java use a bit more than one thread on a CPU, hence measured times are adjusted to give more fair time scores (adjusted time).

Custom C++ (maincustom.c++) is just to show that in C++ you can often write your own code for your scenario to even further improve performance of your code. It has custom random operations, custom dictionary and custom string to achieve this. Speed improvements can be quite significant. You can probably do so also in C#, but with higher level languages, you probably do not want to spend time on this.

![comp](./images/perfcomp_final.png)

Lower is better - on Manjaro Linux 
Linux-6.9.12-3-MANJARO-x86_64-with-arch-Manjaro-Linux on 2024-09-12:

+------------+----------------------------------------------------------------------------------------+--------------------------------------------+------------------------+---------------------------+------------------------------+
|  Language  |                                        Version                                         | Adjusted time based on CPU usage (seconds) | Average time (seconds) | Average CPU usage[^1] (%) | Average memory usage[^1] (%) |
+------------+----------------------------------------------------------------------------------------+--------------------------------------------+------------------------+---------------------------+------------------------------+
| custom c++ |                                         (0,0)                                          |                   0.562                    |         0.389          |           9.033           |            21.763            |
|    rust    |                          rustc 1.81.0 (eeb90cda1 2024-09-04)                           |                   1.386                    |         1.029          |           8.420           |            16.536            |
|    pypy    |                  Python 2.7.18 (6aa1e9d13975, Apr 24 2024, 01:57:47)                   |                   1.433                    |         0.910          |           9.839           |            17.172            |
|     c#     |                                        8.0.401                                         |                   1.496                    |         0.933          |           10.017          |            16.853            |
|    c++     |                               g++ (GCC) 14.2.1 20240805                                |                   2.572                    |         1.634          |           9.840           |            17.060            |
| javascript |                                        v22.7.0                                         |                   2.628                    |         1.627          |           10.100          |            16.554            |
|     go     |                            go version go1.23.1 linux/amd64                             |                   4.260                    |         2.195          |           12.129          |            17.753            |
|   julia    |                                  julia version 1.10.4                                  |                   4.776                    |         3.183          |           9.378           |            15.331            |
|    perl    | This is perl 5, version 38, subversion 2 (v5.38.2) built for x86_64-linux-thread-multi |                   5.913                    |         3.815          |           9.687           |            17.671            |
+------------+----------------------------------------------------------------------------------------+--------------------------------------------+------------------------+---------------------------+------------------------------+
