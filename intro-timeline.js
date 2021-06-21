function new_timeline() {
    /* defining test timeline*/

    var intro = {
      timeline: [{
        type: "html-button-response",
        choices: ['Είμαι 18 χρονών και άνω. Συνέχεια'],
        stimulus: jsPsych.timelineVariable('stimulus'),
        post_trial_gap: 500
    }],
    timeline_variables: intro_text,
    sample: {type: 'fixed-repetitions', size: 1}
  };
  
  return [intro];
  }
  
