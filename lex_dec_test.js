var timeline = [];

// create instructions node
// insert if-condition so only shows before first trial
// make a randomization index that ensures counter-balancing between F and J
// var instructions = {
//     type: 'instructions',
//     pages: ['<p>You are going to see a video of someone signing ' + 
//         'and after that a written word on the screen.' +
//         '<p>We would like you to judge whether the written word ' + 
//         'is a real greek word or not as fast as you can.\n\n'+
//         '<p>Press "F" on your keyboard if you think it is NOT a real word in greek.' +
//         '<p>Press "J" on your keyboard if you think it IS a real word in greek.\n\n' +
//         '<p>Click the button below to begin.</p>'],
//     allow_keys: false,
//     show_clickable_nav: true
//   }




var welcome = {
  type: 'html-keyboard-response',
  stimulus: ['<p>Καλώς ήρθες στο πείραμα.</p>' + 
            '<p>Πάτησε οποιοδήποτε πλήκτρο για να ξεκινήσεις.</p>'],
};
timeline.push(welcome);




//instructions in Greek
var instructions = {
  type: 'instructions',
  pages: ['<p>Πρόκειται να δεις ένα βίντεο με κάποιον που νοηματίζει μια λέξη ' +
      '<p>και έπειτα, μία γραπτή λέξη θα εμφανιστεί στην οθόνη σου.'+
      '<p>Θα θέλαμε να αποφασίσεις όσο πιο γρήγορα μπορείς, εάν η γραπτή λέξη ' + 
      '<p>είναι πραγματική ελληνική λέξη ή όχι.\n\n\n'+
      '<p>Πάτησε <b>"I"</b> στο πληκτρολόγιό σου εάν νομίζεις ότι <b>ΔΕΝ</b> είναι πραγματική λέξη.' +
      '<p>Πάτησε <b>"J"</b> στο πληκτρολόγιό σου εάν νομίζεις ότι <b>ΕΙΝΑΙ</b> πραγματική λέξη.\n\n\n' +
      '<p>Πάτησε το πλήκτρο για να ξεκινήσεις.</p>'],
  allow_keys: false,
  show_clickable_nav: true
}

// add this node to the timeline
timeline.push(instructions);

var fixation = {
    type: 'html-keyboard-response',
    stimulus: '<div style="font-size:60px;">+</div>',
    choices: jsPsych.NO_KEYS,
    trial_duration: 1000
}
timeline.push(fixation);

var video = {
    type: 'video-keyboard-response',
    sources: [
        'resources/word.mp4', 
        'resources/word.mov'],
        
        margin_vertical: '10px',
        height: '300px', 
        choices: jsPsych.NO_KEYS,
        trial_ends_after_video: true,
}
timeline.push(video);

var fixation = {
    type: 'html-keyboard-response',
    stimulus: '<div style="font-size:60px;">+</div>',
    choices: jsPsych.NO_KEYS,
    trial_duration: 1000
}
timeline.push(fixation);

var word_trial = {
    type: 'html-keyboard-response',
    stimulus: '<p style="font-size: 36px; font-weight: bold;">λέξη</p>',
    // stimulus: String.fromCharCode(214,216,155,234,225),
    choices: ['f', 'j'],
    //prompt: ['<p>F = nonword' '<p>J = word</p>'],
    stimulus_duration: 1500,
    trial_duration: 4000
};
timeline.push(word_trial);

var fixation = {
  type: 'html-keyboard-response',
  stimulus: '<div style="font-size:60px;">+</div>',
  choices: jsPsych.NO_KEYS,
  trial_duration: 1000
}
timeline.push(fixation);

//Second trial-no mouthing

var video = {
  type: 'video-keyboard-response',
  sources: [
      'resources/island2.mp4', 
      'resources/island2.mov'],
      
      margin_vertical: '10px',
      height: '400px', 
      choices: jsPsych.NO_KEYS,
      trial_ends_after_video: true,
}
timeline.push(video);

var fixation = {
  type: 'html-keyboard-response',
  stimulus: '<div style="font-size:60px;">+</div>',
  choices: jsPsych.NO_KEYS,
  trial_duration: 1000
}
timeline.push(fixation);

var word_trial = {
  type: 'html-keyboard-response',
  stimulus: '<p style="font-size: 36px; font-weight: bold;">μάτι</p>',
  // stimulus: String.fromCharCode(214,216,155,234,225),
  choices: ['i', 'j'],
  //prompt: ['<p>i = nonword' '<p>J = word</p>'],
  stimulus_duration: 1500,
  trial_duration: 4000
};
timeline.push(word_trial);

//Third trial-pseudoword

var fixation = {
  type: 'html-keyboard-response',
  stimulus: '<div style="font-size:60px;">+</div>',
  choices: jsPsych.NO_KEYS,
  trial_duration: 1000
}
timeline.push(fixation);

//Second trial-No mouthing

var video = {
  type: 'video-keyboard-response',
  sources: [
      'resources/topic2.mp4', 
      'resources/topic2.mov'],
      
      margin_vertical: '10px',
      height: '300px', 
      choices: jsPsych.NO_KEYS,
      trial_ends_after_video: true,
}
timeline.push(video);

var fixation = {
  type: 'html-keyboard-response',
  stimulus: '<div style="font-size:60px;">+</div>',
  choices: jsPsych.NO_KEYS,
  trial_duration: 1000
}
timeline.push(fixation);

var word_trial = {
  type: 'html-keyboard-response',
  stimulus: '<p style="font-size: 36px; font-weight: bold;">μήθα</p>',
  // stimulus: String.fromCharCode(214,216,155,234,225),
  choices: ['f', 'j'],
  //prompt: ['<p>F = nonword' '<p>J = word</p>'],
  stimulus_duration: 1500,
  trial_duration: 4000
};
timeline.push(word_trial);

// create thank-you node
// insert if-condition so this only shows after last trial
var thanks = {
    type: 'instructions',
    pages: ['<p>Ευχαριστούμε για τη συμμετοχή σου!'],
    allow_keys: false,
    show_clickable_nav: true
  
}
// add this node to the timeline
timeline.push(thanks);

// when all nodes have been added to the timeline, initiate the experiment
// jsPsych.init({
//     timeline: timeline,
//     on_finish: function() {
//         jsPsych.data.displayData('csv');  
//       jsPsych.data.displayData(); 
//     }
// });

/*start experiment*/
jsPsych.init({
  timeline: timeline,
  on_finish: function() {
    // jsPsych.data.displayData('csv');
jsPsych.data.get().localSave('csv','lexical_decision_test.csv');
  }
});
