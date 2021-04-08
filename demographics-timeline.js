function new_timeline() {
  /* defining test timeline*/
  var demographics = {
    timeline: [{
      type: "survey-text",
      questions: [
        {prompt: "Πόσο χρονών είστε;", name: 'Age', required: true},
        {prompt: "Ποια είναι η εθνικότητά σας;", name: 'Nationality', required: true}
      ],
      post_trial_gap: 500
  }],
  sample: {type: 'fixed-repetitions', size: 1}
};
return [demographics];
}


