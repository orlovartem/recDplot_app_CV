# Define UI for application
ui <- navbarPage(
        "Exploring recombination in genetic sequences using distance plots",
         theme = "styles.css",

#------------------FIGURES FROM PAPER TAB
        tabPanel("Figures from paper",
                 
                 tags$head(tags$script(HTML("$(document).on('click', '.fig_button', function (e) {
                                e.stopPropagation()
                                if (typeof BUTTON_CLICK_COUNT == 'undefined') {
                                  BUTTON_CLICK_COUNT = 1; 
                                } else {
                                  BUTTON_CLICK_COUNT ++;
                                }
                                Shiny.onInputChange('js.button_clicked', 
                                  e.target.id + '_' + BUTTON_CLICK_COUNT);
                             });"))),
                 sidebarLayout(
                   sidebarPanel(
                     h4("Click the figures below to reproduce the plots. Select the dots on the distance plot to show the virus pairs that correspond to them."),
                     fluidRow(
                       h5("Sapovirus"),
                       actionButton(inputId = "SaV-NS_NS-button", label = NULL, class="fig-button", style = "width: 140px; height: 110px;
                            background: url('img/1.png');  background-size: cover; background-position: center;"),
                       actionButton(inputId = "SaV-NS_VP12-button", label = NULL, class="fig-button", style = "width: 140px; height: 110px;
                            background: url('img/1.png');  background-size: cover; background-position: center;"),
                       actionButton(inputId = "SaV-VP1_VP2-button", label = NULL, class="fig-button", style = "width: 140px; height: 110px;
                            background: url('img/1.png');  background-size: cover; background-position: center;"),
                       ),
                     fluidRow(
                       h5("Norovirus"),
                       actionButton(inputId = "NoV-NS_NS-button", label = NULL, class="fig-button", style = "width: 140px; height: 110px;
                            background: url('img/1.png');  background-size: cover; background-position: center;"),
                       actionButton(inputId = "NoV-NS_VP12-button", label = NULL, class="fig-button", style = "width: 140px; height: 110px;
                            background: url('img/1.png');  background-size: cover; background-position: center;"),
                       actionButton(inputId = "NoV-VP1_VP2-button", label = NULL, class="fig-button", style = "width: 140px; height: 110px;
                            background: url('img/1.png');  background-size: cover; background-position: center;"),
                       
                     ),
                      
                   ),
                   mainPanel(
                     width = 6,
                     fluidRow(
                       
                       splitLayout(
                         cellWidths = 450, 
                         tagList(h4("Control plot"), plotOutput("fig3_control",
                         )
                         ),

                         tagList(h4("Distance plot"), plotOutput("fig3_plot",
                                                                 brush = brushOpts(id = "fig3_brush"),
                                                                 click = clickOpts(id = "fig3_click")
                         )
                         )
                       )
                     ),
                     fluidRow(
                       #verbatimTextOutput("mm"),
                       #DT::dataTableOutput("min_max"),
                       DT::dataTableOutput("fig3_brush_info")
                     )
                   )
                   
                   
                   
                 ),
        )
)
