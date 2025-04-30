% Make a string for the plot titles
function [s_fig_title, s_fig_save] = rich_strings(my_cons_law, disc_pa, pde_pa, outer_solve_pa, inner_solve_pa, linearization_pa, plot_pa)

    % Abbreviate the WENO linearization strategy
    reconstruct_string = '';
    if strcmp(disc_pa.reconstruction_id, 'WENO')
        if strcmp(linearization_pa.weno_linearization, 'picard')
            reconstruct_string = sprintf('%s(%d,%s)', ...
                my_cons_law.reconstruction.id, disc_pa.spatial_order, 'P');
            
        elseif startsWith(linearization_pa.weno_linearization, 'newton')
            reconstruct_string = sprintf('%s(%d,%s)', ...
                my_cons_law.reconstruction.id, disc_pa.spatial_order, 'N');
        end
    elseif strcmp(disc_pa.reconstruction_id, 'linear')
        reconstruct_string = sprintf('%s(%d)', 'lin', disc_pa.spatial_order);
    end
    
    relax_string = '';
    if plot_pa.relax
        if ~strcmp(outer_solve_pa.relax_scheme, '')
            relax_string = sprintf(', %s(%d)', outer_solve_pa.relax_scheme, outer_solve_pa.cf);
        end
    end
    
    % Assemble the relevant pieces.
    PDE_label = my_cons_law.id_abbreviation();
    s_fig_title = sprintf('%s, %s, %s%s', ...
        PDE_label, ...
        disc_pa.num_flux_id, ...
        reconstruct_string, ...
        relax_string);
    
    % Assemble the relevant pieces.
    s_fig_save = sprintf('%s(%d)-%s-%s', ...
        PDE_label, ...
        pde_pa.ic_id, ...,
        disc_pa.num_flux_id, ...
        reconstruct_string);
    if ~strcmp(outer_solve_pa.relax_scheme, '')
        s_fig_save = strcat(s_fig_save, sprintf('-%s(%d)', outer_solve_pa.relax_scheme, outer_solve_pa.cf));
    end
    
    % MGRIT solve of linearized problem
    if strcmp(inner_solve_pa.linear_solve, 'MGRIT')
        s_fig_save = sprintf('%s-MGRIT-%s(%d)-%s-%d', s_fig_save, ...
                                                inner_solve_pa.MGRIT_solver_params.pre_relax, ...
                                                inner_solve_pa.MGRIT_solver_params.cf, ...
                                                inner_solve_pa.MGRIT_object.BE_coarse_solve.id, ...
                                                inner_solve_pa.MGRIT_solver_params.maxlevels);
    % DIRECT solve of linearized problem
    else
        s_fig_save = sprintf('%s-DIRECT', s_fig_save);
    end
    
end