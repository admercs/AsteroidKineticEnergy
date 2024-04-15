# AsteroidKineticEnergy

Simple calculations of asteroid impact kinetic energy.

Performs calculations for 1-km asteroids of different types as well as Ceres, in comparison to a 10-megaton nuclear bomb.

Python, Julia, Fortran, and Rust implementations are provided for comparison.

Beware the non-fixed-width floating point numbers provided in base Python! Numpy to the rescue. Fortran and C++ provide IEEE fixed-width floating point numbers starting with Fortran2008 and C++23, respectively.

## Usage

```shell
python main.py
julia main.jl
gfortran main.f08 -o main_f08.exe
rustc main.rs -o main_rs.exe
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

## License

MIT License
