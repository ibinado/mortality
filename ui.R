library(shiny)

# A modal dialog overlaying the whole page with a brief explanation of what
# the application is about.
infoDialog <- function() {
  HTML('
    <script>
    </script>
    <div id="info-dialog" class="modal fade">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Usage</h4>
          </div>
          <div class="modal-body">
            <p>After filling in demografic information and outlook
               timeframe of interest, the predictor will display the
               expected mortality rate over the selected time period.
            </p>
            <p>Mortality rates are based on information from the
               <a href="http://wonder.cdc.gov/wonder/help/ucd.html" target="_blank">
               CDC WONDER Online Database</a> for the year 2013.
            </p>
            <p>Mortality predictions beyond 85 years of age assume the
               mortality rate to stay constant beyond 85 years of age
               and are thus underestimated.
            </p>
       </p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default"
                    data-dismiss="modal">
              Close
            </button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
  ')
}

# A button to show the infoDialog.
infoButton <- function() {
  HTML('
    <button type="button" class="btn btn-primary btn-lg" data-toggle="modal"
           data-target="#info-dialog">
     Explanation
    </button>
  ')
}

shinyUI(fluidPage(
  infoDialog(),
  titlePanel('US Mortality Predictor'),
  sidebarLayout(
    sidebarPanel(
      h3('Demographics'),
      sliderInput('age', 'Current Age', min = 0, max = 80, value = 20,
                   step = 1, post = ' years'),
      radioButtons('gender', 'Gender',
                   c('Male',
                     'Female',
                     'Not sure' = ''),
                   selected = ''),
      radioButtons('race', 'Race',
                   c('American Indian or Alaska Native',
                     'Asian or Pacific Islander',
                     'Black or African American',
                     'White',
                     'Prefer not to answer' = ''),
                   selected = ''),
      sliderInput('outlook', 'Outlook', min = 1, max = 80, value = 10,
                   step = 1, post = ' years')
    ),
    mainPanel(
      div(class = 'panel panel-info',
        style = 'display: inline-block',
        div(class = 'panel-heading',
          h3('Prediction')
        ),
        div(class = 'panel-body',
          style = paste(sep = ';',
            'text-align: center',
            'font-size: 150%',
            'line-height: 1.1'
          ),
          'There is a', br(),
          textOutput('mortality', inline = TRUE), '% probability',
          'to die', br(),
          'between',
          textOutput('start.age', inline = TRUE),
          'and',
          textOutput('end.age', inline = TRUE),
          'years of age.'),
        div(class = 'panel-footer',
        'Prediction based on',
          a(href = 'http://wonder.cdc.gov/wonder/help/ucd.html', target = '_blank',
            'CDC WONDER Online Database'),
        '2013 mortality rates.')
      ),
      div(),  # Clears the mainPanel float above to move infoButton below.
      infoButton()
    )
  )
))
