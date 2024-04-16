/* main.cpp

 DESCRIPTION:
   Simple calculations of asteroid impact kinetic energy in comparison to 10
 megatons of TNT.

 AUTHOR:
   Adam Erickson, Ph.D.

 NOTES:
 - Kinetic energy units are CGS not SI, where 1 erg = 10^−7 joules.
*/

#include <cmath>
#include <cstdio>
#include <stdfloat>

using f64_t = std::float64_t;

//// Parameters

constexpr f64_t pi = 3.14159265358979323846264338;
// average density (g/cm3) for c-type, s-type, m-type asteroids.
constexpr f64_t asteroid_density[] = {1.38, 2.71, 5.32};
constexpr f64_t velocity_escape_cm_s = 1.12e6;     // cm/s
constexpr f64_t mass_asteroid_ceres_g = 9.393e23;  // g
constexpr f64_t ke_bomb_10megaton_erg = 4.2e23;    // erg
constexpr f64_t diameter_asteroid_km = 1.0;        // km

//// Functions

f64_t sphere_volume(f64_t diameter) {
  f64_t radius = diameter / 2.0f64;
  return (4.0f64 / 3.0f64) * pi * std::pow(radius, 3.0f64);
}

f64_t km3_to_cm3(f64_t km3) { return km3 * 1.0e15f64; }

f64_t kg_to_g(f64_t kg) { return kg * 1.0e3f64; }

f64_t km_to_cm(f64_t km) { return km * 1.0e5f64; }

f64_t ton_to_erg(f64_t ton) { return ton * 3.6e16f64; }

f64_t erg_to_ton(f64_t erg) { return erg / 3.6e16f64; }

f64_t mass_from_volume_density(f64_t volume, f64_t density) {
  return volume * density;
}

f64_t kinetic_energy(f64_t mass, f64_t velocity) {
  return 0.5f64 * mass * std::pow(velocity, 2.0f64);
}

//// Program

int main() {
  f64_t volume_asteroid_km3 = sphere_volume(diameter_asteroid_km);
  f64_t volume_asteroid_cm3 = km3_to_cm3(volume_asteroid_km3);

  f64_t mass_asteroid_ctype_g =
      mass_from_volume_density(volume_asteroid_cm3, asteroid_density[0]);
  f64_t mass_asteroid_stype_g =
      mass_from_volume_density(volume_asteroid_cm3, asteroid_density[1]);
  f64_t mass_asteroid_mtype_g =
      mass_from_volume_density(volume_asteroid_cm3, asteroid_density[2]);

  f64_t ke_asteroid_ctype_erg =
      kinetic_energy(mass_asteroid_ctype_g, velocity_escape_cm_s);
  f64_t ke_asteroid_stype_erg =
      kinetic_energy(mass_asteroid_stype_g, velocity_escape_cm_s);
  f64_t ke_asteroid_mtype_erg =
      kinetic_energy(mass_asteroid_mtype_g, velocity_escape_cm_s);

  f64_t ke_asteroid_1km_mean_erg =
      (ke_asteroid_ctype_erg + ke_asteroid_stype_erg + ke_asteroid_mtype_erg) /
      3.0f64;

  f64_t ke_asteroid_ceres_erg =
      kinetic_energy(mass_asteroid_ceres_g, velocity_escape_cm_s);
  f64_t ke_difference_factor = ke_asteroid_ceres_erg / ke_bomb_10megaton_erg;

  std::printf("\n");
  std::printf(
      " ---------------------------------------------------------------\n");
  std::printf(" Results:\n");
  std::printf(
      " ---------------------------------------------------------------\n");
  std::printf(" 10-megaton bomb KE (erg):       %.2E\n", ke_bomb_10megaton_erg);
  std::printf("\n");
  std::printf(" 1-km C-type asteroid KE (erg):  %.2E\n", ke_asteroid_ctype_erg);
  std::printf(" 1-km S-type asteroid KE (erg):  %.2E\n", ke_asteroid_stype_erg);
  std::printf(" 1-km M-type asteroid KE (erg):  %.2E\n", ke_asteroid_mtype_erg);
  std::printf("\n");
  std::printf(" 1-km mean asteroid KEE (erg):   %.2E\n",
              ke_asteroid_1km_mean_erg);
  std::printf("\n");
  std::printf(" Ceres asteroid KE  (erg):       %.2E\n", ke_asteroid_ceres_erg);
  std::printf(" Difference factor (erg):        %.1f\n", ke_difference_factor);
  std::printf(" Difference factor (x):          %.2E\n", ke_difference_factor);
  std::printf(
      " ---------------------------------------------------------------\n");
  std::printf("\n");
}
