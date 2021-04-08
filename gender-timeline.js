function new_timeline() {
  /* defining test timeline*/
  var gend = ["Άντρας", "Γυναίκα", "Άλλο", "Δεν επιθυμώ να απαντήσω"];

  var gender = {
    timeline: [{
      type: "survey-multi-choice",
      questions: [
        {prompt: "Παρακαλώ επιλέξτε το φύλο σας.", name: 'Gender', options: gend, required: true},
      ],
      post_trial_gap: 500
  }],
};
return [gender];
}
