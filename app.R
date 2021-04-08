
# # ####################################################
# # # This script makes a psychTestR implementation of
# # # Sign_language_project
# # # Date:2021
# # # Author: Afroditi Ntourountzi
# # ####################################################


library(htmltools)
library(psychTestR)
library(tibble)
library(shiny)
library(jspsychr)
library(dplyr)

base_dir <- "/Users/afrod/Desktop/GSL"
# base_dir <- "/Users/au183362/Documents/postdoc/NeDComm/interns/Afroditi_Ntourountzi/GSL"
jspsych_dir <- file.path(base_dir, "jspsych-6-2")

write_to_file <- function(json_object,file_name,var_name=NULL){
  if(is.null(var_name)){
    write(json_object, file=file_name)
  }else{
    write(paste("var ",var_name,"= ", json_object), file=file_name)
  }
}

# test setup
real_words = c("αγάπη", "αλλαγή", "βήμα", "βράδυ", "χωριό", "χρώμα", "ευθύνη", "έρευνα", "φύση", "γραμμή", "ιδέα", "λάθος", "λέξη", "λύση", "νίκη", "νησί", "νόμος", "σχέδιο", "όριο", "σελίδα")
rl = length(real_words)
pseudo_words = c("εκάπη", "εγγαγή", "μήβα", "βρύδα", "βοριό", "πρώμα", "αυδύνη", "άλευνα", "γύση", "τραμμή", "αδέα", "κάθος", "πέξη", "λύβη", "πίκη", "λησί", "βόνος", "γδέσιο", "άλιο", "δασέλι")
pl = length(pseudo_words)
stim =  c(rep(real_words, times=2), rep(pseudo_words, times=2))
sl = length(stim)
lex_test <- data.frame(word = stim,
                       word_type = c(rep(c("1", "2"), each=rl), rep("3", each=2*pl)))

# video_test = c(rep(c("test", "me"), each=2), rep(c("nov", "rale"), each=2))
video_test = rep(stim[1:(length(stim)/2)], times=4)
vl = length(video_test)
vid_stim_test <- data.frame( video = video_test,
                             video_source = file.path(base_dir, "Final_videos", 
                                                      c(paste(video_test[1:(vl/2)], 
                                                              "m.mp4", sep = "_"), 
                                                        paste(video_test[(vl/2+1):vl], 
                                                              "n.mp4", sep = "_"))),
                             video_type = rep(c("1", "2"), each=vl/2))

# with mouthing
new_lex_test = sample(lex_test$word[(rl+1):(rl*2)])
print(new_lex_test)
while (any(new_lex_test==vid_stim_test$video[(rl+1):(rl*2)])) {     
  new_lex_test = sample(lex_test$word[(rl+1):(rl*2)])
  print(new_lex_test)
}
new_lex_test_m=  vid_stim_test[(rl+1):(rl*2),]
new_lex_test_m$word = new_lex_test
new_lex_test_m$word_type = lex_test$word_type[(rl+1):(rl*2)]

# without mouthing
new_lex_test = sample(lex_test$word[(rl+1):(rl*2)])
print(new_lex_test)
while (any(new_lex_test==vid_stim_test$video[(5*rl+1):(rl*6)])) {     
  new_lex_test = sample(lex_test$word[(rl+1):(rl*2)])
  print(new_lex_test)
}
new_lex_test_n =  vid_stim_test[(5*rl+1):(rl*6),]
new_lex_test_n$word = new_lex_test
new_lex_test_n$word_type = lex_test$word_type[(rl+1):(rl*2)]

avg_match <- function(y,z) {
  # print(y)
  # print(z)
  mean(apply(do.call(rbind, strsplit(c(y, z), "")), 2, function(x){
    # print(x)
    length(unique(x[!x %in% "_"])) == 1
  }))}

# WITH mouthing
new_pseudo_test = sample(lex_test$word[(sl/2+1):sl])
print(new_pseudo_test)
while (any(mapply(avg_match, new_pseudo_test, vid_stim_test$video[(2*pl+1):(pl*4)])>0.5)) {
  new_pseudo_test = sample(lex_test$word[(sl/2+1):sl])
  print(new_pseudo_test)
}
new_pseudo_test_m =  vid_stim_test[(2*pl+1):(pl*4),]
new_pseudo_test_m$word = new_pseudo_test
new_pseudo_test_m$word_type = lex_test$word_type[(sl/2+1):sl]

