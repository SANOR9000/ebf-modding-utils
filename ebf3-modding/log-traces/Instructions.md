# How set up logs
1. Go to https://web.archive.org/web/20220401020702/https://www.adobe.com/support/flashplayer/debug_downloads.html and get the Flash "Player projector content debugger"
2. While the download downloads at 2 kbs per year, create a file with this:
    ```
    ErrorReportingEnable=1
    TraceOutputFileEnable=1
    ```
    then save it as ``mm.cfg`` and place it at ``%USERPROFILE%`` aka ``C:\Users\YourUsernameHere``
3. Run whichever .swf you'd like with the new Flashplayer you downloaded. Logs are saved at ``%APPDATA%\Macromedia\Flash Player\Logs``
Kupo already sprayed a million ``trace()``s on the code so make sure to add some text at the start of your new traces so you can use Ctrl + F to find them

# View log updates live
Run ``Watch Log.ps1``