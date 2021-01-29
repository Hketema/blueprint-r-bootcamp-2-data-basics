# make package contents available
library(dplyr)
library(bootcampdata)

# 1. Ingredients

# a. lag
# - the lag function takes a vector x and, by default, replaces each value x[i] with the value of x[i-1]
# - in longitudinal data sets like esg, where we have multiple measurements of the same thing over time,
#   you can use it to calculate the difference between each observation and the previous observation

x <- 1:5

x

lag_x <- lag(x)

lag_x

change_x <- x - lag(x)

change_x

# b. group_by + mutate
# - group_by works most intuitively with summarize, but it also works with mutate
# - the group_by + mutate pipeline can be very helpful when working with data like esg,
#   because it lets you replicate operations for each participant
# - the example below uses group_by + mutate to estimate the start date of each cohort
#   from the first test date
# - you must explicitly ungroup() the data after using group_by + mutate to avoid
#   unintentional results

esg_cohort_start <- esg %>%

  group_by(cohort_id) %>%
  mutate(cohort_start_date = min(date)) %>%
  ungroup()

esg_cohort_start %>%
  count(cohort_id, cohort_start_date) %>%
  arrange(cohort_start_date)

# c. testing for missing values
# - lagged vectors will, by default, have missing values
# - these missing values will propagate to estimates of differences
# - after you use group_by + mutate to generate per-participant changes in scores and dates,
#   you'll need to drop rows with missing values in your calculated columns
# - you cannot test for missingness with regular logical operators (NA == NA returns NA).
#   Instead, you have to use the function is.na() (is.na(NA) returns TRUE, as we want)
# - ! is the negation operator, you can replace it with "not" in your head (!TRUE returns FALSE)

example_data_with_missing <- tibble(
  index = 1:5,
  number_we_care_about = c(NA, "not missing", "not missing", NA, "not missing")
)

example_data_with_missing

example_data_without_missing <- example_data_with_missing %>%
  filter(
    !is.na(number_we_care_about)
  )

example_data_without_missing

# 2. Analysis questions
# - What is the average number of days between tests?
# - What are the minimum and maximum numbers of days between tests? How might you deal with this in analysis?
# - For each skill, what is the average amount by which each participant's score changes between tests?
