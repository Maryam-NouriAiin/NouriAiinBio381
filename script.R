source("functions.R")

# Define global variables
set.seed(123)  # Set seed for reproducibility
sample_size <- 30
mean_high_temp <- 10
var_high_temp <- 1.5
mean_low_temp <- 15
var_low_temp <- 2.0

high_temp()
low_temp()
df <- rbind(high_temp(), low_temp())

anova_boxplot() 
num_iterations <- 6
multiple_iterations()
min_effect_size()
min_sample_size()
ci_diff()
num_iterations <- 5
multiple_iterations(num_iterations)

# Perform multiple iterations of analysis
summary_stats <- multiple_iterations(num_iterations)

# Print summary statistics
print_summary_statistics(summary_stats)


