Public Class Form2
    Public debugString As String = ""

    Public Sub WriteLine(ByVal text As String)
        debugString = debugString & text & vbNewLine
    End Sub

    Private Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick
        If debugString.Length > 0 Then
            TextBox1.Text = TextBox1.Text & debugString
            debugString = ""
            TextBox1.SelectionStart = TextBox1.Text.Length
            TextBox1.ScrollToCaret()
        End If
    End Sub
End Class