function new_timeline() {
  /* defining test timeline*/
  var test = {
    timeline: [{
      type: 'html-keyboard-response',
      choices: ["i","j"],
      trial_duration: 2000,
      response_ends_trial: true,
      stimulus: jsPsych.timelineVariable('stimulus'),
      data: jsPsych.timelineVariable('data'),
      on_finish: function(data){
        var correct = false;
        if(data.response == 'i' &&  data.key_press == 105 && data.rt > -1){
          correct = true;
        } else if(data.response == 'j' &&  data.key_press == 106 && data.rt > -1){
          correct = true;
        }
        data.correct = correct;
      },
      post_trial_gap: function() {
          return Math.floor(Math.random() * 1500) + 500;
      }
    }],
    timeline_variables: lex_stimuli,
    repetitions: 1
    /*sample: {type: 'fixed-repetitions', size: reps_per_trial_type}*/
  };
  return [test];
}
