defmodule DobbleGenerator.ImageProcessing.Algorithm do
  @moduledoc """
  We will base our algorithm based on the following key findings:
  If a game of Dobble needs (n+1) symbols on each card, n being a primary number then we will need:

  A collection of n2 + n + 1 symbols
  We will be able to generate n2 + n + 1 unique cards

  "n" is a number of symbols.

  Requirements:
   1: every card has exactly one symbol in common with every other card.
   2: each card has the same number of symbols.
   3: no symbol appears more than once on a given card.
   4: each card must be unique.
   5: given n symbols, each symbol must appear on at least one card.
   6: there should not be one symbol common to all cards if n>2.

   With s symbols per card we can create s+1 cards using s(s+1)/2 symbols in total.
  """

  @valid_number_of_symbols [13, 57]

  @spec execute(list()) :: list()
  def execute(symbols) when length(symbols) in @valid_number_of_symbols do
    # The number of symbols on a card has to be a prime number + 1
    number_of_symbols_on_card =
      case length(symbols) do
        13 -> 4
        57 -> 8
      end

    cards = []

    # Work out the prime number
    n = number_of_symbols_on_card - 1

    # Total number of cards that can be generated following the Dobble rules
    # e.g. 7^2 + 7 + 1 = 57
    _number_of_cards = n * n + n + 1

    # Add first set of n+1 cards (e.g. 8 cards)
    cards =
      for i <- 0..n, reduce: cards do
        cards ->
          # Add new card with first symbol
          cards = cards ++ [[1]]

          # Add n+1 symbols on the card (e.g. 8 symbols)
          n1 = n - 1

          for j <- 0..n1, reduce: cards do
            cards -> List.update_at(cards, i, &(&1 ++ [j + 1 + i * n + 1]))
          end
      end

    # Add n sets of n cards
    n1 = n + 1

    cards =
      for k <- 2..n1, reduce: cards do
        cards ->
          n1 = n - 1

          for i <- 0..n1, reduce: cards do
            cards ->
              # Append a new card with 1 symbol
              cards = cards ++ [[k]]
              # Add n symbols on the card (e.g. 7 symbols)
              for j <- 0..n1, reduce: cards do
                cards ->
                  val = n + 2 + i + (k + 1) * j
                  val = while_value(val, n, j)

                  index = length(cards) - 1
                  List.update_at(cards, index, &(&1 ++ [val]))
              end
          end
      end

    {:ok, assign_symbols_to_cards(cards, symbols)}
  end

  def execute(_symbols), do: {:error, :invalid_number_of_symbols}

  defp while_value(val, n, j) do
    if val >= n + 2 + (j + 1) * n do
      while_value(val - n, n, j)
    else
      val
    end
  end

  defp assign_symbols_to_cards(cards, symbols) do
    for card_numbers <- cards do
      for number <- card_numbers do
        Enum.at(symbols, number - 1)
      end
    end
  end
end
