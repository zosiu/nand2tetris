# Memory CPU computer
echo "CPU"
  echo '  ' `../../tools/HardwareSimulator.sh CPU.tst`
  echo '  ' `../../tools/HardwareSimulator.sh CPU-external.tst`

echo "Computer"
  `mv RAM16K.hdl RAM16K_.hdl`
  echo '  ' `../../tools/HardwareSimulator.sh ComputerAdd-external.tst`
  echo '  ' `../../tools/HardwareSimulator.sh ComputerMax-external.tst`
  echo '  ' `../../tools/HardwareSimulator.sh ComputerRect-external.tst`
  `mv RAM16K_.hdl RAM16K.hdl`
