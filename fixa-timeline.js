function new_timeline() {
  /* defining test timeline*/
  var fixation = {
    type: 'html-keyboard-response',
    stimulus: '<div style="font-size:60px;">+</div>',
    choices: jsPsych.NO_KEYS,
    trial_duration: 1000
  };
  return [fixation];
}
