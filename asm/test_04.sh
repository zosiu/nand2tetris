programs=("fill/Fill" "mult/Mult")

echo "mult"
echo '  ' `../../tools/Assembler.sh mult/Mult.asm`
echo '  ' `../../tools/CPUEmulator.sh mult/Mult.tst`

echo "fill"
echo '  ' `../../tools/Assembler.sh fill/Fill.asm`
echo '  ' `../../tools/CPUEmulator.sh fill/FillAutomatic.tst`
