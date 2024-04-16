# AsteroidKineticEnergy

Simple calculations of asteroid impact kinetic energy (KE).

Includes calculations for 1-km asteroids of different types and for Ceres, the latter in comparison to the energy released by a 10-megaton hydrogen bomb.

Python, Julia, Fortran, C++, and Rust implementations are provided for comparison.

Fortran and C++ provide IEEE fixed-width floating point numbers starting with Fortran 2003/2008 and C++23, respectively. For Python, we rely on Numpy for accurate floating point calculations. Julia and Rust provide these facilities by default, resulting in cleaner syntax.

## Usage

```shell
python main.py
julia main.jl
gfortran main.f08 -o main_f08.exe
./main_f08.exe
rustc main.rs -o main_rs.exe -C debuginfo=0 -C opt-level=3  # same as 'cargo build --release'
./main_rs.exe
gcc main.cc -o main_cc.exe -std=c++23
./main_cc.exe
```

## Output

```shell

 ---------------------------------------------------------------
 Results:
 ---------------------------------------------------------------
 10-megaton bomb KE (erg):       4.20E+23

 1-km asteroid C-type KE (erg):  4.53E+26
 1-km asteroid S-type KE (erg):  8.90E+26
 1-km asteroid M-type KE (erg):  1.75E+27

 1-km asteroid mean KE (erg):    1.03E+27

 Ceres asteroid KE (erg):        5.89E+35
 Difference factor (x):          1402688000000.0
 Difference factor (x):          1.40E+12
 ---------------------------------------------------------------

```

## Results

There are estimated to be around 910 near-Earth asteroids larger than 1-km in diameter. Assuming the absolute best-case scenario of a 1-km asteroid of the lowest density traveling at the escape velocity of Earth's gravitational field, each asteroid would carry more energy than 1,078 10-megaton nuclear bombs. In other words, each asteroid is _minimally_ equivalent to 1-gigaton of TNT! For larger, denser, and/or faster objects, the kinetic energy is significantly larger. Any of these could trigger another [mass exinction event](https://en.wikipedia.org/wiki/List_of_extinction_events) on Earth, elimating 80% of species or more.

If the largest asteroid in our solar system's asteroid belt, Ceres, were to impact Earth, it would carry kinetic energy equivalent to the energy released by 1.40e+12 or 1.4 trillion 10-megaton bombs. It is perfectly possible that larger objects from outside our solar system (i.e., interstellar objects) could also cross the Earth's path, carrying even more energy. Did I mention that our solar system also has a larger and more massive asteroid belt called the Kuiper belt?

Support NASA and ESA in their efforts to combat this, the greatest threat to our planet. Changes to the Earth's atmospheric and oceanic composition and temperature, while also cause for concern, are far less likely to end life on Earth in another mass extinction event.

## License

MIT License
