// Load the fs module
const fs = require('fs');

// Load the JavaScript file
const data = require('./all_WotC_pub+UA.js');

// Extract the RaceList object
const raceList = data.RaceList;

// Write the RaceList object to a JSON file
fs.writeFileSync('Races.json', JSON.stringify(raceList));
