# Load package
library(psych)

# Remove NA in the dataset
bfi <- na.omit(bfi)

# Extract males by the dataset
males <- subset(bfi, gender == "1") 

# Remove males variable
males <- males[,-26]

# Extract females by the dataset
females <- subset(bfi, gender == "2")

# Remove females by the dataset
females <- females[,-26]

# Create a list of dataframes
bfi_gender <- list(males, females)

# Store into res the result of cmahalanobis
res <- cmahalanobis(bfi_gender)

# Print res
res

# Load ggplot2 package
library(ggplot2)

# Transform the output matrix into a data frame
output_df <- as.data.frame(cmahalanobis(bfi_gender))

# Add a column with the gender names
output_df$gender <- rownames(output_df)

# Reshape the data frame from wide to long format
output_df_long <- reshape2::melt(output_df, id.vars = "gender")

# Rename the columns
colnames(output_df_long) <- c("gender", "comparision", "distance")

# Create a bar plot with ggplot2
ggplot(output_df_long, aes(x = gender, y = distance, fill = comparision)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Mahalanobis distance between gender",
       x = "Typology", y = "Distance", fill = "Comparision") +
  theme_minimal()
