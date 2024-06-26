using Test

include("enchantments.jl")

@testset verbose = true "tests" begin
    @testset "Retrieve a card from a deck" begin
        @test card([1, 3, 4, 1], 2) == 3
        @test_throws BoundsError card([1, 3, 4, 1], 0)
    end

    @testset "Exchange a card in the deck" begin
        @test replace_card!([1, 3, 4, 1], 2 => 6) == [1, 6, 4, 1]
        @test_throws BoundsError replace_card!([1, 3, 4, 1], 5 => 6)
    end

    @testset "Insert a card at the of top the deck" begin
        @test insert_card_at_top!([1, 3, 4, 1], 8) == [1, 3, 4, 1, 8]
    end

    @testset "Remove a card from the deck" begin
        @test remove_card!([1, 3, 4, 1], 2) == [1, 4, 1]
        @test_throws BoundsError remove_card!([], 0)
        @test_throws BoundsError remove_card!([], 1)
        @test_throws BoundsError remove_card!([1, 3, 4, 1], 0)
        @test_throws BoundsError remove_card!([1, 3, 4, 1], 5)
    end

    @testset "Remove the top card from the deck" begin
        @test remove_card_from_top!([1, 3, 4, 1]) == [1, 3, 4]
        @test_throws ArgumentError remove_card_from_top!([])
    end

    @testset "Insert a card at the bottom of the deck" begin
        @test insert_card_at_bottom!([1, 3, 4, 1], 8) == [8, 1, 3, 4, 1]
    end

    @testset "Remove a card from the bottom of the deck" begin
        @test remove_card_from_bottom!([1, 3, 4, 1]) == [3, 4, 1]
        @test_throws ArgumentError remove_card_from_bottom!([])
    end

    @testset "Check size of the deck" begin
        @test  check_deck_size([1, 3, 4, 1], 4)
        @test !check_deck_size([1, 3, 4, 1, 5], 4)
        @test !check_deck_size([1, 3, 4], 4)
        @test  check_deck_size([], 0)
    end
end
