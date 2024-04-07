# Load required libraries
library(ggplot2)
library(dplyr)
library(MASS)
library(tidyverse)
library(pwr)
library(pwrss)
library(gridExtra)


# Function to generate data for higher temperature group
high_temp <- function() {
  data.frame(
    development_time = rnorm(sample_size, mean_high_temp, sd = sqrt(var_high_temp)),
    group = "Higher Temperature"
  )
}
#print(high_temp())
# Function to generate data for lower temperature group
low_temp <- function() {
  data.frame(
    development_time = rnorm(sample_size, mean_low_temp, sd = sqrt(var_low_temp)),
    group = "Lower Temperature"
  )
}
#print(low_temp())
# Combine the data frames
df <- rbind(high_temp(), low_temp())




# Function to perform ANOVA and generate box plot
anova_boxplot <- function() {
  anova_result <- aov(development_time ~ group, data = df)
  print(summary(anova_result))
  
  boxplot <- ggplot(df, aes(x = group, y = development_time, fill = group)) +
    geom_boxplot() +
    labs(title = "Development Time of Insects at Different Temperatures",
         x = "Temperature Group",
         y = "Development Time (days)") +
    theme_minimal()
  
  #print(boxplot)
}

# Call the function to perform ANOVA and create a box plot
anova_boxplot()



multiple_iterations <- function() {
  results <- list()
  num_iterations <- 6
  
  for (i in 1:num_iterations) {
    high_temp_data <- high_temp()  # Fixed function call
    low_temp_data <- low_temp()    # Fixed function call
    df <- rbind(high_temp_data, low_temp_data)
    
    anova_result <- aov(development_time ~ group, data = df)
    
    results[[i]] <- list(
      summary = summary(anova_result),
      data = df
    )
  }
  
  # Print summaries of ANOVA results for each iteration
  for (i in 1:num_iterations) {
    cat("Iteration", i, ":\n")
    #print(results[[i]]$summary)
  }
  
  # Generate plots showing the density of development_time by group for each iteration
  plot_list <- lapply(results, function(res) {
    ggplot(res$data, aes(x = development_time, fill = group)) +  # Fixed variable name
      geom_density(alpha = 0.5) +
      labs(title = "Development Time Density by Group",
           x = "Development Time",
           y = "Density") +
      theme_minimal()
  })
  
  gridExtra::grid.arrange(grobs = plot_list, ncol = 2)
}

multiple_iterations()


# Function to calculate minimum detectable effect size (Cohen's d)
min_effect_size <- function() {
  alpha <- 0.05
  n <- sample_size
  sd1 <- sqrt(var_high_temp)
  mean1 <- mean_high_temp
  sd2 <- sqrt(var_low_temp)
  mean2 <- mean_low_temp
  
  d_values <- seq(0.01, 1, by = 0.01)
  significant_effects <- numeric(length(d_values))
  
  for (i in 1:length(d_values)) {
    d <- d_values[i]
    means_diff <- d * sqrt((sd1^2 + sd2^2) / 2)
    t_test_result <- t.test(rnorm(n, mean1, sd1), rnorm(n, mean2, sd2), var.equal = TRUE)
    p_value <- t_test_result$p.value
    significant_effects[i] <- p_value
  }
  
  min_d <- d_values[which(significant_effects < alpha)[1]]
  print(paste("Minimum detectable effect size (Cohen's d):", min_d))
}

min_effect_size()

# Function to calculate minimum sample size for given effect sizes
min_sample_size <- function() {
  alpha <- 0.05
  power <- 0.8
  sd1 <- sqrt(var_high_temp)
  mean1 <- mean_high_temp
  sd2 <- sqrt(var_low_temp)
  mean2 <- mean_low_temp
  
  # Calculate Statistical Power
  result <- pwr.t.test(d = (mean1 - mean2) / sqrt((sd1^2 + sd2^2) / 2), sig.level = alpha, power = power)
  
  # Print Statistical Power
  print(result)
  
  # Calculate Minimum Required Sample Size and print
  print(result$n)
}

# Call the function
min_sample_size()



ci_diff <- function() {
  sd1 <- sqrt(var_high_temp)
  mean1 <- mean_high_temp
  sd2 <- sqrt(var_low_temp)
  mean2 <- mean_low_temp
  
  t.test(rnorm(sample_size, mean1, sd1), rnorm(sample_size, mean2, sd2), var.equal = TRUE)$conf.int
}





multiple_iterations <- function(num_iterations) {
  results <- list()
  
  for (i in 1:num_iterations) {
    # Generate new data for each iteration
    high_temp_data <- high_temp()
    low_temp_data <- low_temp()
    df <- rbind(high_temp_data, low_temp_data)
    
    # Perform ANOVA and store summary statistics
    anova_result <- aov(development_time ~ group, data = df)
    results[[i]] <- summary(anova_result)
  }
  
  return(results)
}

# Function to print summary statistics from multiple iterations
print_summary_statistics <- function(summary_stats) {
  for (i in 1:length(summary_stats)) {
    cat("Iteration", i, ":\n")
    print(summary_stats[[i]])
  }
}


# Perform multiple iterations of analysis
summary_stats <- multiple_iterations(num_iterations)

# Print summary statistics
print_summary_statistics(summary_stats)
