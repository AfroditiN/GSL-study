// // Med den første kode herunder (efter Harrison-bogen (https://pmcharrison.github.io/psychTestR/articles/e-jspsych-integration.html))
// fungerer js/R integrationen, omend det vist ikke fungerede for et år siden (altså at lave det som funktion).
// Jeg tror måske det var pga. vores nestede timelines, at jeg ikke fik det til at køre ordentligt i poly. Der var jeg nødt til at
// definere en timeline udenfor funktionen, som jeg så kunne fylde forskellige trial_procs in i. Det er det jeg har gjort
// Vælger man at køre det som funktion (den første), skal man lige sætte "timeline: new_timeline()," istedet for "timeline:timeline" i run-jspsych,
// som den hedder, når man kører den udenom funktionen og med nestede timelines.

// VERSION 1
// function new_timeline(){

//     var video_trial = {
//     type: 'video-button-response',
//     sources: ['videos/test1.mp4','videos/test2.mp4', 'videos/test3.mp4'],
//     choices: ['Som det skal','Jada!','Hmmm....','Helt sikkert'],
//     prompt: '<p>Finder den videoen, eller hvad?</p>'
// };

// return [video_trial]

// }



// OBS: i jspsych 6.2 hed "stimulus" "sources" (og er brugt i VERSION 1).
// I VERSION 2 herunder kører vi 6.3.1

// VERSION 2
var timeline = [];

// var preload = {
//     type: 'preload',
//     auto_preload: true,
//     video: ['videos/αγάπη_m.mp4', 'videos/γραμμή_m.mp4', 'videos/ιδέα_m.mp4'],
//     on_success: function(file) {
//         console.log('File loaded: ',file);
//     },
//   };
// timeline.push(preload);

// var test_stimuli = [
//     { stimulus: 'videos/test1.mp4'},
//     { stimulus: 'videos/test2.mp4'},
//     { stimulus: 'videos/test3.mp4'}
//   ];

// create pre-video-fixation node
var fixation_vid = {
    type: 'html-keyboard-response',
    stimulus: '<div style="font-size:60px;">+</div>',
    choices: jsPsych.NO_KEYS,
    trial_duration: function() {
        return Math.floor(Math.random() * 500) + 1500;
    }
    // trial_duration: 1000
};

// create pre-test-fixation node
var fixation_test = {
    type: 'html-keyboard-response',
    stimulus: '<div style="font-size:60px;">+</div>',
    choices: jsPsych.NO_KEYS,
    trial_duration: function() {
        return Math.floor(Math.random() * 1500) + 500;
    }
    // trial_duration: 1000
};

var video_trial = {
    type: 'video-keyboard-response',
    // stimulus: [jsPsych.timelineVariable('stimulus')],
    stimulus: function(){
      var stim = jsPsych.timelineVariable('stimulus')
      vid_source = stim.map(item => item.video_source)
      return vid_source;
    },
    margin_vertical: '10px',
    height: '500px',
    // choices: jsPsych.NO_KEYS,
    choices: ["a"],
    trial_ends_after_video: true
};

var lex_dec = {
    type: 'html-keyboard-response',
    choices: ["i","j","ι","ξ"],
    trial_duration: 2000,
    response_ends_trial: true,
    // stimulus: "<p id = 'lex_stim' style = 'color: black; font-size: 60pt;'>αγάπη<\/p>",
    stimulus: function(){
      var stimuli = jsPsych.timelineVariable('stimulus')
      stim = stimuli.map(item => item.stimulus)
      return stim;
    },
    data: jsPsych.timelineVariable('data'),
    on_finish: function(data){
      var correct = false;
      if(data.response == "ι"){
        data.response = "i";
      }
      else if(data.response == "ξ"){
        data.response = "j";
      }
      if(data.response == data.key_answer && data.rt > -1){
        correct = true;
      }
      data.correct = correct;
    },
    // post_trial_gap: function() {
    //     return Math.floor(Math.random() * 1500) + 500;
    // }
};

var test_procedure = {
    timeline: [fixation_vid, video_trial, fixation_test, lex_dec],
    timeline_variables: vid_stimuli,
    randomize_order: true,
    repetitions: 1
  };

timeline.push(test_procedure);
