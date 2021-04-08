function new_timeline() {
    /* defining test timeline*/
    
    var y_n = ["Ναι", "Όχι"];
    
  
    var cochlear1= {
      timeline: [{
        type: "survey-multi-choice",
        questions: [
          {prompt: "Έχετε κοχλιακό εμφύτευμα;", name: 'Cochlear_impl1', options: y_n, required: true},
         
        ],
        post_trial_gap: 500
    }],
  };
  return [cochlear1];
  }