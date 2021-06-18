function new_timeline() {
    /* defining test timeline*/

    var cochlear2 = {
      timeline: [{
        type: "survey-text",
        questions: [
          {prompt: "Εάν ναι, σε ποια ηλικία βάλατε κοχλιακό εμφύτευμα;", name: 'Cochlear_impl2', required: false},
        ],
        post_trial_gap: 500
    }],
    sample: {type: 'fixed-repetitions', size: 1}
  };
  
  return [cochlear2];
  }
  
