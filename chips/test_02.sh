adders=(HalfAdder FullAdder Add16)
alu=(Inc16 Nor16Way ALU)

echo "Adders"
for i in "${adders[@]}"
do
  echo '  '  $i
  echo '    ' `../../tools/HardwareSimulator.sh $i.tst`
done

echo "ALU"
for i in "${alu[@]}"
do
  echo '  '  $i
  echo '    ' `../../tools/HardwareSimulator.sh $i.tst`
done
