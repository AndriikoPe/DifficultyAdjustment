# Type a script or drag a script file from your workspace to insert its path.
#!/bin/bash

./ngrok http 5000 --log=stdout > /dev/null &
sleep 5
ngrok_url=$(curl -s localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')

echo $ngrok_url > ./DifficultyAdjustment/RealAgent/UrlFile
