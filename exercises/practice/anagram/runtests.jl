using Test

include("anagram.jl")

@testset verbose = true "tests" begin
    @testset verbose = true "Anagram" begin
        @testset "no matches" begin
            @test detect_anagrams("diaper", ["hello", "world", "zombies", "pants"]) == String[]
        end

        @testset "detects simple anagram" begin
            @test detect_anagrams("ant", ["tan", "stand", "at"]) == ["tan"]
        end

        @testset "does not detect false positives" begin
            @test detect_anagrams("galea", ["eagle"]) == String[]
        end

        @testset "detects two anagrams" begin
            @test detect_anagrams("solemn", ["lemons", "cherry", "melons"]) == ["lemons", "melons"]
        end

        @testset "does not detect anagram subsets" begin
            @test detect_anagrams("good", ["dog", "goody"]) == String[]
        end

        @testset "detects anagram" begin
            @test detect_anagrams("listen", ["enlists", "google", "inlets", "banana"]) == ["inlets"]
        end

        @testset "detects three anagrams" begin
            @test detect_anagrams("allergy", ["gallery", "ballerina", "regally", "clergy", "largely", "leading"]) == ["gallery", "regally", "largely"]
        end

        @testset "detects multiple anagrams with different case" begin
            @test detect_anagrams("nose", ["Eons", "ONES"]) == ["Eons", "ONES"]
        end

        @testset "does not detect identical words" begin
            @test detect_anagrams("corn", ["corn", "dark", "Corn", "rank", "CORN", "cron", "park"]) == ["cron"]
        end

        @testset "does not detect non-anagrams with identical checksum" begin
            @test detect_anagrams("mass", ["last"]) == String[]
        end

        @testset "detects anagrams case-insensitively" begin
            @test detect_anagrams("Orchestra", ["cashregister", "Carthorse", "radishes"]) == ["Carthorse"]
        end

        @testset "detects anagrams using case-insensitive subject" begin
            @test detect_anagrams("Orchestra", ["cashregister", "carthorse", "radishes"]) == ["carthorse"]
        end

        @testset "detects anagrams using case-insensitive possible matches" begin
            @test detect_anagrams("orchestra", ["cashregister", "Carthorse", "radishes"]) == ["Carthorse"]
        end

        @testset "does not detect an anagram if the original word is repeated" begin
            @test detect_anagrams("go", ["go Go GO"]) == String[]
        end

        @testset "does not detect a word as its own anagram" begin
            @test detect_anagrams("banana", ["Banana"]) == String[]
        end

        @testset "does not detect a anagram if the original word is repeated" begin
            @test detect_anagrams("go", ["goGoGO"]) == String[]
        end

        @testset "anagrams must use all letters exactly once" begin
            @test detect_anagrams("tapper", ["patter"]) == String[]
        end

        @testset "words are not anagrams of themselves" begin
            @test detect_anagrams("BANANA", ["BANANA"]) == String[]
        end

        @testset "words are not anagrams of themselves even if letter case is partially different" begin
            @test detect_anagrams("BANANA", ["Banana"]) == String[]
        end

        @testset "words are not anagrams of themselves even if letter case is completely different" begin
            @test detect_anagrams("BANANA", ["banana"]) == String[]
        end

        @testset "words other than themselves can be anagrams" begin
            @test detect_anagrams("LISTEN", ["Silent", "LISTEN"]) == ["Silent"]
        end

        @testset "capital word is not own anagram" begin
            @test detect_anagrams("BANANA", ["Banana"]) == String[]
        end

        @testset "handles case of greek letters" begin
            @test detect_anagrams("ΑΒΓ", ["ΒΓΑ", "ΒΓΔ", "γβα", "αβγ"]) == ["ΒΓΑ", "γβα"]
        end
    end
end
