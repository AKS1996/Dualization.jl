# Dualization.jl

| **Documentation** | **Build Status** | **Social** |
|:-----------------:|:----------------:|:----------:|
| [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![Build Status][build-img]][build-url] [![Codecov branch][codecov-img]][codecov-url] | [![Gitter][gitter-img]][gitter-url] [<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Discourse_logo.png/799px-Discourse_logo.png" width="64">][discourse-url] |

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-stable-url]: http://www.juliaopt.org/Dualization.jl/stable
[docs-dev-url]: http://www.juliaopt.org/Dualization.jl/dev

[build-img]: https://travis-ci.org/JuliaOpt/MathOptInterface.jl.svg?branch=master
[build-url]: https://travis-ci.org/JuliaOpt/Dualization.jl
[codecov-img]: http://codecov.io/github/JuliaOpt/Dualization.jl/coverage.svg?branch=master
[codecov-url]: http://codecov.io/github/JuliaOpt/Dualization.jl?branch=master

[gitter-url]: https://gitter.im/AutomaticDualization/community#
[gitter-img]: https://badges.gitter.im/JuliaOpt/JuMP-dev.svg
[discourse-url]: https://discourse.julialang.org/c/domain/opt

Repository with implementations of the automatic dualization feature for MathOptInterface.jl conic optimization problems

Dualization.jl has two main features. 
 * The function `dualize` that can dualize either a `MathOptInterface.jl` or `JuMP.jl` model.

```julia
dual_model = dualize(model)
```

 * The `DualOptimizer` that will pass the dual representation of the model to the solver of your choice.

```julia
model = Model(with_optimizer(DualOptimizer, SOLVER.Optimizer(options...)))
```

## Common use cases

### Solve problems via dual representation

This is specially useful for conic optimization because some solvers
can only represent specific formulation types. Dualizing the problem can leave
a problem closer to the form expected by the solver without adding
slack variables and constraints.

Solving an optimization problem via its dual representation can be useful because some conic solvers assume the model is in the standard form and others use the geometric form.

|  Standard form | Geometric form |
|:-------:|:-------:|
| SDPT3 | CDCS |
| SDPNAL | SCS |
| CSDP | ECOS |
| SDPA | SeDuMi |
| Mosek |

For more informations please read the [documentation][docs-stable-url]

### Bilevel optimization

One classic method employed to solve bilevel optimization programs is to add the
KKT conditions of the second level problem to the upper level problem.
This package is used to obtain the dual feasibility constraint of the KKT conditions
in: https://github.com/joaquimg/BilevelJuMP.jl .
