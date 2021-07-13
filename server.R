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
    #print(uid)
    button = uid[[1]][1]
    chs = strsplit(button, "-")
    print(chs)
    genus = chs[[1]][1]
    region = chs[[1]][2]
    print(genus)
    if (genus == "SaV"){
      aln_fig = read.dna(as.character("data/sapovirus.fasta"), format="fasta", as.character=TRUE)
      if (region == "NS_NS"){
        f = 3
        min1 = 1
        max1 = 2500
        min2 = 2501
        max2 = 5091
      }
      else if (region == "NS_VP12"){
        f = 3
        min1 = 1
        max1 = 5091
        min2 = 5092
        max2 = 7191
      }
      else if (region == "VP1_VP2"){
        f = 3
        min1 = 5092
        max1 = 6711
        min2 = 6712
        max2 = 7191
      }
    }
    else if (genus == "NoV"){
      aln_fig = read.dna(as.character("data/norovirus.fasta"), format="fasta", as.character=TRUE)
      if (region == "NS_NS"){
        f = 3
        min1 = 1
        max1 = 11484
        min2 = 11485
        max2 = 19398
      }
      else if (region == "NS_VP12"){
        f = 3
        min1 = 1
        max1 = 19398
        min2 = 19399
        max2 = 22746
      }
      else if (region == "VP1_VP2"){
        f = 3
        min1 = 19468
        max1 = 21060
        min2 = 21061
        max2 = 22743
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
    if (f==4){
      withProgress(message = 'Creating distance plots', value = 0, {
      
        aln_control =  cbind(aln_fig[,min1:max1], aln_fig[,min2:max2])
        output$fig4_control <- renderPlot({
          plot_control(aln_control)
        })
        incProgress(0.4, detail = "Control plot finished")
        Sys.sleep(0.5)
        
        l_fig = plot_dist_test(aln_fig, min1,max1,min2,max2)
        df = l_fig[[2]]
        incProgress(0.4, detail = "Distance plot finished")
        Sys.sleep(0.5)
        
        output$fig4_plot <- renderPlot(l_fig[[1]])
        observeEvent(input$fig4_brush, {
          brushed_points4 <- brushedPoints(df, input$fig4_brush)
          min_1 = input$fig4_brush$xmin
          max_1 = input$fig4_brush$xmax
          
          min_2 = input$fig4_brush$ymin
          max_2 = input$fig4_brush$ymax
          output$min_max <- DT::renderDataTable(brushed_points4)
          
          output$fig4_brush_info <- DT::renderDataTable({
            find_recomb_names(l_fig[[3]], min_1, max_1, l_fig[[4]], min_2, max_2)
          }, extensions = 'Buttons',
          options = list(pageLength = 20, dom = 'Blfrtip', buttons = c('copy', 'csv'))
          )
        })
        incProgress(0.2, detail = "Creating plots")
      })
    }
    if (f==5){
      withProgress(message = 'Creating distance plots', value = 0, {
        
        aln_control =  cbind(aln_fig[,min1:max1], aln_fig[,min2:max2])
        output$fig5_control <- renderPlot({
          plot_control(aln_control)
        })
        incProgress(0.4, detail = "Control plot finished")
        Sys.sleep(0.5)
        
        l_fig = plot_dist_test(aln_fig, min1,max1,min2,max2)
        df = l_fig[[2]]
        incProgress(0.4, detail = "Distance plot finished")
        Sys.sleep(0.5)
        
        output$fig5_plot <- renderPlot(l_fig[[1]])
        observeEvent(input$fig5_brush, {
          brushed_points5 <- brushedPoints(df, input$fig5_brush)
          min_1 = input$fig5_brush$xmin
          max_1 = input$fig5_brush$xmax
          
          min_2 = input$fig5_brush$ymin
          max_2 = input$fig5_brush$ymax
          output$min_max <- DT::renderDataTable(brushed_points5)
          
          output$fig5_brush_info <- DT::renderDataTable({
            find_recomb_names(l_fig[[3]], min_1, max_1, l_fig[[4]], min_2, max_2)
          }, extensions = 'Buttons',
          options = list(pageLength = 20, dom = 'Blfrtip', buttons = c('copy', 'csv'))
          )
        })
        incProgress(0.2, detail = "Creating plots")
      })
    }
  }
  )
  
}
