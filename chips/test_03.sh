part_a=(Bit Register RAM8 RAM64 PC)
part_b=(RAM4K RAM16K RAM512)

echo "Part A"
for i in "${part_a[@]}"
do
  echo '  '  $i
  echo '    ' `../../tools/HardwareSimulator.sh $i.tst`
done

echo "Part B"
for i in "${part_b[@]}"
do
  echo '  '  $i
  echo '    ' `../../tools/HardwareSimulator.sh $i.tst`
done
