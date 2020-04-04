defmodule DobbleGenerator.ImageProcessing.AlgorithmTest do
  use DobbleGenerator.DataCase

  alias DobbleGenerator.ImageProcessing.Algorithm

  describe "execute/1" do
    test "returns correct result for 13 element" do
      elements = [
        "A",
        "B",
        "C",
        "D",
        "E",
        "F",
        "G",
        "H",
        "I",
        "J",
        "K",
        "L",
        "M"
      ]

      expected_result = [
        ["A", "B", "C", "D"],
        ["A", "E", "F", "G"],
        ["A", "H", "I", "J"],
        ["A", "K", "L", "M"],
        ["B", "E", "H", "K"],
        ["B", "F", "I", "L"],
        ["B", "G", "J", "M"],
        ["C", "E", "I", "M"],
        ["C", "F", "J", "K"],
        ["C", "G", "H", "L"],
        ["D", "E", "J", "L"],
        ["D", "F", "H", "M"],
        ["D", "G", "I", "K"]
      ]

      assert expected_result == Algorithm.execute(elements)
    end

    test "returns correct result for 57 element" do
      elements = [
        "Anchor",
        "Apple",
        "Bomb",
        "Cactus",
        "Candle",
        "Carrot",
        "Cheese",
        "Chess knight",
        "Clock",
        "Clown",
        "Diasy flower",
        "Dinosaur",
        "Dolphin",
        "Dragon",
        "Exclamation mark",
        "Eye",
        "Fire",
        "Four leaf clover",
        "Ghost",
        "Green splats",
        "Hammer",
        "Heart",
        "Ice cube",
        "Igloo",
        "Key",
        "Ladybird",
        "Light bulb",
        "Lightning bolt",
        "Lock",
        "Maple leaf",
        "Milk bottle",
        "Moon",
        "No Entry sign",
        "Orange scarecrow man",
        "Pencil",
        "Purple bird",
        "Purple cat",
        "Purple dobble sign",
        "Question Mark",
        "Red lips",
        "Scissors",
        "Skull and crossbones",
        "Snowflake",
        "Snowman",
        "Spider",
        "Spider’s web",
        "Sun",
        "Sunglasses",
        "Target",
        "Taxi",
        "Tortoise",
        "Treble clef",
        "Tree",
        "Water drop",
        "Dog",
        "Yin and Yang",
        "Zebra"
      ]

      expected_result = [
        ["Anchor", "Apple", "Bomb", "Cactus", "Candle", "Carrot", "Cheese", "Chess knight"],
        [
          "Anchor",
          "Clock",
          "Clown",
          "Diasy flower",
          "Dinosaur",
          "Dolphin",
          "Dragon",
          "Exclamation mark"
        ],
        ["Anchor", "Eye", "Fire", "Four leaf clover", "Ghost", "Green splats", "Hammer", "Heart"],
        [
          "Anchor",
          "Ice cube",
          "Igloo",
          "Key",
          "Ladybird",
          "Light bulb",
          "Lightning bolt",
          "Lock"
        ],
        [
          "Anchor",
          "Maple leaf",
          "Milk bottle",
          "Moon",
          "No Entry sign",
          "Orange scarecrow man",
          "Pencil",
          "Purple bird"
        ],
        [
          "Anchor",
          "Purple cat",
          "Purple dobble sign",
          "Question Mark",
          "Red lips",
          "Scissors",
          "Skull and crossbones",
          "Snowflake"
        ],
        ["Anchor", "Snowman", "Spider", "Spider’s web", "Sun", "Sunglasses", "Target", "Taxi"],
        [
          "Anchor",
          "Tortoise",
          "Treble clef",
          "Tree",
          "Water drop",
          "Dog",
          "Yin and Yang",
          "Zebra"
        ],
        [
          "Apple",
          "Clock",
          "Dinosaur",
          "Exclamation mark",
          "Four leaf clover",
          "Hammer",
          "Igloo",
          "Light bulb"
        ],
        ["Apple", "Clown", "Dolphin", "Eye", "Ghost", "Heart", "Key", "Lightning bolt"],
        [
          "Apple",
          "Diasy flower",
          "Dragon",
          "Fire",
          "Green splats",
          "Ice cube",
          "Ladybird",
          "Lock"
        ],
        [
          "Apple",
          "Dinosaur",
          "Exclamation mark",
          "Four leaf clover",
          "Hammer",
          "Igloo",
          "Light bulb",
          "Maple leaf"
        ],
        ["Apple", "Dolphin", "Eye", "Ghost", "Heart", "Key", "Lightning bolt", "Milk bottle"],
        ["Apple", "Dragon", "Fire", "Green splats", "Ice cube", "Ladybird", "Lock", "Moon"],
        [
          "Apple",
          "Exclamation mark",
          "Four leaf clover",
          "Hammer",
          "Igloo",
          "Light bulb",
          "Maple leaf",
          "No Entry sign"
        ],
        ["Bomb", "Clock", "Dolphin", "Fire", "Hammer", "Key", "Lock", "No Entry sign"],
        [
          "Bomb",
          "Clown",
          "Dragon",
          "Four leaf clover",
          "Heart",
          "Ladybird",
          "Maple leaf",
          "Orange scarecrow man"
        ],
        [
          "Bomb",
          "Diasy flower",
          "Exclamation mark",
          "Ghost",
          "Ice cube",
          "Light bulb",
          "Milk bottle",
          "Pencil"
        ],
        [
          "Bomb",
          "Dinosaur",
          "Eye",
          "Green splats",
          "Igloo",
          "Lightning bolt",
          "Moon",
          "Purple bird"
        ],
        ["Bomb", "Dolphin", "Fire", "Hammer", "Key", "Lock", "No Entry sign", "Purple cat"],
        [
          "Bomb",
          "Dragon",
          "Four leaf clover",
          "Heart",
          "Ladybird",
          "Maple leaf",
          "Orange scarecrow man",
          "Purple dobble sign"
        ],
        [
          "Bomb",
          "Exclamation mark",
          "Ghost",
          "Ice cube",
          "Light bulb",
          "Milk bottle",
          "Pencil",
          "Question Mark"
        ],
        [
          "Cactus",
          "Clock",
          "Dragon",
          "Ghost",
          "Igloo",
          "Lock",
          "Orange scarecrow man",
          "Question Mark"
        ],
        [
          "Cactus",
          "Clown",
          "Exclamation mark",
          "Green splats",
          "Key",
          "Maple leaf",
          "Pencil",
          "Red lips"
        ],
        [
          "Cactus",
          "Diasy flower",
          "Eye",
          "Hammer",
          "Ladybird",
          "Milk bottle",
          "Purple bird",
          "Scissors"
        ],
        [
          "Cactus",
          "Dinosaur",
          "Fire",
          "Heart",
          "Light bulb",
          "Moon",
          "Purple cat",
          "Skull and crossbones"
        ],
        [
          "Cactus",
          "Dolphin",
          "Four leaf clover",
          "Ice cube",
          "Lightning bolt",
          "No Entry sign",
          "Purple dobble sign",
          "Snowflake"
        ],
        [
          "Cactus",
          "Dragon",
          "Ghost",
          "Igloo",
          "Lock",
          "Orange scarecrow man",
          "Question Mark",
          "Snowman"
        ],
        [
          "Cactus",
          "Exclamation mark",
          "Green splats",
          "Key",
          "Maple leaf",
          "Pencil",
          "Red lips",
          "Spider"
        ],
        [
          "Candle",
          "Clock",
          "Exclamation mark",
          "Hammer",
          "Light bulb",
          "No Entry sign",
          "Question Mark",
          "Spider"
        ],
        [
          "Candle",
          "Clown",
          "Eye",
          "Heart",
          "Lightning bolt",
          "Orange scarecrow man",
          "Red lips",
          "Spider’s web"
        ],
        ["Candle", "Diasy flower", "Fire", "Ice cube", "Lock", "Pencil", "Scissors", "Sun"],
        [
          "Candle",
          "Dinosaur",
          "Four leaf clover",
          "Igloo",
          "Maple leaf",
          "Purple bird",
          "Skull and crossbones",
          "Sunglasses"
        ],
        ["Candle", "Dolphin", "Ghost", "Key", "Milk bottle", "Purple cat", "Snowflake", "Target"],
        [
          "Candle",
          "Dragon",
          "Green splats",
          "Ladybird",
          "Moon",
          "Purple dobble sign",
          "Snowman",
          "Taxi"
        ],
        [
          "Candle",
          "Exclamation mark",
          "Hammer",
          "Light bulb",
          "No Entry sign",
          "Question Mark",
          "Spider",
          "Tortoise"
        ],
        ["Carrot", "Clock", "Eye", "Ice cube", "Maple leaf", "Purple cat", "Snowman", "Tortoise"],
        [
          "Carrot",
          "Clown",
          "Fire",
          "Igloo",
          "Milk bottle",
          "Purple dobble sign",
          "Spider",
          "Treble clef"
        ],
        [
          "Carrot",
          "Diasy flower",
          "Four leaf clover",
          "Key",
          "Moon",
          "Question Mark",
          "Spider’s web",
          "Tree"
        ],
        [
          "Carrot",
          "Dinosaur",
          "Ghost",
          "Ladybird",
          "No Entry sign",
          "Red lips",
          "Sun",
          "Water drop"
        ],
        [
          "Carrot",
          "Dolphin",
          "Green splats",
          "Light bulb",
          "Orange scarecrow man",
          "Scissors",
          "Sunglasses",
          "Dog"
        ],
        [
          "Carrot",
          "Dragon",
          "Hammer",
          "Lightning bolt",
          "Pencil",
          "Skull and crossbones",
          "Target",
          "Yin and Yang"
        ],
        [
          "Carrot",
          "Exclamation mark",
          "Heart",
          "Lock",
          "Purple bird",
          "Snowflake",
          "Taxi",
          "Zebra"
        ],
        ["Cheese", "Clock", "Fire", "Key", "No Entry sign", "Scissors", "Target", "Zebra"],
        [
          "Cheese",
          "Clown",
          "Four leaf clover",
          "Ladybird",
          "Orange scarecrow man",
          "Skull and crossbones",
          "Taxi",
          "Tortoise"
        ],
        [
          "Cheese",
          "Diasy flower",
          "Ghost",
          "Light bulb",
          "Pencil",
          "Snowflake",
          "Snowman",
          "Treble clef"
        ],
        [
          "Cheese",
          "Dinosaur",
          "Green splats",
          "Lightning bolt",
          "Purple bird",
          "Purple cat",
          "Spider",
          "Tree"
        ],
        [
          "Cheese",
          "Dolphin",
          "Hammer",
          "Lock",
          "Maple leaf",
          "Purple dobble sign",
          "Spider’s web",
          "Water drop"
        ],
        ["Cheese", "Dragon", "Heart", "Ice cube", "Milk bottle", "Question Mark", "Sun", "Dog"],
        [
          "Cheese",
          "Exclamation mark",
          "Eye",
          "Igloo",
          "Moon",
          "Red lips",
          "Sunglasses",
          "Yin and Yang"
        ],
        [
          "Chess knight",
          "Clock",
          "Four leaf clover",
          "Light bulb",
          "Purple bird",
          "Purple dobble sign",
          "Sun",
          "Yin and Yang"
        ],
        [
          "Chess knight",
          "Clown",
          "Ghost",
          "Lightning bolt",
          "Maple leaf",
          "Question Mark",
          "Sunglasses",
          "Zebra"
        ],
        [
          "Chess knight",
          "Diasy flower",
          "Green splats",
          "Lock",
          "Milk bottle",
          "Red lips",
          "Target",
          "Tortoise"
        ],
        [
          "Chess knight",
          "Dinosaur",
          "Hammer",
          "Ice cube",
          "Moon",
          "Scissors",
          "Taxi",
          "Treble clef"
        ],
        [
          "Chess knight",
          "Dolphin",
          "Heart",
          "Igloo",
          "No Entry sign",
          "Skull and crossbones",
          "Snowman",
          "Tree"
        ],
        [
          "Chess knight",
          "Dragon",
          "Eye",
          "Key",
          "Orange scarecrow man",
          "Snowflake",
          "Spider",
          "Water drop"
        ],
        [
          "Chess knight",
          "Exclamation mark",
          "Fire",
          "Ladybird",
          "Pencil",
          "Purple cat",
          "Spider’s web",
          "Dog"
        ]
      ]

      assert expected_result == Algorithm.execute(elements)
    end
  end
end
