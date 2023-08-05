import json
import os

# Specify the absolute paths to the files
spells_phb_path = '/Users/frederikrex/Library/Mobile Documents/com~apple~CloudDocs/D&D/APP/CharacterCompanion/CharacterCompanion/spells-phb.json'
spells_path = '/Users/frederikrex/Library/Mobile Documents/com~apple~CloudDocs/D&D/APP/CharacterCompanion/CharacterCompanion/spells-phb.json'
output_path = '/Users/frederikrex/Library/Mobile Documents/com~apple~CloudDocs/D&D/APP/ConvertedSpellsJuly06.json'

# Load the data from the first file
with open(spells_phb_path, 'r') as file:
    spells_phb = json.load(file)

# Extract the list of spells from the dictionary
spells_list = spells_phb.get("spell", [])

# Convert the data from the first file to the format of the second file
converted_spells = []
for spell in spells_list:
    if isinstance(spell, dict):
        converted_spell = {
            "name": spell.get("name", ""),
            "desc": spell.get("desc", ""),
            "higher_level": spell.get("higher_level", ""),
            "range": spell.get("range", ""),
            "components": spell.get("components", ""),
            "material": spell.get("material", ""),
            "ritual": spell.get("ritual", ""),
            "duration": spell.get("duration", ""),
            "concentration": spell.get("concentration", ""),
            "casting_time": spell.get("casting_time", ""),
            "level": spell.get("level", ""),
            "school": spell.get("school", ""),
            "classes": spell.get("dnd_class", "").split(", "),
            "subclasses": spell.get("archetype", "").split(", ")
        }
        converted_spells.append(converted_spell)
    else:
        print(f"Unexpected data format: {spell}")

# Save the converted data to a new JSON file
with open(output_path, 'w') as file:
    json.dump(converted_spells, file, indent=4)

print(f"Data has been converted and saved to '{output_path}'")
