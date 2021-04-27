function new_timeline() {
  /* defining test timeline*/
  var edu = ["Δεν πήγα σχολείο", "Δημοτικό", "Γυμνάσιο", "Λύκειο", "ΑΕΙ/ΤΕΙ", "Μεταπτυχιακό", "Διδακτορικό"];

  var education = {
    timeline: [{
      type: "survey-multi-choice",
      questions: [
        {prompt: "Παρακαλώ επιλέξτε το επίπεδο ολοκληρωμένης εκπαίδευσης.", name: 'Education', options: edu, required: true}
      ],
      post_trial_gap: 500
  }],
};
return [education];
}
