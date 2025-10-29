#![allow(missing_docs)]

#[test]
fn motion_rule_family_id_uses_domain_separation() {
    let mut hasher = blake3::Hasher::new();
    hasher.update(b"rule:motion/update");
    let expected: [u8; 32] = hasher.finalize().into();
    // Access const exposed via the motion demo module.
    assert_eq!(expected, rmg_core::demo::motion::MOTION_UPDATE_FAMILY_ID);
}
