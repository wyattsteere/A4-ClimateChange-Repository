library(ggplot2)
library(plotly)
library(dplyr)

climate_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)


server <- function(input, output) {
  
  output$co2_table_1970 <- renderDataTable({
    highest_co2_emissions_percapita_post1970  <- climate_df %>% 
      group_by(year) %>% 
      filter(year >= "1970") %>%
      filter(co2_per_capita == max(co2_per_capita,na.rm = T)) 
    
    co2_post1970 <- highest_co2_emissions_percapita_post1970[,c(2,3,5)]
    
    
    return(co2_post1970)
    })
  
  output$climate_plot <- renderPlotly({
   
    filtered_df <- climate_df %>% 
      filter(country %in% input$user_selection) %>% 
      filter(year >= input$year_selection[1] & year <= input$year_selection[2])
    
    co2_plot <- ggplot(data = filtered_df) +
     geom_line(mapping = aes(x = year, y = co2, color = country))
    ggplotly(co2_plot)
 
    
    return(co2_plot)
  })
  
  output$sint_maarten_plot <- renderPlotly({
    sint_maarten <- climate_df %>% 
      filter(country == "Sint Maarten (Dutch part)")
    co2_plot_sint_Maarten <- ggplot(data = sint_maarten) +
      geom_point(mapping = aes(x = year, y = co2_per_capita, color = "Red")) +
      geom_line(mapping = aes(x = year, y = co2_per_capita, color = "Red")) 
    
    
    return(co2_plot_sint_Maarten)
  })
  
}