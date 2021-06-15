
# # ####################################################
# # # This script makes a psychTestR implementation of
# # # Sign_language_project
# # # Date:2021
# # # Author: Afroditi Ntourountzi
# # ####################################################


set.seed(NULL)

library(htmltools)
library(psychTestR)
library(tibble)
library(shiny)
library(jspsychr)
library(dplyr)
library(data.table)

base_dir <- "/srv/shiny-server/GSL-study"
jspsych_dir <- file.path(base_dir, "jspsych-6.3.1")

write_to_file <- function(json_object,file_name,var_name=NULL){
  if(is.null(var_name)){
    write(json_object, file=file_name)
  }else{
    write(paste("var ",var_name,"= ", json_object, ";"), file=file_name)
  }
}

###############################
# Designing the randomization structure #
###############################
# test setup
keys = c("i", "j")
keyboard = c('"I"', '"J"')
randizer = sample(1:length(keys))
rand_keys = keys[randizer]
rand_keyboard = keyboard[randizer]

real_words = c("αγάπη", "αλλαγή", "βήμα", "βράδυ", "χωριό", "χρώμα", "ευθύνη", "έρευνα", "φύση", "γραμμή", "ιδέα", "λάθος", "λέξη", "λύση", "νίκη", "νησί", "νόμος", "σχέδιο", "όριο", "σελίδα")
rl = length(real_words)
pseudo_words = c("εκάπη", "εγγαγή", "μήβα", "βρύδα", "βοριό", "πρώμα", "αυδύνη", "άλευνα", "γύση", "τραμμή", "αδέα", "κάθος", "πέξη", "λύβη", "πίκη", "λησί", "βόνος", "γδέσιο", "άλιο", "δασέλι")
word_pairs <- real_words
names(word_pairs) <- pseudo_words

pl = length(pseudo_words)
stim =  c(rep(real_words, times=2), rep(pseudo_words, times=2))
sl = length(stim)
lex_test <- data.frame(word = stim,
                       word_type = c(rep(c("1", "2"), each=rl), rep("3", each=2*pl)))

# video_test = c(rep(c("test", "me"), each=2), rep(c("nov", "rale"), each=2))
video_test = rep(stim[1:(length(stim)/2)], times=4)
vl = length(video_test)
vid_stim_test <- data.frame( video = video_test,
                             video_source = file.path("videos", 
                                                      c(paste(video_test[1:(vl/2)], 
                                                              "m.mp4", sep = "_"), 
                                                        paste(video_test[(vl/2+1):vl], 
                                                              "n.mp4", sep = "_"))),
                             video_type = rep(c("1", "2"), each=vl/2))

# with mouthing
new_lex_test = sample(lex_test$word[(rl+1):(rl*2)])
# print(new_lex_test)
while (any(new_lex_test==vid_stim_test$video[(rl+1):(rl*2)])) {     
  new_lex_test = sample(lex_test$word[(rl+1):(rl*2)])
  # print(new_lex_test)
}
new_lex_test_m=  vid_stim_test[(rl+1):(rl*2),]
new_lex_test_m$word = new_lex_test
new_lex_test_m$word_type = lex_test$word_type[(rl+1):(rl*2)]

# without mouthing
new_lex_test = sample(lex_test$word[(rl+1):(rl*2)])
# print(new_lex_test)
while (any(new_lex_test==vid_stim_test$video[(5*rl+1):(rl*6)])) {     
  new_lex_test = sample(lex_test$word[(rl+1):(rl*2)])
  # print(new_lex_test)
}
new_lex_test_n =  vid_stim_test[(5*rl+1):(rl*6),]
new_lex_test_n$word = new_lex_test
new_lex_test_n$word_type = lex_test$word_type[(rl+1):(rl*2)]

# avg_match <- function(y,z) {
#   # print(y)
#   # print(z)
#   mean(apply(do.call(rbind, strsplit(y, "")), 2, function(x){
#     # print(x)
#     str_detect(z, x)
#     # length(unique(x[!x %in% "_"])) == 1
#   }))}

lookup_pseudo <- function(y,z) {
  # print(y)
  # print(z)
  identical(word_pairs[y],z)
  }

