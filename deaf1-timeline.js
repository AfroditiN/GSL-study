function new_timeline() {
    /* defining test timeline*/

    var y_n = ["Ναι", "Όχι"];


    var deaf1 = {
      timeline: [{
        type: "survey-multi-choice",
        questions: [
          {prompt: "Είστε εκ γενετής κωφός;", name: 'Deafness1', options: y_n, required: true},

        ],
        post_trial_gap: 500
    }],
  };
  return [deaf1];
  }
