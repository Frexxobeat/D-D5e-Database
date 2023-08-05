import json
import re
from json5 import loads

# Load the current JSON file
with open('Spells.json', 'r') as file:
    current_data = json.load(file)

# This will hold the reformatted data
new_data = {}

# Process each spell
for spell_key, spell_data_string in current_data.items():
    # Remove the "AtHigherLevels" string
    spell_data_string = spell_data_string.replace('AtHigherLevels', '')

    # Remove string concatenations
    spell_data_string = re.sub(r'"\s*\+\s*"', '', spell_data_string)

    # Remove all "+" symbols
    spell_data_string = spell_data_string.replace('+', '')

    # Replace escaped quotes with single quotes
    spell_data_string = spell_data_string.replace('\\"', "'")

    # Parse the JavaScript object
    spell_data = loads(spell_data_string)

    # Reformat the spell data
    new_spell_data = {
        'name': spell_data['name'],
        'classes': spell_data['classes'],
        'source': spell_data['source'],
        'level': spell_data['level'],
        'school': spell_data['school'],
        'time': spell_data['time'],
        'range': spell_data['range'],
        'components': spell_data['components'],
        'duration': spell_data['duration'],
        'description': spell_data['description'],
        'descriptionFull': spell_data['descriptionFull']
    }

    # Add the reformatted spell data to the new data
    new_data[spell_key] = new_spell_data

# Save the new data to a new JSON file
with open('Spells_new.json', 'w') as file:
    json.dump(new_data, file, indent=4)
