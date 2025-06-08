#!/bin/bash

# waits for background init to finish

rm "$0"

clear

echo "⏳ Please wait while your environment is being prepared..."
while [ ! -f /ks/.k8sfinished ]; do
    echo -n '.'
    sleep 1;
done;
echo " done"

echo "✅ Environment is ready! You can now proceed with the scenario."
echo 