# WITH mouthing
new_pseudo_test = sample(lex_test$word[(sl/2+1):sl])
# print(new_pseudo_test)
while (any(mapply(lookup_pseudo, new_pseudo_test, vid_stim_test$video[(2*pl+1):(pl*4)]))) {
  new_pseudo_test = sample(lex_test$word[(sl/2+1):sl])
  # print(new_pseudo_test)
}
# while (any(mapply(avg_match, new_pseudo_test, vid_stim_test$video[(2*pl+1):(pl*4)])>0.5)) {
#   new_pseudo_test = sample(lex_test$word[(sl/2+1):sl])
#   # print(new_pseudo_test)
# }
new_pseudo_test_m =  vid_stim_test[(2*pl+1):(pl*4),]
new_pseudo_test_m$word = new_pseudo_test
new_pseudo_test_m$word_type = lex_test$word_type[(sl/2+1):sl]

# WITHOUT mouthing
new_pseudo_test = sample(lex_test$word[(sl/2+1):sl])
# print(new_pseudo_test)
while (any(mapply(lookup_pseudo, new_pseudo_test, vid_stim_test$video[(6*rl+1):(rl*8)])>0.5)) {
  new_pseudo_test = sample(lex_test$word[(sl/2+1):sl])
  # print(new_pseudo_test)
}
new_pseudo_test_n =  vid_stim_test[(6*rl+1):(rl*8),]
new_pseudo_test_n$word = new_pseudo_test
new_pseudo_test_n$word_type = lex_test$word_type[(sl/2+1):sl]

# creating a full data frame with both written and video stimuli
# starting with the identical condition - WITH mouthing
full_test = merge(lex_test[1:rl,],  vid_stim_test[1:rl,], by = 0)
full_test = within(full_test, rm(Row.names))

# next are the shuffled real words
full_test = rbind(full_test, new_lex_test_m)

# next are the pseudowords
full_test = rbind(full_test, new_pseudo_test_m)

# AND NOW exactly the same - but for the NO MOUTHING condition
# starting with the identical condition - WITHOUT mouthing
temp_lex = lex_test[1:rl,]
row.names(temp_lex) = row.names(vid_stim_test[(4*rl+1):(rl*5),])
temp_ident = merge(temp_lex,  vid_stim_test[(4*rl+1):(rl*5),], by = 0)
temp_ident = within(temp_ident, rm(Row.names))
full_test = rbind(full_test, temp_ident)

# next are the shuffled real words
# combing full data frame with temp df
full_test = rbind(full_test, new_lex_test_n)

# next are the pseudowords
full_test = rbind(full_test, new_pseudo_test_n)


# now randomize across all words while still ensuring that there are no "repeat"-trials

# Obtaining the unique vector of those values
video.unique <- unique(full_test$video)
# NB! equivalent to just calling
# video.unique <- real_words
FT <- setDT(full_test)
iters <- (dim(FT)[1]/length(video.unique))/2 # split in two cuz we need the full stimuli split in two blocks
# block 1 (80 trials)
full_rand_test1 <- tibble()
for (i in 1:iters) {
  sampl = 0
  while (sampl == 0) {
    temp_idx <- FT[,list(idx=sample(.I,1)),by="video"]$idx
    temp_sample <- FT[temp_idx]
    if (!any(mapply(identical, head(temp_sample$word, -1), tail(temp_sample$word, -1)))) {
      sampl = 1
    }
  }
  full_rand_test1 <- bind_rows(full_rand_test1, temp_sample)
  FT <- FT[-temp_idx]
}

# block 2 (80 trials)
full_rand_test2 <- tibble()
for (i in (iters+1):(2*iters)) {
  sampl = 0
  while (sampl == 0) {
    temp_idx <- FT[,list(idx=sample(.I,1)),by="video"]$idx
    temp_sample <- FT[temp_idx]
    if (!any(mapply(identical, head(temp_sample$word, -1), tail(temp_sample$word, -1)))) {
      sampl = 1
    }
  }
  full_rand_test2 <- bind_rows(full_rand_test2, temp_sample)
  if (!i == 2*iters) {
    FT <- FT[-temp_idx]
  }
}

full_rand_test1$color = 'black'
full_rand_test1$id = "lex_stim"
full_rand_test1$fontsize = "60pt"
full_rand_test1 <- full_rand_test1 %>% 
  mutate(key_answer = if_else(word_type > 2, rand_keys[1], rand_keys[2])) %>%
  mutate(word_type = recode(word_type, "1" = "same_word", "2" = "diff_word", "3" = "pseudoword")) %>%
  mutate(video_type = recode(video_type, "1" = "mouthing", "2" = "no_mouthing"))

full_rand_test1$stimulus <- html_stimulus(df = as.data.frame(full_rand_test1), 
                                    html_content = "word",
                                    html_element = "p",
                                    column_names = c("color","fontsize"),
                                    css = c("color", "font-size"),
                                    id = "id")

