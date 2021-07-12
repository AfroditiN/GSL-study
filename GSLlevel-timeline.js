function new_timeline() {
    /* defining test timeline*/
    var level = ["Είμαι φυσικός ομιλητής", "Πολύ καλό", "Μέτριο", "Δεν ξέρω Ελληνική Νοηματική Γλώσσα"];
  
    var GSLlevel = {
      timeline: [{
        type: "survey-multi-choice",
        questions: [
          {prompt: "Ποιο είναι το επίπεδο επάρκειάς σας στην Ελληνική Νοηματική Γλώσσα;", name: 'GSLlevel', options: level, required: true}
        ],
        post_trial_gap: 500
    }],
  };
  return [GSLlevel];
  }
  