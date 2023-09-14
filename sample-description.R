### Setup ----
library("tidyverse")

# Import sample data ----
# sample_data <-
#   read.csv("../2022_work-life-politics/main study/Paper Text-Audio/Submission 1 (SRM)/data/data_long.csv") %>%
#   filter(condition == "audio") %>%
#   select(
#     ID_participant,
#     ID_participant_long,
#     sex.prolific,
#     age,
#     education_covariate,
#     survey_eval_difficulty
#   )

#n_audio_participants <- length(unique(sample_data$ID_participant)) #661
 
#n_audio_participants <- 661
 
#write_csv(sample_data, "./sample-data.csv")


# Start of Analysis ----
sample_data <- read_csv("./sample-data.csv")

# Metrics that we report in the paper

#final sample size of audio respondents
n_audio_participants

#age
mean(sample_data$age, na.rm=T)
sd(sample_data$age, na.rm=T)

#education at the level of an Associates or Bachelor's degree
mean(sample_data$education_covariate, na.rm=T)
sd(sample_data$education_covariate, na.rm=T)

#completing the survey was, on average, "Rather easy"
mean(sample_data$survey_eval_difficulty, na.rm=T)
sd(sample_data$survey_eval_difficulty, na.rm=T)
