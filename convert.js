const fs = require('fs');
const path = require('path');

// Read the file
let rawdata = fs.readFileSync(path.join(__dirname, 'Spells.json'), 'utf-8');
let spells = JSON.parse(rawdata);

// Iterate over each spell
for (let spell in spells) {
    // Check if the spell data is a string
    if (typeof spells[spell] === 'string') {
        // Parse the spell data string as JavaScript code
        let spell_data_string = spells[spell]
            .replace(/AtHigherLevels \+/g, '"At Higher Levels:" +')
            .replace(/toUni/g, '');

        // Try to evaluate the string as JavaScript code
        try {
            let spell_data = eval('(' + spell_data_string + ')');

            // Replace the spell data string with the parsed JavaScript object
            spells[spell] = spell_data;
        } catch (error) {
            console.error(`Error parsing spell "${spell}": ${error}`);
        }
    } else {
        console.log(`Spell "${spell}" data is already an object, skipping parsing.`);
    }
}

// Write the modified data back to the file
fs.writeFileSync(path.join(__dirname, 'Spells.json'), JSON.stringify(spells, null, 2));
