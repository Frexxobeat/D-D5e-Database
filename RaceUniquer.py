import json

# Load the data
with open('races.json', 'r') as f:
    data = json.load(f)

# Use a dictionary to remove duplicates
unique_races = {race['name']: race for race in data['race']}
unique_subraces = {subrace['name']: subrace for subrace in data['subrace'] if 'name' in subrace}


# Replace the lists with the unique dictionaries converted back to lists
data['race'] = list(unique_races.values())
data['subrace'] = list(unique_subraces.values())

# Save the data to a new file
with open('races_unique.json', 'w') as f:
    json.dump(data, f, indent=4)
