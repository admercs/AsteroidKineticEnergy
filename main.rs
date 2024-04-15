// main.rs
//
// DESCRIPTION:
//   Simple calculations of asteroid impact kinetic energy in comparison to 10 megatons of TNT.
//
// AUTHOR:
//   Adam Erickson, Ph.D.
//
// NOTES:
// - Kinetic energy units are CGS not SI, where 1 erg = 10^−7 joules.
//

//// Functions

fn sphere_volume(diameter: f64) -> f64 {
    let pi: f64 = 3.14159265358979323846264338;
    let radius: f64 = diameter / 2.0_f64;
    return (4.0_f64 / 3.0_f64) * pi * radius.powf(3.0);
}

fn km3_to_cm3(km3: f64) -> f64 {
    return km3 * 1.0e15_f64;
}

#[allow(dead_code)]
fn kg_to_g(kg: f64) -> f64 {
    return kg * 1.0e3_f64;
}

#[allow(dead_code)]
fn km_to_cm(km: f64) -> f64 {
    return km * 1.0e5_f64;
}

#[allow(dead_code)]
fn ton_to_erg(ton: f64) -> f64 {
    return ton * 3.6e16_f64;
}

#[allow(dead_code)]
fn erg_to_ton(erg: f64) -> f64 {
    return erg / 3.6e16_f64;
}

fn mass_from_volume_density(volume: f64, density: f64) -> f64 {
    return volume * density;
}

fn kinetic_energy(mass: f64, velocity: f64) -> f64 {
    return 0.5_f64 * mass * velocity.powf(2.0);
}

//// Program

fn main() {
    // average density (g/cm3) for c-type, s-type, m-type asteroids.
    let asteroid_density: [f64; 3] = [1.38, 2.71, 5.32];

    let velocity_escape_cm_s: f64 = 1.12e6; // cm/s
    let mass_asteroid_ceres_g: f64 = 9.393e23; // g
    let ke_bomb_10megaton_erg: f64 = 4.2e23; // erg
    let diameter_asteroid_km: f64 = 1.0; // km

    let volume_asteroid_km3: f64 = sphere_volume(diameter_asteroid_km);
    let volume_asteroid_cm3: f64 = km3_to_cm3(volume_asteroid_km3);

    let mass_asteroid_ctype_g: f64 =
        mass_from_volume_density(volume_asteroid_cm3, asteroid_density[0]);
    let mass_asteroid_stype_g: f64 =
        mass_from_volume_density(volume_asteroid_cm3, asteroid_density[1]);
    let mass_asteroid_mtype_g: f64 =
        mass_from_volume_density(volume_asteroid_cm3, asteroid_density[2]);

    let ke_asteroid_ctype_erg: f64 = kinetic_energy(mass_asteroid_ctype_g, velocity_escape_cm_s);
    let ke_asteroid_stype_erg: f64 = kinetic_energy(mass_asteroid_stype_g, velocity_escape_cm_s);
    let ke_asteroid_mtype_erg: f64 = kinetic_energy(mass_asteroid_mtype_g, velocity_escape_cm_s);

    let ke_asteroid_1km_mean_erg: f64 =
        (ke_asteroid_ctype_erg + ke_asteroid_stype_erg + ke_asteroid_mtype_erg) / 3.0_f64;

    let ke_asteroid_ceres_erg: f64 = kinetic_energy(mass_asteroid_ceres_g, velocity_escape_cm_s);
    let ke_difference_factor: f64 = ke_asteroid_ceres_erg / ke_bomb_10megaton_erg;

    println!();
    println!(" ---------------------------------------------------------------");
    println!(" Results:");
    println!(" ---------------------------------------------------------------");
    println!(
        " 10-megaton bomb KE (erg):       {:.2E}",
        ke_bomb_10megaton_erg
    );
    println!();
    println!(
        " 1-km C-type asteroid KE (erg):  {:.2E}",
        ke_asteroid_ctype_erg
    );
    println!(
        " 1-km S-type asteroid KE (erg):  {:.2E}",
        ke_asteroid_stype_erg
    );
    println!(
        " 1-km M-type asteroid KE (erg):  {:.2E}",
        ke_asteroid_mtype_erg
    );
    println!();
    println!(
        " 1-km mean asteroid KEE (erg):   {:.2E}",
        ke_asteroid_1km_mean_erg
    );
    println!();
    println!(
        " Ceres asteroid KE  (erg):       {:.2E}",
        ke_asteroid_ceres_erg
    );
    println!(
        " Difference factor (erg):        {:.1}",
        ke_difference_factor
    );
    println!(
        " Difference factor (x):          {:.2E}",
        ke_difference_factor
    );
    println!(" ---------------------------------------------------------------");
    println!();
}
