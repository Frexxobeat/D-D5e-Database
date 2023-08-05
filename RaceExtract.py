import requests
import json

# Download the file
url = "https://raw.githubusercontent.com/Frexxobeat/D-D5e-Database/main/all_WotC_pub-UA.js"
response = requests.get(url)

# The downloaded file content is a JavaScript file, not a JSON file.
# So, we need to convert it to a valid JSON format.
# Assuming the file content is a JavaScript object, we can convert it to JSON by wrapping it with parentheses.
content = response.text
json_content = json.loads("(" + content + ")")

# Extract the "RaceList" entries
race_list = json_content.get("RaceList", {})

# Write the "RaceList" entries to a new JSON file
with open("Races.json", "w") as f:
    json.dump(race_list, f)