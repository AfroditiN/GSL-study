function new_timeline() {
  /* defining test timeline*/
  var y_n1 = ["Αριστερόχειρας", "Δεξιόχειρας", "Αμφίχειρας"];
  var y_n2 = ["Ναι", "Όχι"];
  var y_n3 = ["Ναι", "Όχι", "Επιθυμώ να μην απαντήσω"] 

  var neuro = {
    timeline: [{
      type: "survey-multi-choice",
      questions: [
        {prompt: "Είστε αριστερόχειρας, δεξιόχειρας, ή αμφίχειρας;", name: 'Handiness', options: y_n1, required: true},
        {prompt: "Έχετε κανονική (ή διορθωμένη σε κανονική) όραση;", name: 'Vision', options: y_n2, required: true},
        {prompt: "Έχετε ιστορικό, ή αντιμετωπίζετε επί του παρόντος νευρολογικές ή ψυχιατρικές ασθένειες;", name: 'Disease', options: y_n3, required: true},
      ],
      post_trial_gap: 500
  }],
};
return [neuro];
}
