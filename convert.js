const fs = require('fs');

// Load the current JSON file
const currentData = require('./Spells.json');

// This will hold the reformatted data
let newData = {};

// Process each spell
for (let spellKey in currentData) {
    // Parse the JavaScript object
    let spellData = eval('(' + currentData[spellKey] + ')');

    // Reformat the spell data
    let newSpellData = {
        name: spellData.name,
        classes: spellData.classes,
        source: spellData.source,
        level: spellData.level,
        school: spellData.school,
        time: spellData.time,
        range: spellData.range,
        components: spellData.components,
        duration: spellData.duration,
        description: spellData.description,
        descriptionFull: spellData.descriptionFull
    };

    // Add the reformatted spell data to the new data
    newData[spellKey] = newSpellData;
}

// Save the new data to a new JSON file
fs.writeFileSync('Spells_new.json', JSON.stringify(newData, null, 4));
