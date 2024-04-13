# asteroid_kinetic_energy.py
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

from typing import TypedDict
from decimal import Decimal
import math


class AsteroidDensityMean(TypedDict):
    type: str
    density: float


asteroid_density: AsteroidDensityMean = {  # g/cm3
    "c-type": 1.38,
    "s-type": 2.71,
    "m-type": 5.32,
}


velocity_escape_cm_s: float = 1.12e6  # cm/s
mass_asteroid_ceres_g: float = 9.393e23  # g
ke_bomb_10megaton_erg: float = 4.2e23  # erg


def sphere_volume(diameter: float) -> float:
    radius: float = diameter / 2
    return (4 / 3) * math.pi * radius**3


def km3_to_cm3(km3: float) -> float:
    return km3 * 1e15


def kg_to_g(kg: float) -> float:
    return kg * 1e3


def km_to_cm(km: float) -> float:
    return km * 1e5


def ton_to_erg(ton: float) -> float:
    return ton * 3.6e16


def erg_to_ton(erg: float) -> float:
    return erg / 3.6e16


def mass_from_volume_density(volume: float, density: float) -> float:
    return volume * density


def kinetic_energy(mass: float, velocity: float) -> float:
    return 0.5 * mass * velocity**2


def main():
    diameter_asteroid_km: float = 1
    volume_asteroid_km3 = sphere_volume(diameter_asteroid_km)
    volume_asteroid_cm3 = km3_to_cm3(volume_asteroid_km3)

    mass_asteroid_ctype_g = mass_from_volume_density(
        volume_asteroid_cm3, asteroid_density["c-type"]
    )
    mass_asteroid_stype_g = mass_from_volume_density(
        volume_asteroid_cm3, asteroid_density["s-type"]
    )
    mass_asteroid_mtype_g = mass_from_volume_density(
        volume_asteroid_cm3, asteroid_density["m-type"]
    )

    ke_asteroid_ctype_erg = kinetic_energy(mass_asteroid_ctype_g, velocity_escape_cm_s)
    ke_asteroid_stype_erg = kinetic_energy(mass_asteroid_stype_g, velocity_escape_cm_s)
    ke_asteroid_mtype_erg = kinetic_energy(mass_asteroid_mtype_g, velocity_escape_cm_s)

    ke_asteroid_1km_mean_erg = (
        ke_asteroid_ctype_erg + ke_asteroid_stype_erg + ke_asteroid_mtype_erg
    ) / 3

    ke_asteroid_ceres_erg = kinetic_energy(mass_asteroid_ceres_g, velocity_escape_cm_s)
    asteroid_ceres_ke_difference_factor = ke_asteroid_ceres_erg / ke_bomb_10megaton_erg

    print()
    print("Results:")
    print("---------------------------------------------------------------")
    print(f"10 megaton hydrogen bomb KE (erg): {ke_bomb_10megaton_erg}")
    print()
    print(f"1-km asteroid C-type KE (erg): {ke_asteroid_ctype_erg}")
    print(f"                        (ton): {Decimal(erg_to_ton(ke_asteroid_ctype_erg)):.2e}")
    print(f"1-km asteroid S-type KE (erg): {ke_asteroid_stype_erg}")
    print(f"                        (ton): {Decimal(erg_to_ton(ke_asteroid_stype_erg)):.2e}")
    print(f"1-km asteroid M-type KE (erg): {ke_asteroid_mtype_erg}")
    print(f"                        (ton): {Decimal(erg_to_ton(ke_asteroid_mtype_erg)):.2e}")
    print()
    print(f"1-km asteroid mean KE (erg): {ke_asteroid_1km_mean_erg}")
    print(f"                      (ton): {Decimal(erg_to_ton(ke_asteroid_1km_mean_erg)):.2e}")
    print()
    print(f"Ceres asteroid KE (erg): {ke_asteroid_ceres_erg}")
    print(f"                  (ton): {Decimal(erg_to_ton(ke_asteroid_ceres_erg)):.2e}")
    print(f"Difference factor (x): {asteroid_ceres_ke_difference_factor}")
    print(f"Difference factor (x): {Decimal(asteroid_ceres_ke_difference_factor):.2e}")
    print("---------------------------------------------------------------")


if __name__ == "__main__":
    main()
