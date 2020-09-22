Attribute VB_Name = "modNN"
Option Explicit

Private Net As cNN
Private myInput As Variant, myOutPut As Variant
Private i

Sub Main()
  'NN Without Momentum
  Randomize 12345
  Set Net = New cNN
  Net.ConstructNN Array(2, 7, 5)
  Net.MomentumFactor = 0
  Call TrainNN
  Debug.Print "Standard NN:"
  Call ShowNNOutput
  
  'NN With Momentum
  Set Net = Nothing
  Randomize 12345
  Set Net = New cNN
  Net.ConstructNN Array(2, 7, 5)
  Call TrainNN
  Debug.Print "Momentum NN:"
  Call ShowNNOutput
End Sub

Private Sub TrainNN()
  For i = 1 To 500
    'Randomly set input. Calculate the expected output. Then train.
    DoEvents
    'Output compares input: Xor, And, Or, <, >
    myInput = Array(Int(Rnd + 0.5), Int(Rnd + 0.5))
    myOutPut = Array(myInput(0) Xor myInput(1), _
                     myInput(0) And myInput(1), _
                     myInput(0) Or myInput(1), _
                     Abs(myInput(0) > myInput(1)), _
                     Abs(myInput(0) < myInput(1)) _
                  )
    Net.SetInput myInput
    Net.Refresh
    Net.Train myOutPut
  Next
End Sub

Private Sub ShowNNOutput()
  Debug.Print "      ", "Xor ", "And ", "Or  ", ">   ", "<   "
  Net.SetInput (Array(0, 0)): Net.Refresh: Debug.Print "(0, 0)", Format(Net.GetOutput(1), "0.000"), Format(Net.GetOutput(2), "0.000"), Format(Net.GetOutput(3), "0.000"), Format(Net.GetOutput(4), "0.000"), Format(Net.GetOutput(5), "0.000")
  Net.SetInput (Array(0, 1)): Net.Refresh: Debug.Print "(0, 1)", Format(Net.GetOutput(1), "0.000"), Format(Net.GetOutput(2), "0.000"), Format(Net.GetOutput(3), "0.000"), Format(Net.GetOutput(4), "0.000"), Format(Net.GetOutput(5), "0.000")
  Net.SetInput (Array(1, 0)): Net.Refresh: Debug.Print "(1, 0)", Format(Net.GetOutput(1), "0.000"), Format(Net.GetOutput(2), "0.000"), Format(Net.GetOutput(3), "0.000"), Format(Net.GetOutput(4), "0.000"), Format(Net.GetOutput(5), "0.000")
  Net.SetInput (Array(1, 1)): Net.Refresh: Debug.Print "(1, 1)", Format(Net.GetOutput(1), "0.000"), Format(Net.GetOutput(2), "0.000"), Format(Net.GetOutput(3), "0.000"), Format(Net.GetOutput(4), "0.000"), Format(Net.GetOutput(5), "0.000")
End Sub
