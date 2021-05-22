elementary_gates=(Not And Or Xor Mux DMux)
variants_16_bit=(Not16 And16 Or16 Mux16)
variants_multi_way=(Or4Way Or8Way Mux4Way16 Mux8Way16 DMux4Way DMux8Way)

echo "ELementary logic gates"
for i in "${elementary_gates[@]}"
do
  echo '  '  $i
  echo '    ' `../../tools/HardwareSimulator.sh $i.tst`
done

echo "16-bit variants"
for i in "${variants_16_bit[@]}"
do
  echo '  '  $i
  echo '    ' `../../tools/HardwareSimulator.sh $i.tst`
done

echo "Multi-way variants"
for i in "${variants_multi_way[@]}"
do
  echo '  '  $i
  echo '    ' `../../tools/HardwareSimulator.sh $i.tst`
done