full_rand_test2$color = 'black'
full_rand_test2$id = "lex_stim"
full_rand_test2$fontsize = "60pt"
full_rand_test2 <- full_rand_test2 %>% 
  mutate(key_answer = if_else(word_type > 2, rand_keys[1], rand_keys[2])) %>%
  mutate(word_type = recode(word_type, "1" = "same_word", "2" = "diff_word", "3" = "pseudoword")) %>%
  mutate(video_type = recode(video_type, "1" = "mouthing", "2" = "no_mouthing"))

full_rand_test2$stimulus <- html_stimulus(df = as.data.frame(full_rand_test2), 
                                          html_content = "word",
                                          html_element = "p",
                                          column_names = c("color","fontsize"),
                                          css = c("color", "font-size"),
                                          id = "id")

##### for testing:
full_rand_test1 = full_rand_test1[1:5,]
full_rand_test2 = full_rand_test2[1:5,]

# create json object from dataframe
vid_json1 <- stimulus_df_to_json(df = full_rand_test1,
                                stimulus = c("video_source","stimulus"),
                                data = c("word","key_answer","word_type",
                                         "video","stimulus","video_type"))
vid_json2 <- stimulus_df_to_json(df = full_rand_test2,
                                 stimulus = c("video_source","stimulus"),
                                 data = c("word","key_answer","word_type",
                                          "video","stimulus","video_type"))

# write json object to script
write_to_file(vid_json1, file.path(base_dir, "vid_stimuli1.js"), "vid_stimuli")
write_to_file(vid_json2, file.path(base_dir, "vid_stimuli2.js"), "vid_stimuli")

write("var vid_array = [", file="vid_array1.js")
apply(full_rand_test1[1:nrow(full_rand_test1)-1,], 1, function(x){
  write(paste("'",x["video_source"],"',", sep=""), file="vid_array1.js", append=TRUE)
  })
write(paste("'",full_rand_test1[nrow(full_rand_test1),"video_source"],"'];", sep=""),
      file="vid_array1.js",append = TRUE)

write("var vid_array = [", file="vid_array2.js")
apply(full_rand_test1[1:nrow(full_rand_test1)-1,], 1, function(x){
  write(paste("'",x["video_source"],"',", sep=""), file="vid_array2.js", append=TRUE)
})
write(paste("'",full_rand_test1[nrow(full_rand_test1),"video_source"],"'];", sep=""),
      file="vid_array2.js",append = TRUE)



# Fix instructions (to align with randomization of response options)
instr_stim = paste("<p>Σας ευχαριστούμε που συμπληρώσατε τη δημογραφική έρευνα.</p>",
                   "<p>Στη συνέχεια πρόκειται να δείτε ένα βίντεο με κάποιον που νοηματίζει μια λέξη και έπειτα,</p>",
                   "<p>μια γραπτή λέξη θα εμφανιστεί στην οθόνη σας.</p>",
                   "<p>Θα θέλαμε να αποφασίσετε όσο πιο γρήγορα μπορείτε, εάν η γραπτή λέξη είναι πραγματική λέξη ή όχι.",
                   "<p>Πατήστε <b>", rand_keyboard[1], 
                   "</b>στο πληκτρολόγιό σου εάν νομίζετε ότι <b>ΔΕΝ</b> είναι πραγματική λέξη.</p>",
                   "<p>Πάτησε <b>", rand_keyboard[2],
                   "</b>στο πληκτρολόγιό σου εάν νομίζετε ότι <b>ΕΙΝΑΙ</b> πραγματική λέξη</p>")


instr_stim_df = data.frame(stimulus = instr_stim)

# create json object from dataframe
instr_json <- stimulus_df_to_json(df = instr_stim_df,
                                   stimulus = "stimulus")
# write json object to script
write_to_file(instr_json, paste0(base_dir, "/instr_text.js"), "instr_text")



###############################
##### jsPsych starts here #####
###############################

head <- tags$head(
  includeScript(file.path(jspsych_dir, "jspsych.js")),
  includeScript(file.path(jspsych_dir, "plugins/jspsych-html-keyboard-response.js")),
  includeScript(file.path(jspsych_dir, "plugins/jspsych-html-button-response.js")),
  includeScript(file.path(jspsych_dir, "plugins/jspsych-video-keyboard-response.js")),
  includeScript(file.path(jspsych_dir, "plugins/jspsych-survey-text.js")),
  includeScript(file.path(jspsych_dir, "plugins/jspsych-survey-multi-choice.js")),
  includeScript(file.path(jspsych_dir, "plugins/jspsych-survey-html-form.js")),
  includeScript(file.path(jspsych_dir, "plugins/jspsych-instructions.js")),
  includeScript(file.path(jspsych_dir, "plugins/jspsych-preload.js"))
)

