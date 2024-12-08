# Performance of various programming languages on basic dictionary + random generation operations

Comparing various programming languages on a [dictionary](https://en.wikipedia.org/wiki/Associative_array) and [random generation operations](https://en.wikipedia.org/wiki/Linear_congruential_generator) - performance of language (lower is better) on a machine with main components:

* Motherboard: [MPG B550 GAMING CARBON WIFI motherboard](https://www.msi.com/Motherboard/MPG-B550-GAMING-CARBON-WIFI)
* CPU: [AMD Ryzen 5 3600X (12) @ 3.800GHz processor](https://www.amd.com/en/products/cpu/amd-ryzen-5-3600x)
* RAM: [CORSAIR](https://www.corsair.com/us/en/) - [128 GB SDRAM DDR4 3200 memory](https://www.newegg.com/corsair-64gb-288-pin-ddr4-sdram/p/N82E16820236586)

This was supposed to be single-threaded test, but Go language & Java use a bit more than one thread on a CPU, hence measured times are adjusted to give more fair time scores (adjusted time).

Custom C++ (maincustom.c++) is just to show that in C++ you can often write your own code for your scenario to even further improve performance of your code. It has custom random operations, custom dictionary and custom string to achieve this. Speed improvements can be quite significant. You can probably do so also in C#, but with higher level languages, you probably do not want to spend time on this.

![comp](./images/perfcomp_final.png)
