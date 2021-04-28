//instructions in Greek
function new_timeline() {
  /* defining test timeline*/
  var greek = {
    timeline: [{
      type: 'instructions',
      // pages: jsPsych.timelineVariable("stimulus"),
      pages: ['<p>Σας ευχαριστούμε που συμπληρώσατε τη δημογραφική έρευνα.</p>' +
          '<p>Στη συνέχεια, πρόκειται να δείτε ένα βίντεο με κάποιον που νοηματίζει μια λέξη</p>' +
          '<p>και έπειτα, μία γραπτή λέξη θα εμφανιστεί στην οθόνη σας.</p>'+
          '<p>Θα θέλαμε να αποφασίσετε όσο πιο γρήγορα μπορείτε, εάν η γραπτή λέξη</p>' +
          '<p>είναι πραγματική ελληνική λέξη ή όχι.</p>'+
          '<p>Πατήστε <b>"I"</b> στο πληκτρολόγιό σας εάν νομίζετε ότι <b>ΔΕΝ</b> είναι πραγματική λέξη.</p>' +
          '<p>Πατήστε <b>"J"</b> στο πληκτρολόγιό σας εάν νομίζετε ότι <b>ΕΙΝΑΙ</b> πραγματική λέξη.</p>' +
          '<p>Πατήστε το πλήκτρο για να ξεκινήσετε.</p>'],
      allow_keys: false,
      show_clickable_nav: true
    }]
    // timeline_variables: instructions_text
  };
  return [greek];
}
