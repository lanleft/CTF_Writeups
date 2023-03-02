export SCUDO_OPTIONS="thread_local_quarantine_size_kb=64:quarantine_size_kb=256:quarantine_max_chunk_size=2048"
export LD_PRELOAD="./libscudo.so"
./wizards_diary
