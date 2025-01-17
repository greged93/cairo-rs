use crate::{
    utils::{biguint_to_felt, felt_to_biguint},
    Felt252,
};
use num_bigint::BigUint;
use num_traits::One;

pub(crate) fn split<const N: usize>(num: &BigUint, num_bits_shift: u32) -> [Felt252; N] {
    let mut num = num.clone();
    let bitmask = &((BigUint::one() << num_bits_shift) - 1_u32);
    [0; N].map(|_| {
        let a = &num & bitmask;
        num >>= num_bits_shift;
        biguint_to_felt(&a).unwrap()
    })
}

pub(crate) fn pack<const N: usize>(
    limbs: [impl AsRef<Felt252>; N],
    num_bits_shift: usize,
) -> BigUint {
    limbs
        .into_iter()
        .enumerate()
        .map(|(i, limb)| felt_to_biguint(*limb.as_ref()) << (i * num_bits_shift))
        .sum()
}
