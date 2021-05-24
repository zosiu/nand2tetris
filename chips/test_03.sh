part_a=(Bit Register RAM8 RAM64 PC)
part_b=(RAM512 RAM4K RAM16K)

echo "Part A"
for i in "${part_a[@]}"
do
  echo '  '  $i
  echo '    ' `../../tools/HardwareSimulator.sh $i.tst`
done


`mv RAM64.hdl RAM64_.hdl`
echo "Part B"
for i in "${part_b[@]}"
do
  echo '  '  $i
  echo '    ' `../../tools/HardwareSimulator.sh $i.tst`
done
`mv RAM64_.hdl RAM64.hdl`