# WITHOUT mouthing
new_pseudo_test = sample(lex_test$word[(sl/2+1):sl])
print(new_pseudo_test)
while (any(mapply(avg_match, new_pseudo_test, vid_stim_test$video[(6*rl+1):(rl*8)])>0.5)) {
  new_pseudo_test = sample(lex_test$word[(sl/2+1):sl])
  print(new_pseudo_test)
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

full_test$color = 'black'
full_test$id = "lex_stim"
full_test$fontsize = "60pt"
full_test <- full_test %>% 
  mutate(response = if_else(word_type > 2, "j", "i")) %>%
  mutate(word_type = recode(word_type, "1" = "same_word", "2" = "diff_word", "3" = "pseudoword")) %>%
  mutate(video_type = recode(video_type, "1" = "mouthing", "2" = "no_mouthing"))

full_test$stimulus <- html_stimulus(df = full_test, 
                                    html_content = "word",
                                    html_element = "p",
                                    column_names = c("color","fontsize"),
                                    css = c("color", "font-size"),
                                    id = "id")

##### for testing:
full_test = full_test[1:5,]

# create json object from dataframe
lex_json <- stimulus_df_to_json(df = full_test,
                                stimulus = "stimulus",
                                data = c("word","response","word_type",
                                         "video","video_source","video_type"))

# vid_json <- stimulus_df_to_json(df = full_test,
#                                 stimulus = "video_source",
                                # data = c("word","response","word_type",
                                #          "video","stimulus","video_type"))

# write json object to script
write_to_file(lex_json, file.path(base_dir, "lex_stimuli.js"), "lex_stimuli")
# write_to_file(list(full_test$video_source), file.path(base_dir, "vid_stimuli.js"), "vid_stimuli")


###############################
##### jsPsych starts here #####
###############################

# # For jsPsych

head <- tags$head(
  # jsPsych files
  
  
  # # If you want to use original jspsych.js, use this:
  
  includeScript(file.path(jspsych_dir, "jspsych.js")),
  
  # If you want to display text while preloading files (to save time), specify your intro_text
  # in jsPsych.init (in run-jspsych.js) and call jspsych_preloadprogressbar.js here:
  #includeScript(file.path(jspsych_dir, "jspsych_preloadprogressbar.js")),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-html-button-response.js")
  ),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-html-keyboard-response.js")
  ),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-video-keyboard-response.js")
  ),
  
  # includeScript(
  #   file.path(jspsych_dir, "plugins/jspsych-fullscreen.js.js")
  # ),
  # 
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-survey-text.js")
  ),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-survey-multi-choice.js")
  ),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-survey-html-form.js")
  ),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-instructions.js")
  ),
  
  # includeScript(
  #   file.path(jspsych_dir, "plugins/jspsych-preload.js")
  # ),
  
  # Custom files
  includeCSS(file.path(jspsych_dir, "css/jspsych.css"))
  # includeCSS("css/style.css")
)

###################

# PsychTestR elements

#####
ui_fixa <- tags$div(
  head,
  includeScript(file.path(base_dir, "fixa-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

fixation <- page(
  ui = ui_fixa,
  label = "fixation",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)


ui_video <- tags$video(
  head,
  # includeScript(file.path(base_dir, "vid_stimuli.js")),
  includeScript(file.path(base_dir, "vid-array.js")),
  includeScript(file.path(base_dir, "video-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

video <- page(
  ui = ui_video,
  label = "video",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)


ui_test <- tags$div(
  head,
  includeScript(file.path(base_dir, "lex_stimuli.js")),
  includeScript(file.path(base_dir, "test-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

test <- page(
  ui = ui_test,
  label = "test",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)


########## SURVEY ##########

##Age and nationality

ui_demographics <- tags$div(
  head,
  includeScript(file.path(base_dir, "demographics-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
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
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
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
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
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
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
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
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
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
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
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
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
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

## Handiness, vision, disease

ui_neuro <- tags$div(
  head,
  includeScript(file.path(base_dir, "neuro-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
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

##Thanks
ui_thanks <- tags$div(
  head,
  includeScript(file.path(base_dir, "thanks_text.js")),
  includeScript(file.path(base_dir, "thanks-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

thanks <- page(
  ui = ui_thanks,
  label = "thanks",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE,
  final = TRUE
)


elts <- join(
  new_timeline(join(
    #intro,
    # demographics,
    # gender,
    deaf1,
    # deaf2,
    # cochlear1,
    # cochlear2,
    # mainlang,
    # neuro,
    #education,
    elt_save_results_to_disk(complete = FALSE), # anything that is saved here counts as completed
    fixation,
    video,
    elt_save_results_to_disk(complete = FALSE), # anything that is saved here counts as completed
    fixation,
    test,
    elt_save_results_to_disk(complete = TRUE), # anything that is saved here counts as completed
    thanks
  ), default_lang = "gr")
)

exp <- make_test(
  elts = elts,
  opt = test_options(title="GSL, Aarhus 2021",
                     admin_password="", # write a secret password here
                     enable_admin_panel=TRUE,
                     languages = 'gr',
                     researcher_email="201902479@post.au.dk",
                     # problems_info="Problems? Contact 201902479@post.au.dk",
                     display = display_options(
                       full_screen = TRUE,
                       css = file.path(jspsych_dir, "css/jspsych.css")
                     )))

 # shiny::runApp(".")
