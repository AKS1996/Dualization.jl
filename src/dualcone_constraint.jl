"""
Add dual model with variables and dual cone constraints. 
Creates dual variables => primal constraints dict
"""
function add_dual_model_variables(dual_model::MOI.ModelLike, model::MOI.ModelLike, constr_types::Vector{Tuple{DataType, DataType}})
    # Adds the dual variables to the dual model, assumining the number of constraints of the model
    # is model.nextconstraintid
    MOI.add_variables(dual_model, model.nextconstraintid) 
    dict_dualvar_primalcon = Dict{VI, CI}()
    i = 1
    for (F, S) in constr_types
        num_cons_f_s = MOI.get(model, MOI.NumberOfConstraints{F, S}()) # Number of constraints {F, S}
        for con_id = 1:num_cons_f_s
            vi = VI(i)
            ci = get_ci(model, F, S, con_id)
            push!(dict_dualvar_primalcon, vi => ci) # Add dual variable to the dict
            add_dualcone_constraint(dual_model, vi, F, S) # Add dual variable in dual cone constraint y \in C^*
            i += 1
        end
    end
    return dict_dualvar_primalcon
end

function add_dualcone_constraint(dualmodel::MOI.ModelLike, vi::VI,
                                  ::Type{SAF{T}}, ::Type{MOI.GreaterThan{T}}) where T
    return MOI.add_constraint(dualmodel, SVF(vi), MOI.GreaterThan(0.0))
end

function add_dualcone_constraint(dualmodel::MOI.ModelLike, vi::VI,
                                  ::Type{SAF{T}}, ::Type{MOI.LessThan{T}}) where T
    return MOI.add_constraint(dualmodel, SVF(vi), MOI.LessThan(0.0))
end

function add_dualcone_constraint(dualmodel::MOI.ModelLike, vi::VI,
                                  ::Type{SAF{T}}, ::Type{MOI.EqualTo{T}}) where T
    return # No constraint
end
