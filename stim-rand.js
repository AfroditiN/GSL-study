
var stimuliExpRandomizer = {},
    stimuliExpRandomizerRandomNb = Math.floor(Math.random() * 100);

if (stimuliExpRandomizerRandomNb < 27){
    stimuliExpRandomizerRandomNb = 0;
}
else if (stimuliExpRandomizerRandomNb < 60){
    stimuliExpRandomizerRandomNb = 1;
}
else {
    stimuliExpRandomizerRandomNb = 2;
}


// ###########################
/**
 * This function takes a type parameter, deciding
 * if we are asking for preload or exp data.
 * 
 * When requesting preload data, we take a random
 * array of stimulis. This result is stored so that
 * we can return the same array when asking for exp data.
 */
stimuliExpRandomizer.randomizeStimuli = function(type) {
    var randomNb = stimuliExpRandomizerRandomNb,
        sound_check_stim = [
            "videos/test1.mp4",
            "videos/test1.mp4",
            "videos/test1.mp4",
        ],
        dataArray = [
            [                                        
                "videos/test1.mp4",
                "videos/test1.mp4"               
            ],
            [
                "videos/test1.mp4",
                "videos/test1.mp4" 
            ],
            [
                "videos/test1.mp4",
                "videos/test1.mp4"                    
            ],
        ];

    switch (type) {
        case 'preload':
            console.log('number is ' + randomNb)
            return dataArray[randomNb]
            break;
        case 'exp':
            console.log('number is ' + randomNb)
            return [sound_check_stim[randomNb],stimuliExpRandomizer.createExpArray(dataArray[randomNb])]
            break;
        default:
            break;
    }
}

stimuliExpRandomizer.createExpArray = function(myArray) {
    var myObj = {},
        myNewArray = [];
    myArray.forEach(element => {
        myObj = { 'stimulus': element };
        myNewArray.push(myObj)
    });
    console.dir(myNewArray)
    return myNewArray;
}