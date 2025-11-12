module ACSU (
    input  [1:0] bmc00_path_0,
    input  [1:0] bmc00_path_1,
    input  [1:0] bmc01_path_0,
    input  [1:0] bmc01_path_1,
    input  [1:0] bmc10_path_0,
    input  [1:0] bmc10_path_1,
    input  [1:0] bmc11_path_0,
    input  [1:0] bmc11_path_1,
    input  [3:0] n_ACS00_path_cost,
    input  [3:0] n_ACS01_path_cost,
    input  [3:0] n_ACS10_path_cost,
    input  [3:0] n_ACS11_path_cost,
    output [3:0] ACS00_path_cost,
    output [3:0] ACS01_path_cost,
    output [3:0] ACS10_path_cost,
    output [3:0] ACS11_path_cost,
    output ACS00_selection,
    output ACS01_selection,
    output ACS10_selection,
    output ACS11_selection
);

    // ACS cho state 00
    acs acs00 (
        .path_cost_0 (n_ACS00_path_cost),
        .path_cost_1 (n_ACS01_path_cost), 
        .bmc_path_0  (bmc00_path_0),
        .bmc_path_1  (bmc00_path_1),
        .n_path_cost (ACS00_path_cost),
        .decision    (ACS00_selection)
    );

    // ACS cho state 01
    acs acs01 (
        .path_cost_0 (n_ACS10_path_cost), 
        .path_cost_1 (n_ACS11_path_cost), 
        .bmc_path_0  (bmc01_path_0),
        .bmc_path_1  (bmc01_path_1),
        .n_path_cost (ACS01_path_cost),
        .decision    (ACS01_selection)
    );

    // ACS cho state 10
    acs acs10 (
        .path_cost_0 (n_ACS00_path_cost),
        .path_cost_1 (n_ACS01_path_cost), 
        .bmc_path_0  (bmc10_path_0),
        .bmc_path_1  (bmc10_path_1),
        .n_path_cost (ACS10_path_cost),
        .decision    (ACS10_selection)
    );

    // ACS cho state 11
    acs acs11 (
        .path_cost_0 (n_ACS10_path_cost),
        .path_cost_1 (n_ACS11_path_cost), 
        .bmc_path_0  (bmc11_path_0),
        .bmc_path_1  (bmc11_path_1),
        .n_path_cost (ACS11_path_cost),
        .decision    (ACS11_selection)
    );

endmodule