function new_timeline() {
    /* defining test timeline*/
    var level = ["Πολύ καλό", "Μέτριο", "Δεν γράφω στα Νέα Ελληνικά"];
  
    var writtenGreek = {
      timeline: [{
        type: "survey-multi-choice",
        questions: [
          {prompt: "Ποιο είναι το επίπεδο επάρκειάς σας στα γραπτά Ελληνικά;", name: 'writtenGreek', options: level, required: true}
        ],
        post_trial_gap: 500
    }],
  };
  return [writtenGreek];
  }
  