function new_timeline() {
    /* defining test timeline*/

    var deaf2 = {
      timeline: [{
        type: "survey-text",
        questions: [
          {prompt: "Εάν όχι, σε ποια ηλικία χάσατε την ακοή σας;", name: 'Deafness2', required: false},
        ],
        post_trial_gap: 500
    }],
    sample: {type: 'fixed-repetitions', size: 1}
  };

  return [deaf2];
  }
