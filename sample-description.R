### Import data ----

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
