#[system]
mod end_turn_system {
    use dojo::world::Context;

    use tsubasa::components::Game;
    use tsubasa::events::{emit, EndTurn};
    use array::ArrayTrait;


    fn execute(ctx: Context, game_id: felt252) {
        let game = get!(ctx.world, game_id, Game);

        set!(
            ctx.world, Game {
                game_id: game_id,
                player1: game.player1,
                player2: game.player2,
                player1_score: game.player1_score,
                player2_score: game.player2_score,
                turn: game.turn + 1,
                outcome: game.outcome
            }
        );

        // emit EndTurn
        let mut values = ArrayTrait::new();
        serde::Serde::serialize(@EndTurn { game_id, turn: game.turn + 1 }, ref values);
        emit(ctx, 'EndTurn', values.span());
    }
}
