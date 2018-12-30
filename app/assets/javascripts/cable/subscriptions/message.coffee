ready = ->

  if $('#profile').length
    App.cable.subscriptions.create { channel: "ApplicationCable::ProfilesChannel", id: $('#profile').data('id') },
      received: (data) ->
        @prependLine(data)
        $.growl.notice({ title: "New Message!", message: "New message has arrived" })
     
      prependLine: (data) ->
        html = @createLine(data)
        div_id = "#message-#{data.id}"
        if !($(div_id).length)
          $("#messages-list").prepend(html)
     
      createLine: (data) ->        
        # parse ISO8601 date and format for display
        dtstr = data.created_at 
        dtstr = dtstr.replace(/\D/g," ")
        dtcomps = dtstr.split(" ")
        # JS months are zero indexed, IS08601 aren't...
        dtcomps[1]--;
        convdt = new Date(Date.UTC(dtcomps[0],dtcomps[1],dtcomps[2],dtcomps[3],dtcomps[4],dtcomps[5]))
        date_string = convdt.toLocaleDateString("en-GB")
        # extract the time
        time = convdt.toTimeString()
        time_string = time.split(' ')[0].slice(0, -3)

        from_string = new String(data.from)
        from_string = from_string.replace('<', '&lt;')
        from_string = from_string.replace('>', '&gt;')

        """
        <li id="message-#{data.id}" class="list-group-item message" data-envelope='#{data.envelope}'>
          <a href="/messages/#{data.id}">
            <div class="row">
              <div class="col-sm-12 col-md-6 p-2">
                #{data.subject}
              </div>
              <div class="col-md-3 d-none d-md-block">
                #{from_string}
              </div>
              <div class="col-md-3 d-none d-md-block">
                #{time_string} #{date_string}
              </div>
            </div>
          </a>
        </li>
        """

$(document).on 'turbolinks:load', ready