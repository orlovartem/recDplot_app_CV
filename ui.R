# Define UI for application
ui <- navbarPage(
        "Exploring recombination in genetic sequences using distance plots",
         theme = "styles.css",

#------------------FIGURES FROM PAPER TAB
        tabPanel("Figures",
                 
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
                       actionButton(inputId = "SaV-NSNS-button", label = NULL, class="fig_button", style = "width: 140px; height: 110px;
                            background: url('img/SaV_NS-NS.png');  background-size: cover; background-position: center;"),
                       actionButton(inputId = "SaV-NSVP12-button", label = NULL, class="fig_button", style = "width: 140px; height: 110px;
                            background: url('img/SaV_NS-VP12.png');  background-size: cover; background-position: center;"),
                       actionButton(inputId = "SaV-VP1VP2-button", label = NULL, class="fig_button", style = "width: 140px; height: 110px;
                            background: url('img/SaV_VP1-VP2.png');  background-size: cover; background-position: center;"),
                     ),
                     fluidRow(
                       h5("Norovirus"),
                       actionButton(inputId = "NoV-NSNS-button", label = NULL, class="fig_button", style = "width: 140px; height: 110px;
                            background: url('img/NoV_NS-NS.png');  background-size: cover; background-position: center;"),
                       actionButton(inputId = "NoV-NSVP12-button", label = NULL, class="fig_button", style = "width: 140px; height: 110px;
                            background: url('img/NoV_NS-VP12.png');  background-size: cover; background-position: center;"),
                       actionButton(inputId = "NoV-VP1VP2-button", label = NULL, class="fig_button", style = "width: 140px; height: 110px;
                            background: url('img/NoV_VP1-VP2.png');  background-size: cover; background-position: center;"),
                     ),
                     fluidRow(
                       h5("Norovirus without GII"),
                       actionButton(inputId = "NoVg2less-NSNS-button", label = NULL, class="fig_button", style = "width: 140px; height: 110px;
                            background: url('img/NoV-g2less_NS-NS.png');  background-size: cover; background-position: center;"),
                       actionButton(inputId = "NoVg2less-NSVP12-button", label = NULL, class="fig_button", style = "width: 140px; height: 110px;
                            background: url('img/NoV-g2less_NS-VP12.png');  background-size: cover; background-position: center;"),
                       actionButton(inputId = "NoVg2less-VP1VP2-button", label = NULL, class="fig_button", style = "width: 140px; height: 110px;
                            background: url('img/NoV-g2less_VP1-VP2.png');  background-size: cover; background-position: center;"),
                       
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
