# Make package contents available
library(dplyr)
library(bootcampdata)

# This is a comment.
# Comments are used to add explanatory text to your code.
# They are not evaluated as code, so you can write whatever.
# You can convert multiple lines to a comment by highlighting them and pressing Ctrl + Shift + C

# 1. Examine the data
#   - This section shows ways that you can get a quick overview of a dataframe
#   - Often, the best way to understand your data is to explore it more intentionally,
#     by asking and answering specific questions.
#   - This represents a significant adjustment for people when they move from excel to R,
#     but if you can make the shift successfully, you will dramatically expand your data horizons

# a. just print the dang thing
esg

# b. get an overview of column contents
summary(esg)

# c. examine all the data like you would a spreadsheet
View(esg)

# d. count the values in a specific column
count(esg, formal_education)

# e. arrange values to get a sense of what's going on with rows at the extremes
arrange(esg, score)
arrange(esg, desc(score))

# 2. Subsetting and summarizing
#   - Naming objects is hard. Here are a few tips:
#     + Be thoughtful
#     + Be verbose
#     + Use snake_case (lowercase words separated by underscores)
#     + Emphasize readability over typing economy

# a. create a subset of esg that only includes the first test result for each skill for each participant
#   - to test for equality, use the '==' operator
esg_first <- filter(esg, test == 1)

esg_first

# b. (your turn) further subset esg_first to only include the first 'Document Use' test for each participant
esg_first_document_use <- filter(esg_first, ) # <- fill in the function call here

esg_first_document_use

# c. select only the participant_id and score columns
#   - this step is not necessary, and is here only to illustrate
#     how the select function works
esg_first_document_use_minimal <- select(
  esg_first_document_use,
  participant_id,
  score
)

esg_first_document_use_minimal

# d. use summarize to calculate the median score for the first document use test
first_score_summary_document_use <- summarize(
  esg_first_document_use_minimal,
  median_score = median(score)
)

first_score_summary_document_use

# e. (your turn) rework score_summary to include the mean score as well
#   - to take the mean of a vector x, use mean(x)
first_score_summary_document_use <- summarize(
  esg_first_document_use,
  median_score = median(score),
  mean_score = , # <- fill in this line
)

# 3. Use group_by to calculate summarize across skills

# a. group esg_first by skill
esg_first_by_skill <- group_by(esg_first, skill)

# b. summarize the grouped data in the same way that you summarized the subset
first_score_summary <- summarize(
  esg_first_by_skill,
  median_score = median(score),
  mean_score = mean(score)
)

first_score_summary

# 4. Putting it all together with the pipe
#   - the pipe ( %>% ) passes the output from the left side into the function call on the right
#     as the first parameter
#   - Please, for your sake, use the shortcut Ctrl + Shift + M to create pipes
#   - it works with any function in R, but it works especially well with dplyr functions because
#     they all accept and return data frames
#   - It helps us by:
#     + eliminating the need for awkward intermediate assignment
#     + aligning order between code and execution

# a. revisiting exercise 2
#   - Note: filter() accepts any number of logical tests, and returns rows for which all of them are true
#   - Generally, it will make your code easier to read if you include a line break after each pipe

first_score_summary_document_use <- esg %>%
  filter(
    test == 1,
    skill == "Document Use"
  ) %>%
  summarize(
    mean_score = mean(score),
    median_score = median(score)
  )

first_score_summary_document_use

# b. (your turn) revisiting exercise 3
#   - use the pipe to remake first_score_summary


