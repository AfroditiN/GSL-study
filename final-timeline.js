function new_timeline() {
  /* defining test timeline*/
  var final = {
    timeline: [{
      type: "instructions",
      pages: ["<p>Το πείραμα έφτασε στο τέλος του.</p>" +
        "<p>Οι απαντήσεις σας έχουν καταγραφεί.</p>" +
        "<p>Ευχαριστούμε πολύ για τη συμμετοχή σας!</p>" +
        "<p>Μπορείτε τώρα να κλείσετε το πρόγραμμα περιήγησής σας.</p>"]
  }],
  sample: {type: 'fixed-repetitions', size: 1}
};
return [final];
}