ui_video <- tags$div(
  head, 
  includeScript(file.path(base_dir, "vid_stimuli.js")),
  includeScript(file.path(base_dir, "vid_array.js")),
  includeScript("video-timeline.js"),
  includeScript("run-jspsych-vid.js"),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

trial <- page(
  ui = ui_video,
  label = "trial",
  get_answer = function(input, ...) input$jspsych_results,
  validate = function(answer, ...) nchar(answer) > 0L,
  save_answer = TRUE
)

##Intro
ui_intro <- tags$div(
  head,
  includeScript(file.path(base_dir, "intro_text.js")),
  includeScript(file.path(base_dir, "intro-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

intro <- page(
  ui = ui_intro,
  label = "intro",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Instructions 
ui_instructions <- tags$div(
  head,
  includeScript(file.path(base_dir, "instr_text.js")),
  includeScript(file.path(base_dir, "instructions-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

instructions <- page(
  ui = ui_instructions,
  label = "instructions",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)


##### Survey questions #####
##Age and nationality
ui_demographics <- tags$div(
  head,
  includeScript(file.path(base_dir, "demographics-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

demographics <- page(
  ui = ui_demographics,
  label = 'demographics',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

## Gender

ui_gender <- tags$div(
  head,
  includeScript(file.path(base_dir, "gender-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

gender <- page(
  ui = ui_gender,
  label = 'gender',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

## Congeniality1

ui_deaf1 <- tags$div(
  head,
  includeScript(file.path(base_dir, "deaf1-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

deaf1 <- page(
  ui = ui_deaf1,
  label = 'deaf1',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

## Congeniality2

ui_deaf2 <- tags$div(
  head,
  includeScript(file.path(base_dir, "deaf2-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

deaf2 <- page(
  ui = ui_deaf2,
  label = 'deaf2',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

## Cochlear_implant1

ui_cochlear1 <- tags$div(
  head,
  includeScript(file.path(base_dir, "cochlear1-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

cochlear1 <- page(
  ui = ui_cochlear1,
  label = 'cochlear1',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

## Cochlear_implant2

ui_cochlear2 <- tags$div(
  head,
  includeScript(file.path(base_dir, "cochlear2-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

cochlear2 <- page(
  ui = ui_cochlear2,
  label = 'cochlear2',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

## Main/preferred language

ui_mainlang <- tags$div(
  head,
  includeScript(file.path(base_dir, "mainlang-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

mainlang <- page(
  ui = ui_mainlang,
  label = 'mainlang',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

## Education

ui_edu <- tags$div(
  head,
  includeScript(file.path(base_dir, "edu-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

education <- page(
  ui = ui_edu,
  label = 'education',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

## Handiness, vision, disease

ui_neuro <- tags$div(
  head,
  includeScript(file.path(base_dir, "neuro-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

neuro <- page(
  ui = ui_neuro,
  label = 'neuro',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Final
ui_final <- tags$div(
  head,
  includeScript(file.path(base_dir, "final-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

final <- final_page(tags$div(
  tags$p("Το πείραμα έφτασε στο τέλος του."),
  tags$p("Οι απαντήσεις σας έχουν καταγραφεί."),
  tags$p("Ευχαριστούμε πολύ για τη συμμετοχή σας!"),
  tags$p("Μπορείτε τώρα να κλείσετε το πρόγραμμα περιήγησής σας.")
))

elts <- join(
  intro,
  # demographics,
  # gender,
  # deaf1,
  # deaf2,
  # cochlear1,
  # cochlear2,
  # mainlang,
  # neuro,
  # education,
  instructions,
  trial,
  elt_save_results_to_disk(complete = TRUE),
  final
)

exp = make_test(
  elts = elts,
  opt = test_options(
    title="GSL, Aarhus 2021",
    admin_password="",  # write a secret password here
    enable_admin_panel=TRUE,
    researcher_email="201902479@post.au.dk",
    #problems_info=shiny::tags$span("Problems? Send an email to ", shiny::tags$b(researcher_email)),
    display = display_options(
      full_screen = TRUE, 
      css = file.path(jspsych_dir, "css/jspsych.css"))
  ))

# shiny::runApp('.')
