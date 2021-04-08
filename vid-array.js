/**
 * This function takes a type parameter, deciding
 * if we are asking for preload or exp data.
 *
 * When requesting preload data, we take a random
 * array of stimulis. This result is stored so that
 * we can return the same array when asking for exp data.
 */
var index_number = 0;

var stimuliExp = {};

stimuliExp.vidArray = function(type) {
    var index_number = index_number + 1;
        dataArray = [
          "videos/αγάπη_m.mp4",
          "videos/γραμμή_m.mp4",
          "videos/ιδέα_m.mp4",
          "videos/λάθος_m.mp4",
          "videos/λέξη_m.mp4"
        ];

    switch (type) {
        case 'preload':
            console.log('number is ' + index_number)
            return dataArray[index_number]
            break;
        case 'exp':
            console.log('number is ' + index_number)
            return [stimuliExp.createExpArray(dataArray[index_number])]
            break;
        default:
            break;
    }
}

stimuliExp.createExpArray = function(myArray) {
    var myObj = {},
        myNewArray = [];
    myArray.forEach(element => {
        myObj = { 'stimulus': element };
        myNewArray.push(myObj)
    });
    console.dir(myNewArray)
    return myNewArray;
}
