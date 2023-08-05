import json
import numpy as np

# Load the JSON file
with open('CharacterCompanion/CharacterCompanion/spells.json') as f:
    data = json.load(f)

# Convert data to numpy array
data_array = np.array(data)

# Function to print any index of the array
def print_spell(index):
    if index < 0 or index >= len(data_array):
        print("Index out of bounds")
    else:
        print(data_array[index])

# Test the function
print_spell(5)
