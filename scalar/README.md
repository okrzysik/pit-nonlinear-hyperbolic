In this directory we consider the solution of the scalar conservation law u_t + f(u)_x = 0, with possibly nonlinear flux function f. This code is used for generating the numerical results in the paper `Parallel-in-time solution of scalar nonlinear conservation laws`

* `cons_law_scalar.m`: Abstract class implementing PDE and its discretization. Specific PDEs implemented using this class are: 
    1. The linear conservation law:   f(u) = alpha(x, t)*u for some prescribed function alpha. See `cons_lin_scalar.m`
    2. The Burgers equation:          f(u) = u^2/2. See `burgers.m`
    3. The Buckley--Levertt equation: f(u) = 4u^2 ./ (4u^2 + (1-u)^2). See `buckley_leverett.m`

* `cons_law_time_stepping.m`: Solves the PDE on some time interval using time-stepping

* `cons_law_st.m`: Solve the PDE on some time interval using a preconditioned residual correction scheme applied to the whole space-time system. The linearized problems at each iteration may be solved directly via sequential time-stepping or approximately with MGRIT. When MGRIT is used as the linear solver, the associated MGRIT stepping methodology is implemented in `step_cons_law_linearized_MGRIT.m`

* `cons_law_accuracy_test.m`: Measures discretization error for a linear and Burgers equations.

* `cons_lin_st_MGRIT.m`: Uses MGRIT to solve the linear conservation law e_t + (alpha(x, t)*e)_x = 0, where alpha(x, t) is some prescribed function, and the PDE is discretized with a standard linear MOL discretization. The coarse-grid operator is a modified, conservative semi-Lagrangian method. All the stepping functionality for MGRIT is implemented in `step_cons_lin_MGRIT.m`


* Specific figures in the main paper can be generated as follows:
    2. Running `cons_law_time_stepping.m`. 
        Setting `pde_id = 'burgers';, u0_id = 3; tmax = 4;` will generate the Burgers examples (LHS column). 
        Setting `pde_id = 'buckley-leverett'; u0_id = 3; tmax = 2;` will generate the Buckley--Leverett examples (RHS column).
        
    3. Running `cons_law_st.m` with `spatial_order = 1; reconstruction_id = 'linear';`
        Setting `pde_id = 'burgers';, u0_id = 3; tmax = 4;` will generate the Burgers examples (LHS column). 
            Setting `num_flux_id = 'GLF';` will generate the top left plot
            Setting `num_flux_id = 'LLF';` will generate the bottom left plot

        Setting `pde_id = 'buckley-leverett'; u0_id = 3; tmax = 2;` will generate the Buckley--Leverett examples (RHS column).
            Setting `num_flux_id = 'GLF';` will generate the top left plot
            Setting `num_flux_id = 'LLF';` will generate the bottom left plot

        Exact linear solves are used by choosing `inner_solve_pa.linear_solve = 'direct';`
        Approximate linear solves with MGRIT are used by choosing `inner_solve_pa.linear_solve = 'MGRIT';`

    4. Running `cons_law_st.m` with `spatial_order = 3; reconstruction_id = 'WENO';`

        All plots have `num_flux_id = 'LLF';` 

        Setting `pde_id = 'burgers';, u0_id = 3; tmax = 4;` will generate the Burgers examples (LHS column).
        Setting `pde_id = 'buckley-leverett'; u0_id = 3; tmax = 2;` will generate the Buckley--Leverett examples (RHS column). 

        Setting `weno_linearization = 'picard';` will generate the plots in the top row
        Setting `weno_linearization = 'newton-FD-approx';` will generate the plots in the bottom row

* Specific figures in the supplement can be generated as follows:
    1. Running `cons_law_st.m` with `spatial_order = 1; reconstruction_id = 'linear';`
        Setting `pde_id = 'burgers';, u0_id = 3; tmax = 4;` will generate the Burgers examples (LHS column). 
            Setting `num_flux_id = 'GLF';` will generate the top left plot
            Setting `num_flux_id = 'LLF';` will generate the bottom left plot

        Setting `pde_id = 'buckley-leverett'; u0_id = 3; tmax = 2;` will generate the Buckley--Leverett examples (RHS column).
            Setting `num_flux_id = 'GLF';` will generate the top left plot
            Setting `num_flux_id = 'LLF';` will generate the bottom left plot

        Ensure that exact linear solves are carried out with `inner_solve_pa.linear_solve = 'direct';`
        No nonlinear relaxation corresponds to `outer_solve_pa.relax_scheme = '';`

        Nonlinear F-relaxation corresponds to `outer_solve_pa.relax_scheme = 'F'; outer_solve_pa.cf = 8;`

    2. Essentially the same as in the previous figure, except with `spatial_order = 3; reconstruction_id = 'WENO';` and `num_flux_id = 'GLF';`

        Setting `weno_linearization = 'picard';` will generate the plots in the top row
        Setting `weno_linearization = 'newton-FD-approx';` will generate the plots in the bottom row

    3. Same as the previous figure except with `num_flux_id = 'LLF';`

    4. Can be generated analogously to Figures 3. and 4. in the main paper, except that the initial condition is swapped from the square wave to the sine function combination via `u0_id = 6; tmax = 4;` for Burgers. 

    5. Exactly the same as with Figure 4., except with  `u0_id = 6; tmax = 2;` for Buckley--Leverett.

    6. Multilevel MGRIT solves are deployed by ensuring:
        `inner_solve_pa.linear_solve = 'MGRIT';`
        `MGRIT_maxlevels = 10;` (ensures more than 2-levels are used)
        `MGRIT_relax = 'F-FCF';` (uses F-relax on first level, and FCF on all coarse levels)

    7. `cons_law_time_stepping.m` with `pde_id = 'linear'; u0_id = 1; tmax = 4;` and set `wave_speed_id`, noting the options in `cons_lin_scalar.m`

    8. `cons_lin_st_MGRIT.m`

    9. `cons_lin_st_MGRIT.m`
        
