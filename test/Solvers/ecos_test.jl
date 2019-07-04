using ECOS
const ECOSOPT = with_optimizer(ECOS.Optimizer, verbose = 0)

@testset "ECOS conic Problems" begin
    @testset "ECOS SOC problems" begin
        list_of_soc_problems = [     
            soc1_test,
            soc2_test,
            soc3_test,
            soc4_test,
            soc5_test,
            soc6_test
        ]
        test_strong_duality(list_of_soc_problems, ECOSOPT)
    end
end