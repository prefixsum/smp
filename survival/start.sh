#!/bin/bash

memory="6144"
server="paper-1.21.3-81.jar"

echo "======= Minecraft Server ======="
echo "Server binary: "$server
echo "Allocated RAM: "$memory"MiB"
echo "Initialising Minecraft server..."
echo "--------------------------------"

echo "eula=true" > eula.txt

if [ -e $server ]
then 
    echo "Found binary: "$server
    minimumsize=128000
    actualsize=$(wc -c <"$server")
    if [ $actualsize -lt $minimumsize ]
    then
        echo $server" does not appear to be a valid binary."
    else
        echo "Launching Minecraft server..."
        java -Xms"$memory"M -Xmx"$memory"M -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar "$server" nogui
    fi
else
    echo "Could not find: "$server
fi
