SERVER = if LOCAL then "http://localhost" else "http://50.116.7.184"

window.socket = socket = io.connect SERVER

$(document).ready ->
    $('#frisbee-button').click ->
        socket.emit 'frisbee', {lat: 5, lng: 5}
        
    navigator.geolocation.getCurrentPosition (position) ->
        console.log(position.coords.latitude, position.coords.longitude)
        socket.emit 'id', {lat: position.coords.latitude, lng: position.coords.longitude, name: 'test'}
        
    # TODO: Handle denials, in the case of denial, just fail
    
socket.on 'frisbee', (data) ->
    {type, content} = data
    switch type
        when "url"
            $("body").append $("<iframe src='#{content}'></iframe>")
            # window.open('')
        when "youtube"
            $("body").append $("""<iframe width='420' height='315'
                                  src='http://www.youtube.com/embed/#{content}'
                                  frameborder='0' autoplay=true allowfullscreen></iframe>""")
        when "image"
            $("body").append $("<img src='#{content}'></img>")
        when "spotify"
            document.location = "spotify:track:#{content}"
        else
            alert("Unknown")
