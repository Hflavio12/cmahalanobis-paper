# Create a list of dataframes for each species
iris_list <- split(iris, iris$Species)

# Print the list
print(iris_list)

# Store into "res" the result of "cmahalanobis" applied to "iris list"
res <- cmahalanobis(iris_list)

# Print "res" 
print(res)

# Load the ggplot2 package
library(ggplot2)

# Transform the output matrix into a data frame
output_df <- as.data.frame(cmahalanobis(iris_list))

# Add a column with the species names
output_df$Species <- rownames(output_df)

# Reshape the data frame from wide to long format
output_df_long <- reshape2::melt(output_df, id.vars = "Species")

# Rename the columns
colnames(output_df_long) <- c("Species", "Comparison", "Distance")

# Create a bar plot with ggplot2
ggplot(output_df_long, aes(x = Species, y = Distance, fill = Comparison)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Mahalanobis distance between iris species", x = "Species",
       y = "Distance", fill = "Comparison") + theme_minimal()
