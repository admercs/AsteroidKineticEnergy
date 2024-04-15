# main.jl
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

using Printf

### Parameters

# average density (g/cm3) for c-type, s-type, m-type asteroids.
asteroid_density::Vector{Float64} = [1.38, 2.71, 5.32]

velocity_escape_cm_s::Float64 = 1.12e6  # cm/s
mass_asteroid_ceres_g::Float64 = 9.393e23  # g
ke_bomb_10megaton_erg::Float64 = 4.2e23  # erg

### Functions

function sphere_volume(diameter::Float64)
    :Float64
    radius::Float64 = diameter / Float64(2.0)
    return Float64(4.0 / 3.0) * Float64(pi) * radius^3
end

function km3_to_cm3(km3::Float64) 
    :Float64
    return km3 * Float64(1e15)
end

function kg_to_g(kg::Float64)
    :Float64
    return kg * Float64(1e3)
end

function km_to_cm(km::Float64)
    :Float64
    return km * Float64(1e5)
end

function ton_to_erg(ton::Float64)
    :Float64
    return ton * Float64(3.6e16)
end

function erg_to_ton(erg::Float64)
    :Float64
    return erg / Float64(3.6e16)
end

function mass_from_volume_density(volume::Float64, density::Float64)
    :Float64
    return volume * density
end

function kinetic_energy(mass::Float64, velocity::Float64)
    :Float64
    return Float64(0.5) * mass * velocity^2
end

### Main

function main()
    :Nothing

    diameter_asteroid_km::Float64 = 1.0

    volume_asteroid_km3::Float64 = sphere_volume(diameter_asteroid_km)
    volume_asteroid_cm3::Float64 = km3_to_cm3(volume_asteroid_km3)

    mass_asteroid_ctype_g::Float64 = mass_from_volume_density(
        volume_asteroid_cm3, asteroid_density[1]
    )
    mass_asteroid_stype_g::Float64 = mass_from_volume_density(
        volume_asteroid_cm3, asteroid_density[2]
    )
    mass_asteroid_mtype_g::Float64 = mass_from_volume_density(
        volume_asteroid_cm3, asteroid_density[3]
    )

    ke_asteroid_ctype_erg::Float64 = kinetic_energy(
        mass_asteroid_ctype_g, velocity_escape_cm_s
    )
    ke_asteroid_stype_erg::Float64 = kinetic_energy(
        mass_asteroid_stype_g, velocity_escape_cm_s
    )
    ke_asteroid_mtype_erg::Float64 = kinetic_energy(
        mass_asteroid_mtype_g, velocity_escape_cm_s
    )

    ke_asteroid_1km_mean_erg::Float64 = (
        ke_asteroid_ctype_erg + ke_asteroid_stype_erg + ke_asteroid_mtype_erg
    ) / 3

    ke_asteroid_ceres_erg::Float64 = kinetic_energy(
        mass_asteroid_ceres_g, velocity_escape_cm_s
    )
    ke_difference_factor::Float64 = ke_asteroid_ceres_erg / ke_bomb_10megaton_erg

    println()
    println(" ---------------------------------------------------------------")
    println(" Results:")
    println(" ---------------------------------------------------------------")
    println(" 10-megaton bomb KE (erg):       $(@sprintf("%.2E", ke_bomb_10megaton_erg))")
    println()
    println(" 1-km asteroid C-type KE (erg):  $(@sprintf("%.2E", ke_asteroid_ctype_erg))")
    println(" 1-km asteroid S-type KE (erg):  $(@sprintf("%.2E", ke_asteroid_stype_erg))")
    println(" 1-km asteroid M-type KE (erg):  $(@sprintf("%.2E", ke_asteroid_mtype_erg))")
    println()
    println(" 1-km asteroid mean KE (erg):    $(@sprintf("%.2E", ke_asteroid_1km_mean_erg))")
    println()
    println(" Ceres asteroid KE (erg):        $(@sprintf("%.2E", ke_asteroid_ceres_erg))")
    println(" Difference factor (x):          $(@sprintf("%.1f", ke_difference_factor))")
    println(" Difference factor (x):          $(@sprintf("%.2E", ke_difference_factor))")
    println(" ---------------------------------------------------------------")
end

main()
