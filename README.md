vimeo-uploader
==============

Easily upload your video files to vimeo


Using
-----

Set the consumers key and secret and access token and secret.

    $consumer_key = ''
    $consumer_secret = ''
    $access_token = ''
    $access_secret = ''

Set your credentials to send email after any uploads

    smtp.start('gmail.com', 'login@domain.com', 'MYSECUREPASS', :login)
    smtp.send_message msg, 'sender@domain.com', to
    
Insert the path where your video files are.

    $dir = "/path/for/video/files"
    
By default the script find for mp4 files into your set folder.
