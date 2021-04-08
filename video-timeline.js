function new_timeline() {
  /* defining test timeline*/
  var  vid_stimuli_old =  ["/Users/au183362/Documents/postdoc/NeDComm/interns/Afroditi_Ntourountzi/GSL/Final_videos/αγάπη_m.mp4", "/Users/au183362/Documents/postdoc/NeDComm/interns/Afroditi_Ntourountzi/GSL/Final_videos/γραμμή_m.mp4", "/Users/au183362/Documents/postdoc/NeDComm/interns/Afroditi_Ntourountzi/GSL/Final_videos/ιδέα_m.mp4", "/Users/au183362/Documents/postdoc/NeDComm/interns/Afroditi_Ntourountzi/GSL/Final_videos/λάθος_m.mp4", "/Users/au183362/Documents/postdoc/NeDComm/interns/Afroditi_Ntourountzi/GSL/Final_videos/λέξη_m.mp4"];

  var vid_stimuli = stimuliExp.vidArray('exp');


  var video = {
    timeline: [{
      type: 'video-keyboard-response',
      // stimulus: jsPsych.timelineVariable('stimulus'),
      sources: jsPsych.timelineVariable('stimulus'),
      margin_vertical: '10px',
      height: '300px',
      choices: jsPsych.NO_KEYS,
      trial_ends_after_video: true
    }],
    timeline_variables: vid_stimuli,
    randomize_order: false,
    repetitions: 1
  };
  return [video];
}
