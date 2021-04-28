//instructions in Greek
function new_timeline() {
  /* defining test timeline*/
  var greek = {
    timeline: [{
      type: 'instructions',
      // pages: jsPsych.timelineVariable("stimulus"),
      pages: ['<p>Σας ευχαριστούμε που συμπληρώσατε τη δημογραφική έρευνα.</p>' +
          '<p>Πρόκειται να δεις ένα βίντεο με κάποιον που νοηματίζει μια λέξη</p>' +
          '<p>και έπειτα, μία γραπτή λέξη θα εμφανιστεί στην οθόνη σου.</p>'+
          '<p>Θα θέλαμε να αποφασίσεις όσο πιο γρήγορα μπορείς, εάν η γραπτή λέξη</p>' +
          '<p>είναι πραγματική ελληνική λέξη ή όχι.</p>'+
          '<p>Πάτησε <b>"I"</b> στο πληκτρολόγιό σου εάν νομίζεις ότι <b>ΔΕΝ</b> είναι πραγματική λέξη.</p>' +
          '<p>Πάτησε <b>"J"</b> στο πληκτρολόγιό σου εάν νομίζεις ότι <b>ΕΙΝΑΙ</b> πραγματική λέξη.</p>' +
          '<p>Πάτησε το πλήκτρο για να ξεκινήσεις.</p>'],
      allow_keys: false,
      show_clickable_nav: true
    }]
    // timeline_variables: instructions_text
  };
  return [greek];
}
