var timeline = [];

// create instructions node
var instructions = {
    type: 'instructions',
    pages: ['<p>You are going to see a video of someone signing. ' +
      'We would like you to classify the emotional valence of the sign.'+
      '<p>Click the button below to begin.</p>'],
    allow_keys: false,
    show_clickable_nav: true
  }
// add this node to the timeline
timeline.push(instructions);

var trial = {
    type: 'video-button-response',
    prompt: '<p> What is the valence of this sign? </p>',
    sources: [
        'resources/amare.mp4', 
        'resources/amare.mov'],
        
        margin_vertical: '10px',
        height: '300px',    
        choices: ['','',''],
        button_html: ['<button class="jspsych-btn"><img src="resources/sad.jpg" width="50px" height="50px"></button>', 
        '<button class="jspsych-btn"><img src="resources/neutral.png" width="50px" height="50px"></button>', 
        '<button class="jspsych-btn"><img src="resources/happy.jpeg" width="50px" height="50px"></button>']
}
timeline.push(trial);

// create thank-you node
var thanks = {
    type: 'instructions',
    pages: ['<p>Thank you for participating!'],
    allow_keys: false,
    show_clickable_nav: true
  }
// add this node to the timeline
timeline.push(thanks);

// when all nodes have been added to the timeline, initiate the experiment
jsPsych.init({
    timeline: timeline,
    on_finish: function() {
      jsPsych.data.displayData('csv');  
    }
});

