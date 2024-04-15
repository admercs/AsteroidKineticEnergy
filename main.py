# main.py
#
# DESCRIPTION:
#   Simple calculations of asteroid impact kinetic energy in comparison to 10 megatons of TNT.
#
# AUTHOR:
#   Adam Erickson, Ph.D.
#
# NOTES:
# - Kinetic energy units are CGS not SI, where 1 erg = 10^−7 joules.
#

import numpy as np

### Parameters

# average density (g/cm3) for c-type, s-type, m-type asteroids.
asteroid_density: np.float64 = np.float64([1.38, 2.71, 5.32])

velocity_escape_cm_s: np.float64 = 1.12e6  # cm/s
mass_asteroid_ceres_g: np.float64 = 9.393e23  # g
ke_bomb_10megaton_erg: np.float64 = 4.2e23  # erg

### Functions

def sphere_volume(diameter: np.float64) -> np.float64:
    radius: np.float64 = diameter / np.float64(2.0)
    return np.float64(4.0 / 3.0) * np.pi * np.power(radius, 3)


def km3_to_cm3(km3: np.float64) -> np.float64:
    return km3 * np.float64(1e15)


def kg_to_g(kg: np.float64) -> np.float64:
    return kg * np.float64(1e3)


def km_to_cm(km: np.float64) -> np.float64:
    return km * np.float64(1e5)


def ton_to_erg(ton: np.float64) -> np.float64:
    return ton * np.float64(3.6e16)


def erg_to_ton(erg: np.float64) -> np.float64:
    return erg / np.float64(3.6e16)


def mass_from_volume_density(volume: np.float64, density: np.float64) -> np.float64:
    return volume * density


def kinetic_energy(mass: np.float64, velocity: np.float64) -> np.float64:
    return np.float64(0.5) * mass * np.power(velocity, 2)

### Main

def main():
    diameter_asteroid_km: np.float64 = np.float64(1.0)

    volume_asteroid_km3: np.float64 = sphere_volume(diameter_asteroid_km)
    volume_asteroid_cm3: np.float64 = km3_to_cm3(volume_asteroid_km3)

    mass_asteroid_ctype_g: np.float64 = mass_from_volume_density(
        volume_asteroid_cm3, asteroid_density[0]
    )
    mass_asteroid_stype_g: np.float64 = mass_from_volume_density(
        volume_asteroid_cm3, asteroid_density[1]
    )
    mass_asteroid_mtype_g: np.float64 = mass_from_volume_density(
        volume_asteroid_cm3, asteroid_density[2]
    )

    ke_asteroid_ctype_erg: np.float64 = kinetic_energy(
        mass_asteroid_ctype_g, velocity_escape_cm_s
    )
    ke_asteroid_stype_erg: np.float64 = kinetic_energy(
        mass_asteroid_stype_g, velocity_escape_cm_s
    )
    ke_asteroid_mtype_erg: np.float64 = kinetic_energy(
        mass_asteroid_mtype_g, velocity_escape_cm_s
    )

    ke_asteroid_1km_mean_erg: np.float64 = (
        ke_asteroid_ctype_erg + ke_asteroid_stype_erg + ke_asteroid_mtype_erg
    ) / 3

    ke_asteroid_ceres_erg: np.float64 = kinetic_energy(
        mass_asteroid_ceres_g, velocity_escape_cm_s
    )
    ke_difference_factor: np.float64 = ke_asteroid_ceres_erg / ke_bomb_10megaton_erg

    print()
    print(" ---------------------------------------------------------------")
    print(" Results:")
    print(" ---------------------------------------------------------------")
    print(f" 10-megaton bomb KE (erg):       {ke_bomb_10megaton_erg:.2E}")
    print()
    print(f" 1-km asteroid C-type KE (erg):  {ke_asteroid_ctype_erg:.2E}")
    print(f" 1-km asteroid S-type KE (erg):  {ke_asteroid_stype_erg:.2E}")
    print(f" 1-km asteroid M-type KE (erg):  {ke_asteroid_mtype_erg:.2E}")
    print()
    print(f" 1-km asteroid mean KE (erg):    {ke_asteroid_1km_mean_erg:.2E}")
    print()
    print(f" Ceres asteroid KE (erg):        {ke_asteroid_ceres_erg:.2E}")
    print(f" Difference factor (x):          {ke_difference_factor:.1F}")
    print(f" Difference factor (x):          {ke_difference_factor:.2E}")
    print(" ---------------------------------------------------------------")

if __name__ == "__main__":
    main()
