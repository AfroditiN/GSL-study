function new_timeline() {
    /* defining test timeline*/
    var lang = ["Ελληνική Νοηματική Γλώσσα", "Ελληνικά", 'Άλλη'];
  
    var mainlang = {
      timeline: [{
        type: "survey-multi-choice",
        questions: [
          {prompt: "Ποια είναι η κύρια/προτιμώμενη γλώσσα επικοινωνίας σας;", name: 'Main_language', options: lang, required: true}
        ],
        post_trial_gap: 500
    }],
  };
  return [mainlang];
  }