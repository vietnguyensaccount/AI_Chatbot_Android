#!/bin/bash

# Step 1: Record input from microphone using alsa-utils
./record/arecord -D plughw:0,0 -f cd -t wav -d 10 input.wav

# Step 2: Run Whisper for speech-to-text
./stt/build/bin/whisper-cli -m stt/models/ggml-base.en.bin -f input.wav > stt_output.txt

# Step 3: Clean up the output
sed -E 's/\[[0-9:.]+ --> [0-9:.]+\] //g' stt_output.txt | sed '/^$/d' > clean_output.txt

# Step 4: Run LLaMA for response generation
./llm/build/bin/llama-cli -m llama/models/tiny* -file clean_output.txt > llm_output.txt

# Step 5: Generate speech from the response
espeak-ng -f llm_output.txt -w chat_output.wav

# Step 6: Play the response using alsa-play
./play/aplay chat_output.wav

echo "Voice Chatbot Answered. Response saved to chat_output.wav."
