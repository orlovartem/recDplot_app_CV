library(shiny)
library(DT)
library(shinyjs)
library(shinycssloaders)
library(shinythemes)
source("scripts/rec_plots.R")

options(shiny.maxRequestSize = 40*1024^2)


server <- function(input, output) {

# GO BUTTONS FOR FIGURES FROM PAPER
  
  observeEvent(input$js.button_clicked, {
    
    uid = strsplit(input$js.button_clicked, "_")
    print(input$js.button_clicked)
    print(uid)
    button = uid[[1]][1]
    chs = strsplit(button, "-")
    print(chs)
    genus = chs[[1]][1]
    region = chs[[1]][2]
    print(genus)
    if (genus == "SaV"){
      aln_fig = read.dna(as.character("data/sapovirus.fasta"), format="fasta", as.character=TRUE)
      if (region == "NSNS"){
        f = 3
        min1 = 1
        max1 = 2500
        min2 = 2501
        max2 = 5091
      }
      else if (region == "NSVP12"){
        f = 3
        min1 = 1
        max1 = 5091
        min2 = 5092
        max2 = 7191
      }
      else if (region == "VP1VP2"){
        f = 3
        min1 = 5092
        max1 = 6711
        min2 = 6712
        max2 = 7191
      }
    }
    else if (genus == "NoV"){
      aln_fig = read.dna(as.character("data/norovirus.fasta"), format="fasta", as.character=TRUE)
      if (region == "NSNS"){
        f = 3
        min1 = 1
        max1 = 2541
        min2 = 2542
        max2 = 5082
      }
      else if (region == "NSVP12"){
        f = 3
        min1 = 1
        max1 = 5082
        min2 = 5083
        max2 = 7431
      }
      else if (region == "VP1VP2"){
        f = 3
        min1 = 5083
        max1 = 6687
        min2 = 6688
        max2 = 7431
      }
    }
    else if (genus == "NoVg2less"){
      aln_fig = read.dna(as.character("data/norovirus_g2less.fasta"), format="fasta", as.character=TRUE)
      if (region == "NSNS"){
        f = 3
        min1 = 1
        max1 = 2541
        min2 = 2542
        max2 = 5082
      }
      else if (region == "NSVP12"){
        f = 3
        min1 = 1
        max1 = 5082
        min2 = 5083
        max2 = 7431
      }
      else if (region == "VP1VP2"){
        f = 3
        min1 = 5083
        max1 = 6687
        min2 = 6688
        max2 = 7431
      }
    }
    aln_fig[aln_fig=='-'] <- NA

    #l_fig = plot_dist_test(aln_fig, min1,max1,min2,max2)
    #df = l_fig[[2]]
    
    if (f==3){
      withProgress(message = 'Creating distance plots', value = 0, {
        
        aln_control =  cbind(aln_fig[,min1:max1], aln_fig[,min2:max2])
        output$fig3_control <- renderPlot({
          plot_control(aln_control)
        })
        incProgress(0.4, detail = "Control plot finished")
        Sys.sleep(0.5)
        
        l_fig = plot_dist_test(aln_fig, min1,max1,min2,max2)
        df = l_fig[[2]]
        incProgress(0.4, detail = "Distance plot finished")
        Sys.sleep(0.5)
        
        output$fig3_plot <- renderPlot(l_fig[[1]])
        
        
        observeEvent(input$fig3_brush, {
          brushed_points3 <- brushedPoints(df, input$fig3_brush)
          min_1 = input$fig3_brush$xmin
          max_1 = input$fig3_brush$xmax
          
          min_2 = input$fig3_brush$ymin
          max_2 = input$fig3_brush$ymax
          output$min_max <- DT::renderDataTable(brushed_points3)
          
          output$fig3_brush_info <- DT::renderDataTable({
            find_recomb_names(l_fig[[3]], min_1, max_1, l_fig[[4]], min_2, max_2)
          },extensions = 'Buttons',
          options = list(pageLength = 20, dom = 'Blfrtip', buttons = c('copy', 'csv'))
          )
        })
        incProgress(0.2, detail = "Creating plots")
      })
      
    }
  }
  )
  
}
