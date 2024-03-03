# Create a dataframe where only "am = 0" is present
auto <- subset(mtcars, am == 0)

# Remove the variable "am = 0"
auto <- auto[,-9]

# Create a dataframe where only "am = 1" is present
manual <- subset(mtcars, am == 1)

# Remove the variable "am = 1"
manual <- manual[,-9]

# Create a list with the two groups of cars
groups <- list(auto, manual)

# Print groups
print(groups)

# Load ggplot2 package
library(ggplot2)

# Transform the output matrix in a data-frame
output_df <- as.data.frame(cmahalanobis(groups))

# Add a column with the names of typology of cars
output_df$Type <- rownames(output_df)

# Change the shape of the dataframe from large to long
output_df_long <- reshape2::melt(output_df, id.vars = "Type")

# Rename columns
colnames(output_df_long) <- c("Type", "Comparision", "Distance")

# Create the plot
ggplot(output_df_long, aes(x = Type, y = Distance,
                           fill = Comparision)) + geom_bar(stat = "identity", position = "dodge") + labs(title = "Mahalanobis distance between car typologies", x = "Typology", y = "Distance", fill = "Comparision") + theme_minimal()


