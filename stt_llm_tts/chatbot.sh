./stt/build/bin/whisper-cli -m stt/models/ggml-base.en.bin -f $1 > stt_output.txt

sed -E 's/\[[0-9:.]+ --> [0-9:.]+\] //g' stt_output.txt | sed '/^$/d' > clean_output.txt

./llm/build/bin/llama-cli -m llama/models/tiny* -file cleanoutput.txt > llm_output.txt

espeak-ng -f chat_output.txt -w chat_output.wav

echo "Output saved to chat_output.wav