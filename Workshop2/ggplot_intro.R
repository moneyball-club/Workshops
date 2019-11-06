# Now that you have some knowledge of inspecting the data set, the next step is 
# is to be able to form and display insights from the data. 
# Today we will discussing ggplot 2 which is a great package in R to create 
# visualizations.

# To begin you must first install the package 

install.packages("ggplot2")
library(ggplot2)

# Today we will be using a NBA data.The data set contains two decades of data on each player who has been 
# part of a team's roster. It captures demographic variables such as 
# age, height, weight and place of birth, biographical details like the team played for, draft year and round. 
# In addition, it has basic box score statistics such as  games played, average number of points, rebounds, assists, etc.

nba_dat = read.csv("all_seasons.csv")

# First goal is to inspect the data and see what's included in it 

summary(nba_dat) # This lets us the different columns, and its summary statistcs.

# To see  the data better you can look at a couple rows of the data
# The in game stats in the data set such as pts,rebs,...etc. are the player's averages for that season 
nba_dat[1:5,]


# Or you can look at the whole table, which I personally like doing 
View(nba_dat)

# After looking at the data, the goal is to think of questions, that could be answered through the data 
# Next, you want to use visualizations to display your analysis.


# Question one: Is there any relation between height and weights of NBA players?

# Layer one: Data 

ggplot(nba_dat)

# Layer two: GEOM-etry, every graph name will always begin with geom 

ggplot(nba_dat) + geom_point()

# Layer three: Aesthetics, these are what connects the data to the geom (graph)

ggplot(nba_dat) + geom_point(aes(x = usg_pct, y = pts)) 

# Layer 4: Adding labels to the plot 

ggplot(nba_dat) + geom_point(aes(x = usg_pct, y = pts)) + 
  labs(title = "Usage Percentage vs. Points Scored", x = "Usage Percentage Averaged per game", 
       y = "Points Averaged per game")

# Results: Well the graph shows us what we expects with a few amount of rare cases. For the most part we see
# that players with higher avg. ppg tend to have a higher avg. usage rate.

# Question Two: How have heights of players changed over time?

# When looking at questions that examine over-time, we usually aggregate the data.
# For example, in this question to answer the question we can look at the average height of NBA players 
# by year. 


# To answer this we will make a bar chart, and there will be some extra layers

ggplot(nba_dat) + geom_bar(aes(x = season, y = player_height), stat ="summary", fun.y = "mean")

# Within this plot we see two new things, one is stat. Bar plots in ggplot 2 have a default y-value being the count of 
# of the x variable, so stat = "summary" lets r know that for this barplot we are gonna use our custom y value which 
# instead of the counts is going to a summary statistc function. In our case, the summary statistc we will use would be 
# average. Now lets make our graph look a little more appealing. 

# Here we will add the labeling, but using the fill argument within the aesthetics we can also give our 
# Barplot some color 
ggplot(nba_dat) + 
  geom_bar(aes(x = season, y = player_height, fill = season), stat ="summary", fun.y = "mean") +
  labs(title = "Height in the NBA throughought the years", y = "avg. height") 

# As you may notice, the x-axis may look un-neat due to the clustering and over-lapping of thw words. 
# In that case we can use coord_flip() which will reverse the x and y axis

ggplot(nba_dat) + 
  geom_bar(aes(x = season, y = player_height, fill = season), stat ="summary", fun.y = "mean") +
  labs(title = "Height in the NBA throughought the years", y = "avg. height") + coord_flip()

# It is seen, that throughout the years, the average height in the league has tended to stay the same 


# Example Three: there will be a lot of times when we want to plot data for one specific element. In this case 
# I only want to look at how Tracy Mcgrady did throughout his career?

# Step one would be to subset the data to only get T-mac data

tmac_dat = subset(nba_dat, player_name == "Tracy McGrady")
head(tmac_dat)

# Step two: Lets find a way to graph this. Since we are only dealing with one player, and want to see how they
# did throughout their career a line plot would be best applicable. 

ggplot(tmac_dat) + geom_line(aes(x = season, y = pts, color = "red"), group = 1) 

# This graph only shows us points, however in ggplot we can graph multiple line plots in 
# one graph, for instance i can also add assists 

ggplot(tmac_dat) + geom_line(aes(x = season, y = pts, color = "red"), group = 1) + 
  geom_line(aes(x = season, y = ast, color = "blue"), group = 1)

# Additionally, I can now edit the contents of the legend using scale_colour_manual  
ggplot(tmac_dat) + geom_line(aes(x = season, y = pts, color = "red"), group = 1) + 
  geom_line(aes(x = season, y = ast, color = "blue"), group = 1) + 
  labs(title = "Tmac's career", y = "Value") +
  scale_colour_manual(
    name = "Category", labels =c("Assists",  "Points"), values = c("blue","red"))


# Additional notes about ggplot:

# One: there are many different graphs you could form and different visuals
# using ggplot, these are just some of the common ones

# Two: there is different syntax you can use when for example I could do 

ggplot(tmac_dat, aes(x = season, y = pts)) + geom_line(aes(group = 1, color = "red")) + 
  geom_line(aes(y = ast, group = 1, color = "blue"))

# Or 

ggplot() + geom_line(data = tmac_dat, aes(x = season, y = pts, color = "red"), group = 1) +
  geom_line(data = tmac_dat, aes(x = season, y = ast, color = "blue"), group = 1)

# This one is effective to use when trying to create a line plot of two different data sets
# and plotting it on the same graph. 

# Three: When decding what graph to use think of the amount of and type of variables you have



# Challenge: 

# Problem 1: Create a line graph of the points of two different players and plot them on
# the same graph 

# For the next two questions, examine the data set and come up with your own question to 
# solve them 
  


                             
