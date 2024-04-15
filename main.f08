!! main.f08
!!
!! DESCRIPTION:
!!   Simple calculations of asteroid impact kinetic energy in comparison to 10 megatons of TNT.
!!
!! AUTHOR:
!!   Adam Erickson, Ph.D.
!!
!! NOTES:
!! - Kinetic energy units are CGS not SI, where 1 erg = 10^−7 joules.
!!

!!!! Program

program main

    ! enable IEEE fixed-width 64-bit floating point numbers.
    use, intrinsic :: iso_fortran_env, only: real64

    ! disable dangerous implicit variable types.
    implicit none

    ! parameters
    real(real64), parameter :: pi = 3.14159265358979323846264338_real64

    ! average density (g/cm3) for c-type, s-type, m-type asteroids.
    real(real64), dimension(3), parameter :: asteroid_density = [1.38, 2.71, 5.32]

    real(real64), parameter :: velocity_escape_cm_s  = 1.12e6    ! cm/s
    real(real64), parameter :: mass_asteroid_ceres_g = 9.393e23  ! g
    real(real64), parameter :: ke_bomb_10megaton_erg = 4.2e23    ! erg
    real(real64), parameter :: diameter_asteroid_km  = 1.0       ! km

    ! variables (results)
    real(real64) :: volume_asteroid_km3, volume_asteroid_cm3
    real(real64) :: mass_asteroid_ctype_g, mass_asteroid_stype_g, mass_asteroid_mtype_g
    real(real64) :: ke_asteroid_ctype_erg, ke_asteroid_stype_erg, ke_asteroid_mtype_erg
    real(real64) :: ke_asteroid_1km_mean_erg, ke_asteroid_ceres_erg, ke_difference_factor

    volume_asteroid_km3  = sphere_volume(diameter_asteroid_km)
    volume_asteroid_cm3  = km3_to_cm3(volume_asteroid_km3)

    mass_asteroid_ctype_g = mass_from_volume_density(volume_asteroid_cm3, asteroid_density(1))
    mass_asteroid_stype_g = mass_from_volume_density(volume_asteroid_cm3, asteroid_density(2))
    mass_asteroid_mtype_g = mass_from_volume_density(volume_asteroid_cm3, asteroid_density(3))

    ke_asteroid_ctype_erg = kinetic_energy(mass_asteroid_ctype_g, velocity_escape_cm_s)
    ke_asteroid_stype_erg = kinetic_energy(mass_asteroid_stype_g, velocity_escape_cm_s)
    ke_asteroid_mtype_erg = kinetic_energy(mass_asteroid_mtype_g, velocity_escape_cm_s)

    ke_asteroid_1km_mean_erg = (ke_asteroid_ctype_erg + ke_asteroid_stype_erg + ke_asteroid_mtype_erg) / 3.0

    ke_asteroid_ceres_erg = kinetic_energy(mass_asteroid_ceres_g, velocity_escape_cm_s)
    ke_difference_factor  = ke_asteroid_ceres_erg / ke_bomb_10megaton_erg

    write(*,*)
    write(*,*) "---------------------------------------------------------------"
    write(*,*) "Results:"
    write(*,*) "---------------------------------------------------------------"
    write(*, '(1x,a,5x,es10.2)') "10-megaton bomb KE (erg):", ke_bomb_10megaton_erg
    write(*,*)
    write(*, '(1x,a,es10.2)') "1-km C-type asteroid KE (erg):", ke_asteroid_ctype_erg
    write(*, '(1x,a,es10.2)') "1-km S-type asteroid KE (erg):", ke_asteroid_stype_erg
    write(*, '(1x,a,es10.2)') "1-km M-type asteroid KE (erg):", ke_asteroid_mtype_erg
    write(*,*)
    write(*, '(1x,a,1x,es10.2)') "1-km mean asteroid KEE (erg):", ke_asteroid_1km_mean_erg
    write(*,*)
    write(*, '(1x,a,5x,es10.2)') "Ceres asteroid KE  (erg):", ke_asteroid_ceres_erg
    write(*, '(1x,a,7x,f16.1)') "Difference factor (erg):", ke_difference_factor
    write(*, '(a,8x,es10.2)') " Difference factor (x):", ke_difference_factor
    write(*,*) "---------------------------------------------------------------"
    write(*,*)

!!!! Procedures (functions, subroutines)
contains

    function sphere_volume(diameter) result(volume)
        real(real64), intent(in) :: diameter
        real(real64) :: radius, volume
        radius = diameter / 2
        volume = (4.0 / 3.0) * pi * radius**3
    end function sphere_volume

    function km3_to_cm3(km3) result(cm3)
        real(real64), intent(in) :: km3
        real(real64) :: cm3
        cm3 = km3 * 1e15
    end function km3_to_cm3

    function kg_to_g(kg) result(g)
        real(real64), intent(in) :: kg
        real(real64) :: g
        g = kg * 1e3
    end function kg_to_g

    function km_to_cm(km) result(cm)
        real(real64), intent(in) :: km
        real(real64) :: cm
        cm = km * 1e5
    end function km_to_cm

    function ton_to_erg(ton) result(erg)
        real(real64), intent(in) :: ton
        real(real64) :: erg
        erg = ton * 3.6e16
    end function ton_to_erg

    function erg_to_ton(erg) result(ton)
        real(real64), intent(in) :: erg
        real(real64) :: ton
        ton = erg / 3.6e16
    end function erg_to_ton

    function mass_from_volume_density(volume, density) result(mass)
        real(real64), intent(in) :: volume, density
        real(real64) :: mass
        mass = volume * density
    end function mass_from_volume_density

    function kinetic_energy(mass, velocity) result(ke)
        real(real64), intent(in) :: mass, velocity
        real(real64) :: ke
        ke = 0.5 * mass * velocity**2
    end function kinetic_energy

end program main
