Imports System.Threading
Imports System.Net.Sockets
Imports System.IO
Imports System.Net

' http://www.java2s.com/Code/VB/Network-Remote/UDPServerreceivespacketsfromaclientthenechoespacketsbacktoclients.htm

Public Class Form1
    Dim temp
    Dim pingThread As Thread

    Public Delegate Sub DebugWriteLine(ByVal text As String)
    Public ThisWriteLine As DebugWriteLine

    Private Sub Form1_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        MultimediaServer.Disconnect()
    End Sub

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MultimediaServer.Initialize((2 * 60), 10) ' Ping if no communication in 2 minutes, then wait 10 seconds for reply
        MultimediaServer.StartServer(1111, AddressOf ParseData)

        MultimediaServer.DebugAddress(AddressOf Form2.WriteLine)
        ThisWriteLine = AddressOf Form2.WriteLine
        Form2.Show()
    End Sub

    Public Sub ParseData(ByVal CID As Byte, ByVal Command As Byte, ByVal DataLength As Byte, ByVal Data() As Byte)
        Dim TransmitData(1480) As Byte
        Dim ClientSlot As Byte = MultimediaServer.CheckClient(CID)
        If Not (ClientSlot = &HFF) Then
            'ThisWriteLine.Invoke("Client was found.")
            MultimediaServer.UpdateTimestamp(ClientSlot) ' Update timestamp for communication so it will not be pinged the next couple of minutes
            GoTo ClientFound
        Else
            ThisWriteLine.Invoke("Client not found!")
            GoTo ClientNotFound
        End If


ClientNotFound:
        If Command = &H1 Then ' Check communication
            ' Assign client ID (CID)
            Dim NewCID As Byte = MultimediaServer.NewClient(Data(3), Data(2), Data(1), Data(0))
            If Not (NewCID = &HFF) Then
                TransmitData(0) = Data(0)
                TransmitData(1) = Data(1)
                TransmitData(2) = Data(2)
                TransmitData(3) = Data(3)
                TransmitData(4) = NewCID
                MultimediaServer.SendPackage(&HFF, &H2, 5, TransmitData)
                ThisWriteLine.Invoke(" - New client: " & Data(0).ToString("X") & Data(1).ToString("X") & Data(2).ToString("X") & Data(3).ToString("X"))
                ThisWriteLine.Invoke(" - ClientID Assigned: " & NewCID)
            Else
                TransmitData(0) = Data(0)
                TransmitData(1) = Data(1)
                TransmitData(2) = Data(2)
                TransmitData(3) = Data(3)
                TransmitData(4) = &HFF ' Could not be assigned
                MultimediaServer.SendPackage(&HFF, &H2, 5, TransmitData)
                ThisWriteLine.Invoke(" - New client: " & Data(0).ToString("X") & Data(1).ToString("X") & Data(2).ToString("X") & Data(3).ToString("X"))
                ThisWriteLine.Invoke(" - ClientID Assigned: " & NewCID)
                ThisWriteLine.Invoke("ERR_CLIENT: No free slots!")
            End If

        Else
            ThisWriteLine.Invoke(" - Client not assigned, so not allowed to execute commands!")
        End If
        GoTo FinishedParsing


ClientFound:
        Select Case Command
            Case &H41 ' Pong
                If Not DataLength = 0 Then
                    ' Send wrong package size error
                    ThisWriteLine.Invoke("ERR_CMD: Wrong data length")
                    GoTo FinishedParsing
                End If
                Clients(ClientSlot).PingSent = False
                ThisWriteLine.Invoke("Pong received from Client: " & CID)

            Case &H3 ' Request files list
                If Not DataLength = 2 Then
                    ' Send wrong package size error
                    ThisWriteLine.Invoke("ERR_CMD: Wrong data length")
                    GoTo FinishedParsing
                End If
                ThisWriteLine.Invoke("Request files list from Client: " & CID)
                Dim folderNode As TreeNode = FindFolder(Int(Data(0) << 8 Or Data(1)))
                If folderNode Is Nothing Then
                    ' Send error!
                    ThisWriteLine.Invoke("ERR_CMD: Folder ID not found")
                    Clients(ClientSlot).FilesListDirectory = Nothing
                    Clients(ClientSlot).FilesListCount = 0
                ElseIf folderNode.Nodes.Count > 255 Then
                    ' Send error!
                    ThisWriteLine.Invoke("ERR_CMD: Too many items to write (byte overflow)")
                    Clients(ClientSlot).FilesListDirectory = Nothing
                    Clients(ClientSlot).FilesListCount = 0
                Else
                    Clients(ClientSlot).FilesListDirectory = folderNode
                    Clients(ClientSlot).FilesListCount = folderNode.Nodes.Count

                    TransmitData(0) = Data(0)
                    TransmitData(1) = Data(1)
                    TransmitData(2) = folderNode.Nodes.Count
                    MultimediaServer.SendPackage(CID, &H4, 3, TransmitData)
                    ThisWriteLine.Invoke(" -> REPLY: Sent")
                End If

            Case &H5 ' Request files list package
                If Not DataLength = 3 Then
                    ' Send wrong package size error
                    ThisWriteLine.Invoke("ERR_CMD: Wrong data length")
                    GoTo FinishedParsing
                End If
                ThisWriteLine.Invoke("Slot: " & Clients(ClientSlot).CID & ", Folder ID: " & Int(Data(0) << 8 Or Data(1)))
                If (Clients(ClientSlot).FilesListDirectory Is FindFolder(Int(Data(0) << 8 Or Data(1))) And Clients(ClientSlot).FilesListCount > 0) Then
                    If (Data(2) < Clients(ClientSlot).FilesListCount) Then
                        TransmitData(0) = Data(0)
                        TransmitData(1) = Data(1)
                        TransmitData(2) = (Convert.ToInt16(Clients(ClientSlot).FilesListDirectory.Nodes(Data(2)).Name.Substring(1, Clients(ClientSlot).FilesListDirectory.Nodes(Data(2)).Name.Length - 1)) >> 8)
                        TransmitData(3) = (Convert.ToInt16(Clients(ClientSlot).FilesListDirectory.Nodes(Data(2)).Name.Substring(1, Clients(ClientSlot).FilesListDirectory.Nodes(Data(2)).Name.Length - 1)) And &HFF)
                        TransmitData(4) = Asc(Clients(ClientSlot).FilesListDirectory.Nodes(Data(2)).Name.Substring(0, 1))

                        Dim i As Integer
                        For i = 0 To Clients(ClientSlot).FilesListDirectory.Nodes(Data(2)).Text.Length - 1
                            TransmitData(5 + i) = Asc(Clients(ClientSlot).FilesListDirectory.Nodes(Data(2)).Text.Substring(i, 1))
                        Next

                        MultimediaServer.SendPackage(CID, &H6, 5 + Clients(ClientSlot).FilesListDirectory.Nodes(Data(2)).Text.Length, TransmitData)
                        ThisWriteLine.Invoke(" -> " & Clients(ClientSlot).FilesListDirectory.Nodes(Data(2)).Tag)
                        ThisWriteLine.Invoke(" -> REPLY: Sent")
                    Else
                        ' Send error!
                        ThisWriteLine.Invoke("ERR_CMD: List count out of bounds - #" & Data(2) & " requested, #" & Clients(ClientSlot).FilesListCount & " total")
                        Clients(ClientSlot).FilesListDirectory = Nothing
                        Clients(ClientSlot).FilesListCount = 0
                    End If
                Else
                    ' Send error!
                    ThisWriteLine.Invoke("ERR_CMD: Request not prepared for this Folder ID")
                    Clients(ClientSlot).FilesListDirectory = Nothing
                    Clients(ClientSlot).FilesListCount = 0
                End If

            Case &HA ' Request audio file length
                If Not DataLength = 2 Then
                    ' Send wrong package size error
                    ThisWriteLine.Invoke("ERR_CMD: Wrong data length")
                    GoTo FinishedParsing
                End If

                ThisWriteLine.Invoke("Request file item from Client: " & CID)
                Dim fileNode As TreeNode = FindFileNode(((Int(Data(0)) << 8) Or Data(1)))
                If Not fileNode.Name.Substring(0, 1) = "A" Then
                    ' Send wrong package size error
                    ThisWriteLine.Invoke("ERR_CMD: Not audio requested")
                    GoTo FinishedParsing
                End If

                Dim filePath As String = FindFile(((Int(Data(0)) << 8) Or Data(1)))
                If filePath Is Nothing Then
                    ' Send error!
                    ThisWriteLine.Invoke("ERR_CMD: File #" & ((Int(Data(0)) << 8) Or Data(1)) & " not found")
                Else
                    Clients(ClientSlot).FileStreamCurrentID = ((Int(Data(0)) << 8) Or Data(1))
                    Clients(ClientSlot).FileStreamPath = filePath
                    Clients(ClientSlot).FileStream = New FileStream(filePath, FileMode.Open, FileAccess.Read)

                    Clients(ClientSlot).FileStreamFileLength = New FileInfo(filePath).Length
                    Clients(ClientSlot).FileStreamDPL = 1440
                    Clients(ClientSlot).FileStreamMaximumPackageCount = Clients(ClientSlot).FileStreamFileLength / Clients(ClientSlot).FileStreamDPL
                    Clients(ClientSlot).FileStreamCurrentPackage = 0

                    TransmitData(0) = Data(0)
                    TransmitData(1) = Data(1)
                    TransmitData(2) = (Clients(ClientSlot).FileStreamFileLength And &HFF000000) >> 24
                    TransmitData(3) = (Clients(ClientSlot).FileStreamFileLength And &HFF0000) >> 16
                    TransmitData(4) = (Clients(ClientSlot).FileStreamFileLength And &HFF00) >> 8
                    TransmitData(5) = (Clients(ClientSlot).FileStreamFileLength And &HFF)
                    TransmitData(6) = (Clients(ClientSlot).FileStreamDPL And &HFF00) >> 8 ' Each data package byte length
                    TransmitData(7) = (Clients(ClientSlot).FileStreamDPL And &HFF) ' Each data package byte length

                    TransmitData(8) = (Clients(ClientSlot).FileStreamMaximumPackageCount And &HFF0000) >> 16
                    TransmitData(9) = (Clients(ClientSlot).FileStreamMaximumPackageCount And &HFF00) >> 8
                    TransmitData(10) = (Clients(ClientSlot).FileStreamMaximumPackageCount And &HFF)

                    MultimediaServer.SendPackage(CID, &HB, 11, TransmitData)
                    ThisWriteLine.Invoke(" -> REPLY: Sent")
                End If

            Case &HC ' Request audio content
                If Not DataLength = 5 Then
                    ' Send wrong package size error
                    ThisWriteLine.Invoke("ERR_CMD: Wrong data length")
                    GoTo FinishedParsing
                End If

                Clients(ClientSlot).FileStreamRequestPackage = ((Int(Data(2)) << 16) Or (Int(Data(3)) << 8) Or (Int(Data(4))))
                ThisWriteLine.Invoke("Request file package: " & Clients(ClientSlot).FileStreamRequestPackage)
                If Not Clients(ClientSlot).FileStreamCurrentID = ((Int(Data(0)) << 8) Or Data(1)) Then
                    ThisWriteLine.Invoke("ERR_CMD: File not initialized for read")
                Else
                    If (Clients(ClientSlot).FileStreamCurrentPackage < Clients(ClientSlot).FileStreamMaximumPackageCount) Then
                        If Not Clients(ClientSlot).FileStreamCurrentPackage = Clients(ClientSlot).FileStreamRequestPackage Then
                            ThisWriteLine.Invoke("ERR_CMD: File can only be read in a stream (increasing pointer)")
                        Else
                            TransmitData(0) = Data(0)
                            TransmitData(1) = Data(1)
                            TransmitData(2) = Data(2)
                            TransmitData(3) = Data(3)
                            TransmitData(4) = Data(4)
                            Clients(ClientSlot).FileStream.Read(TransmitData, 5, Clients(ClientSlot).FileStreamDPL)
                            MultimediaServer.SendPackage(CID, &HD, (5 + Clients(ClientSlot).FileStreamDPL), TransmitData)
                            Clients(ClientSlot).FileStreamCurrentPackage += 1
                        End If
                    Else 'If ((Clients(ClientSlot).FileStreamFileLength - (Clients(ClientSlot).FileStreamDPL * Clients(ClientSlot).FileStreamMaximumPackageCount)) > 0) Then
                        If Not Clients(ClientSlot).FileStreamCurrentPackage = Clients(ClientSlot).FileStreamRequestPackage Then
                            ThisWriteLine.Invoke("ERR_CMD: File can only be read in a stream (increasing pointer)")
                        Else
                            ThisWriteLine.Invoke("Last package")
                            TransmitData(0) = Data(0)
                            TransmitData(1) = Data(1)
                            TransmitData(2) = Data(2)
                            TransmitData(3) = Data(3)
                            TransmitData(4) = Data(4)
                            Clients(ClientSlot).FileStream.Read(TransmitData, 5, (Clients(ClientSlot).FileStreamFileLength - (Clients(ClientSlot).FileStreamDPL * Clients(ClientSlot).FileStreamMaximumPackageCount)))
                            MultimediaServer.SendPackage(CID, &HD, (5 + (Clients(ClientSlot).FileStreamFileLength - (Clients(ClientSlot).FileStreamDPL * Clients(ClientSlot).FileStreamMaximumPackageCount))), TransmitData)
                            'Clients(ClientSlot).FileStreamCurrentPackage += 1
                        End If
                    End If
                End If

            Case &H1A ' Request image file length
                If Not DataLength = 2 Then
                    ' Send wrong package size error
                    ThisWriteLine.Invoke("ERR_CMD: Wrong data length")
                    GoTo FinishedParsing
                End If

                ThisWriteLine.Invoke("Request file item from Client: " & CID)
                Dim fileNode As TreeNode = FindFileNode(((Int(Data(0)) << 8) Or Data(1)))
                If Not fileNode.Name.Substring(0, 1) = "I" Then
                    ' Send wrong package size error
                    ThisWriteLine.Invoke("ERR_CMD: Not image requested")
                    GoTo FinishedParsing
                End If

                Dim filePath As String = FindFile(((Int(Data(0)) << 8) Or Data(1)))
                If filePath Is Nothing Then
                    ' Send error!
                    ThisWriteLine.Invoke("ERR_CMD: File #" & ((Int(Data(0)) << 8) Or Data(1)) & " not found")
                Else
                    Clients(ClientSlot).FileStreamCurrentID = ((Int(Data(0)) << 8) Or Data(1))
                    Clients(ClientSlot).FileStreamPath = ""
                    Clients(ClientSlot).FileStream = Nothing

                    LoadImage(filePath)
                    ImageToBinary(ClientSlot)

                    Clients(ClientSlot).FileStreamFileLength = ConvertedImage.Width * ConvertedImage.Height * 2
                    Clients(ClientSlot).FileStreamDPL = 1440 * ((CDbl(Clients(ClientSlot).FileStreamFileLength) / 1440) - Math.Round((CDbl(Clients(ClientSlot).FileStreamFileLength) / 1440), 0, MidpointRounding.AwayFromZero) + 1)
                    Clients(ClientSlot).FileStreamMaximumPackageCount = Clients(ClientSlot).FileStreamFileLength / Clients(ClientSlot).FileStreamDPL
                    Clients(ClientSlot).FileStreamCurrentPackage = 0

                    TransmitData(0) = Data(0)
                    TransmitData(1) = Data(1)
                    TransmitData(2) = (ConvertedImage.Width And &HFF00) >> 8
                    TransmitData(3) = (ConvertedImage.Width And &HFF)
                    TransmitData(4) = (ConvertedImage.Height And &HFF00) >> 8
                    TransmitData(5) = (ConvertedImage.Height And &HFF)
                    TransmitData(6) = (Clients(ClientSlot).FileStreamDPL And &HFF00) >> 8 ' Each data package byte length
                    TransmitData(7) = (Clients(ClientSlot).FileStreamDPL And &HFF) ' Each data package byte length
                    TransmitData(8) = (Clients(ClientSlot).FileStreamMaximumPackageCount And &HFF0000) >> 16
                    TransmitData(9) = (Clients(ClientSlot).FileStreamMaximumPackageCount And &HFF00) >> 8
                    TransmitData(10) = (Clients(ClientSlot).FileStreamMaximumPackageCount And &HFF)

                    MultimediaServer.SendPackage(CID, &H1B, 11, TransmitData)
                    ThisWriteLine.Invoke(" -> REPLY: Sent + Image converted")
                End If

            Case &H1C ' Request image content
                If Not DataLength = 5 Then
                    ' Send wrong package size error
                    ThisWriteLine.Invoke("ERR_CMD: Wrong data length")
                    GoTo FinishedParsing
                End If

                Clients(ClientSlot).FileStreamRequestPackage = ((Int(Data(2)) << 16) Or (Int(Data(3)) << 8) Or (Int(Data(4))))
                ThisWriteLine.Invoke("Request file package: " & Clients(ClientSlot).FileStreamRequestPackage)
                If Not Clients(ClientSlot).FileStreamCurrentID = ((Int(Data(0)) << 8) Or Data(1)) Then
                    ThisWriteLine.Invoke("ERR_CMD: File not initialized for read")
                Else
                    If (Clients(ClientSlot).FileStreamCurrentPackage < Clients(ClientSlot).FileStreamMaximumPackageCount) Then
                        If Not Clients(ClientSlot).FileStreamCurrentPackage = Clients(ClientSlot).FileStreamRequestPackage Then
                            ThisWriteLine.Invoke("ERR_CMD: File can only be read in a stream (increasing pointer)")
                        Else
                            TransmitData(0) = Data(0)
                            TransmitData(1) = Data(1)
                            TransmitData(2) = Data(2)
                            TransmitData(3) = Data(3)
                            TransmitData(4) = Data(4)
                            Array.Copy(Clients(ClientSlot).imageData, (Clients(ClientSlot).FileStreamCurrentPackage * Clients(ClientSlot).FileStreamDPL), TransmitData, 5, Clients(ClientSlot).FileStreamDPL)
                            MultimediaServer.SendPackage(CID, &H1D, (5 + Clients(ClientSlot).FileStreamDPL), TransmitData)
                            Clients(ClientSlot).FileStreamCurrentPackage += 1
                        End If
                    Else 'If ((Clients(ClientSlot).FileStreamFileLength - (Clients(ClientSlot).FileStreamDPL * Clients(ClientSlot).FileStreamMaximumPackageCount)) > 0) Then
                        If Not Clients(ClientSlot).FileStreamCurrentPackage = Clients(ClientSlot).FileStreamRequestPackage Then
                            ThisWriteLine.Invoke("ERR_CMD: File can only be read in a stream (increasing pointer)")
                        Else
                            ThisWriteLine.Invoke("Last package")
                            TransmitData(0) = Data(0)
                            TransmitData(1) = Data(1)
                            TransmitData(2) = Data(2)
                            TransmitData(3) = Data(3)
                            TransmitData(4) = Data(4)
                            Array.Copy(Clients(ClientSlot).imageData, (Clients(ClientSlot).FileStreamCurrentPackage * Clients(ClientSlot).FileStreamDPL), TransmitData, 5, Clients(ClientSlot).FileStreamDPL)
                            MultimediaServer.SendPackage(CID, &H1D, (5 + Clients(ClientSlot).FileStreamDPL), TransmitData)
                            'Clients(ClientSlot).FileStreamCurrentPackage += 1
                        End If
                    End If
                End If
        End Select

        GoTo FinishedParsing


FinishedParsing:
        GC.SuppressFinalize(Data)
    End Sub

    Dim FilesIDCount As Integer
    Dim FoldersIDCount As Integer
    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        If FolderBrowserDialog1.ShowDialog() = Windows.Forms.DialogResult.OK Then
            TreeView1.Nodes.Clear()

            Dim topNode As TreeNode = TreeView1.Nodes.Add("SERVER")
            topNode.Name = "F0" ' Top folder (root)

            FilesIDCount = 1
            FoldersIDCount = 1
            PopulateTreeView(FolderBrowserDialog1.SelectedPath, TreeView1.Nodes(0))
        End If
    End Sub

    Private Sub PopulateTreeView(ByVal dir As String, ByVal parentNode As TreeNode)
        Dim folder As String = String.Empty
        Try
            'Add folders to treeview
            Dim folders() As String = IO.Directory.GetDirectories(dir)        
            If folders.Length <> 0 Then
                Dim folderNode As TreeNode = Nothing
                Dim folderName As String = String.Empty
                For Each folder In folders
                    folderName = IO.Path.GetFileName(folder)
                    If (IO.Directory.GetDirectories(folder).Length > 0) Or (IO.Directory.GetFiles(folder).Length > 0) Then
                        If (IO.Path.GetFileName(folder).Length > 30) Then
                            folderNode = parentNode.Nodes.Add(folderName.Substring(0, 30))
                        Else
                            folderNode = parentNode.Nodes.Add(folderName)
                        End If

                        folderNode.Tag = folder
                        folderNode.Name = "F" & FoldersIDCount ' Folder
                        FoldersIDCount += 1
                        PopulateTreeView(folder, folderNode)
                    End If
                Next
            End If

            'Add the files to treeview
            Dim files() As String = IO.Directory.GetFiles(dir)
            If files.Length <> 0 Then
                Dim fileNode As TreeNode = Nothing
                For Each file As String In files
                    If (IO.Path.GetExtension(file).ToLower.Contains("mp3") Or IO.Path.GetExtension(file).ToLower.Contains("wav") Or IO.Path.GetExtension(file).ToLower.Contains("mid") Or IO.Path.GetExtension(file).ToLower.Contains("aac")) Then
                        If (IO.Path.GetFileName(file).Length > 30) Then
                            fileNode = parentNode.Nodes.Add(IO.Path.GetFileName(file).Substring(0, 25) & IO.Path.GetExtension(file))
                        Else
                            fileNode = parentNode.Nodes.Add(IO.Path.GetFileName(file))
                        End If

                        fileNode.Tag = file
                        fileNode.Name = "A" & FilesIDCount ' Audio
                        ThisWriteLine.Invoke(" -> " & fileNode.Tag)
                        FilesIDCount += 1
                    ElseIf (IO.Path.GetExtension(file).ToLower.Contains("bmp") Or IO.Path.GetExtension(file).ToLower.Contains("jpg")) Then
                        If (IO.Path.GetFileName(file).Length > 30) Then
                            fileNode = parentNode.Nodes.Add(IO.Path.GetFileName(file).Substring(0, 25) & IO.Path.GetExtension(file))
                        Else
                            fileNode = parentNode.Nodes.Add(IO.Path.GetFileName(file))
                        End If

                        fileNode.Tag = file
                        fileNode.Name = "I" & FilesIDCount ' Image
                        FilesIDCount += 1
                    End If

                Next
            End If

        Catch ex As UnauthorizedAccessException
            parentNode.Nodes.Add(IO.Path.GetFileName(dir) & ": Access Denied")
            Debug.WriteLine(IO.Path.GetFileName(dir) & ": Access Denied")
        End Try
    End Sub

    Private Function FindFolder(ByVal folderID As Integer) As TreeNode
        Dim FoundNode As TreeNode
        For Each tn As TreeNode In TreeView1.Nodes

            If tn.Name = "F" & folderID Then
                Return tn
                Exit For
            End If

            If tn.Nodes.Count > 0 Then
                For Each cTn As TreeNode In tn.Nodes
                    FoundNode = FindFolderChildren(cTn, folderID)
                    If Not FoundNode Is Nothing Then
                        Return FoundNode
                    End If
                Next
            End If
        Next
        Return Nothing
    End Function

    Private Function FindFolderChildren(ByVal tn As TreeNode, ByVal folderID As Integer) As TreeNode
        Dim FoundNode As TreeNode

        If tn.Name = "F" & folderID Then
            Return tn
        End If

        If tn.Nodes.Count > 0 Then
            For Each tnC As TreeNode In tn.Nodes
                FoundNode = FindFolderChildren(tnC, folderID)
                If Not FoundNode Is Nothing Then
                    Return FoundNode
                End If
            Next

        End If
        Return Nothing
    End Function

    Private Function FindFile(ByVal fileID As Integer) As String
        Dim FoundNode As TreeNode
        For Each tn As TreeNode In TreeView1.Nodes

            If (tn.Name = "A" & fileID) Or (tn.Name = "I" & fileID) Then
                Return tn.Tag
                Exit For
            End If

            If tn.Nodes.Count > 0 Then
                For Each cTn As TreeNode In tn.Nodes
                    FoundNode = FindFilesChildren(cTn, fileID)
                    If Not FoundNode Is Nothing Then
                        Return FoundNode.Tag
                    End If
                Next
            End If
        Next
        Return Nothing
    End Function

    Private Function FindFileNode(ByVal fileID As Integer) As TreeNode
        Dim FoundNode As TreeNode
        For Each tn As TreeNode In TreeView1.Nodes

            If (tn.Name = "A" & fileID) Or (tn.Name = "I" & fileID) Then
                Return tn.Tag
                Exit For
            End If

            If tn.Nodes.Count > 0 Then
                For Each cTn As TreeNode In tn.Nodes
                    FoundNode = FindFilesChildren(cTn, fileID)
                    If Not FoundNode Is Nothing Then
                        Return FoundNode
                    End If
                Next
            End If
        Next
        Return Nothing
    End Function


    Private Function FindFilesChildren(ByVal tn As TreeNode, ByVal fileID As Integer) As TreeNode
        Dim FoundNode As TreeNode

        If (tn.Name = "A" & fileID) Or (tn.Name = "I" & fileID) Then
            Return tn
        End If

        If tn.Nodes.Count > 0 Then
            For Each tnC As TreeNode In tn.Nodes
                FoundNode = FindFilesChildren(tnC, fileID)
                If Not FoundNode Is Nothing Then
                    Return FoundNode
                End If
            Next

        End If
        Return Nothing
    End Function

    Private Sub TreeView1_AfterSelect(ByVal sender As System.Object, ByVal e As System.Windows.Forms.TreeViewEventArgs) Handles TreeView1.AfterSelect
        MsgBox(TreeView1.SelectedNode.Name & " -> " & TreeView1.SelectedNode.Tag)
    End Sub

    Dim ConvertedImage As Drawing.Bitmap    
    Private OnBits(0 To 31) As Long
    Dim PhotoLoaded As Boolean = False

    Public Function BinaryToDecimal(ByVal Binary As String) As Long
        Dim n As Long
        Dim s As Integer
        For s = 1 To Len(Binary)
            n = n + (Mid(Binary, Len(Binary) - s + 1, 1) * (2 ^ (s - 1)))
        Next s

        BinaryToDecimal = n
    End Function

    Public Function DecimalToBinary(ByVal DecimalNum As Long) As String
        Dim tmp As String
        Dim n As Long

        n = DecimalNum

        tmp = Trim(Str(n Mod 2))
        n = n \ 2

        Do While n <> 0
            tmp = Trim(Str(n Mod 2)) & tmp
            n = n \ 2
        Loop

        DecimalToBinary = tmp
    End Function

    Public Function LShiftLong(ByVal Value As Long, _
        ByVal Shift As Integer) As Long

        MakeOnBits()

        If (Value And (2 ^ (31 - Shift))) Then GoTo OverFlow

        LShiftLong = ((Value And OnBits(31 - Shift)) * (2 ^ Shift))

        Exit Function

OverFlow:

        LShiftLong = ((Value And OnBits(31 - (Shift + 1))) * _
           (2 ^ (Shift))) Or &H80000000

    End Function

    Public Function RShiftLong(ByVal Value As Long, _
       ByVal Shift As Integer) As Long
        Dim hi As Long
        MakeOnBits()
        If (Value And &H80000000) Then hi = &H40000000

        RShiftLong = (Value And &H7FFFFFFE) \ (2 ^ Shift)
        RShiftLong = (RShiftLong Or (hi \ (2 ^ (Shift - 1))))
    End Function



    Private Sub MakeOnBits()
        Dim j As Integer, _
            v As Long

        For j = 0 To 30

            v = v + (2 ^ j)
            OnBits(j) = v

        Next j

        OnBits(j) = v + &H80000000

    End Sub

    '*********************************************************************
    '* Macros: RGB565CONVERT(red, green, blue)
    '*
    '* Overview: Converts true color into 5:6:5 RGB format.
    '*
    '* PreCondition: none
    '*
    '* Input: Red, Green, Blue components.
    '*
    '* Output: 5 bits red, 6 bits green, 5 bits blue color.
    '*
    '* Side Effects: none
    '*
    '********************************************************************
    Public Function RGB526Convert(ByVal R As Byte, ByVal G As Byte, ByVal B As Byte) As Long
        RGB526Convert = (LShiftLong(RShiftLong(R, 3), 11) Or LShiftLong(RShiftLong(G, 2), 5) Or RShiftLong(B, 3))
    End Function

    Private Sub LoadImage(ByVal imagePath As String)
        Dim TempImage As Drawing.Bitmap
        Dim gr_dest As Graphics
        Dim ScaleFactor As Double

        Try

            TempImage = New Drawing.Bitmap(imagePath, True)
            ScaleFactor = TempImage.Width / 320
            If (TempImage.Height / ScaleFactor) > 240 Then
                ScaleFactor = TempImage.Height / 240
            End If

            'image1 = New Drawing.Bitmap(CInt(TempImage.Width * scale_factor), CInt(TempImage.Height * scale_factor))
            ConvertedImage = New Drawing.Bitmap(320, 240)
            gr_dest = Graphics.FromImage(ConvertedImage)
            gr_dest.FillRectangle(Brushes.Black, 0, 0, ConvertedImage.Width, ConvertedImage.Height)
            ' Copy the source image into the destination bitmap.
            gr_dest.DrawImage(TempImage, 0, 0, CInt((TempImage.Width / ScaleFactor) + 1), CInt((TempImage.Height / ScaleFactor) + 1))
            PhotoLoaded = True

        Catch ex As ArgumentException
            ThisWriteLine.Invoke("There was an error." & "Check the path to the image file.")
        End Try
    End Sub

    Private Sub ImageToBinary(ByVal ClientSlot As Integer)
        Dim i, i2 As Integer
        Dim CharacterCount As Integer
        Dim Hex As String

        Dim lower, upper As Byte

        Dim HexImageWidth, HexImageHeight As String

        HexImageWidth = Conversion.Hex(ConvertedImage.Width)
        If Len(HexImageWidth) < 4 Then
            For i = Len(HexImageWidth) + 1 To 4
                HexImageWidth = "0" & HexImageWidth
            Next
        End If

        HexImageHeight = Conversion.Hex(ConvertedImage.Height)
        If Len(HexImageHeight) < 4 Then
            For i = Len(HexImageHeight) + 1 To 4
                HexImageHeight = "0" & HexImageHeight
            Next
        End If

        'lower = image1.Width And &HFF&
        'upper = (image1.Width And &HFF00&) / 256
        'oWrite.WriteByte(upper)
        'oWrite.WriteByte(lower)

        'lower = image1.Height And &HFF&
        'upper = (image1.Height And &HFF00&) / 256
        'oWrite.WriteByte(upper)
        'oWrite.WriteByte(lower)

        i2 = 0
        CharacterCount = 0
        Dim x, y As Integer

        ' Loop through the images pixels to reset color.
        For y = 0 To ConvertedImage.Height - 1
            For x = 0 To ConvertedImage.Width - 1
                Dim pixelColor As Color = ConvertedImage.GetPixel(x, y)
                Dim newColor As Color = _
                    Color.FromArgb(pixelColor.R, 0, 0)
                Hex = Conversion.Hex(RGB526Convert(pixelColor.R, pixelColor.G, pixelColor.B))
                If Len(Hex) < 4 Then
                    For i = Len(Hex) + 1 To 4
                        Hex = "0" & Hex
                    Next
                End If


                lower = RGB526Convert(pixelColor.R, pixelColor.G, pixelColor.B) And &HFF&
                upper = (RGB526Convert(pixelColor.R, pixelColor.G, pixelColor.B) And &HFF00&) / 256

                'oWrite.WriteByte(upper)
                'oWrite.WriteByte(lower)
                Clients(ClientSlot).imageData(i2) = upper
                Clients(ClientSlot).imageData(i2 + 1) = lower
                i2 = i2 + 2
                CharacterCount = CharacterCount + 2


                'image1.SetPixel(x, y, newColor)
            Next
        Next
        'oWrite.Close()
    End Sub
End Class




Module MultimediaServer
    Dim UDPclient As UdpClient
    Dim receivePoint As IPEndPoint
    Dim DisconnectFlag_WaitForPackets, DisconnectFlag_CheckClientsAlive As Boolean
    Dim parsingThreads(100) As Thread
    Dim currentParsingThreadNumber As Integer = currentParsingThreadNumber
    Dim _TimeoutPingPeriod, _TimeoutPingWait As Integer

    Public Delegate Sub DataParser(ByVal CID As Byte, ByVal Command As Byte, ByVal DataLength As Byte, ByVal Data() As Byte)
    Public CallBack As DataParser

    Public Delegate Sub DebugWriteLine(ByVal text As String)
    Public WriteLine As DebugWriteLine

    Public Clients(20) As ClientsClass



    Class ClientsClass
        Public CID As Byte
        Public UniqueID(4) As Byte
        Public ClientAssigned As Boolean
        Public LastPackageTimeStamp As Integer
        Public PingSent As Boolean

        ' Request command parameters
        Public FilesListDirectory As TreeNode
        Public FilesListCount As Integer
        Public FilesListPos As Integer

        Public FileStream As System.IO.FileStream
        Public FileStreamCurrentID As Integer
        Public FileStreamPath As String
        Public FileStreamPos As Integer ' Pos in the package division (though we use streamreader, then it just comes in a flow - so this is just to confirm)
        Public FileStreamFileLength As Integer
        Public FileStreamDPL As Integer
        Public FileStreamMaximumPackageCount As Integer
        Public FileStreamCurrentPackage As Integer
        Public FileStreamRequestPackage As Integer

        Public imageData(320 * 240 * 2) As Byte

        Public Sub New()
            CID = &HFF
            UniqueID = {&HFF, &HFF, &HFF, &HFF}
            FilesListDirectory = Nothing
            FileStreamPath = ""
            ClientAssigned = False
        End Sub

        Public Sub AssignCID(ByVal NewCID As Byte, ByVal UniqueID0 As Byte, ByVal UniqueID1 As Byte, ByVal UniqueID2 As Byte, ByVal UniqueID3 As Byte)
            CID = NewCID
            UniqueID(3) = UniqueID3
            UniqueID(2) = UniqueID2
            UniqueID(1) = UniqueID1
            UniqueID(0) = UniqueID0
            ClientAssigned = True
            PingSent = False
        End Sub

        Public Sub ReleaseSlot()
            CID = &HFF
            UniqueID = {&HFF, &HFF, &HFF, &HFF}
            FilesListDirectory = Nothing
            FileStreamPath = ""
            ClientAssigned = False
        End Sub

    End Class

    Private Function GetTimestamp() As Double
        Dim span As TimeSpan = (Now() - New DateTime(1970, 1, 1, 0, 0, 0, 0).ToLocalTime())
        Return span.TotalSeconds
    End Function

    Public Sub Initialize(ByVal TimeoutPingPeriod As Integer, ByVal TimeoutPingWait As Integer)
        Dim i As Integer

        _TimeoutPingPeriod = TimeoutPingPeriod
        _TimeoutPingWait = TimeoutPingWait

        For i = 0 To Clients.Length - 1
            Clients(i) = New ClientsClass
        Next
    End Sub

    Public Sub DebugAddress(ByVal DebugFunction As DebugWriteLine)
        WriteLine = DebugFunction
    End Sub

    Public Sub StartServer(ByVal ServerPort As Integer, ByVal SetCallback As DataParser)
        CallBack = SetCallback

        UDPclient = New UdpClient(ServerPort)
        receivePoint = New IPEndPoint(New IPAddress(0), 1111)
        DisconnectFlag_WaitForPackets = False
        DisconnectFlag_CheckClientsAlive = False

        Dim readThread As Thread = New Thread(New ThreadStart(AddressOf WaitForPackets))
        readThread.Start() ' wait for packets

        Dim clientsAliveThread As Thread = New Thread(New ThreadStart(AddressOf CheckClientsAlive))
        clientsAliveThread.Start() ' keep clients alive, check if they are alive
    End Sub

    Public Sub Disconnect()
        DisconnectFlag_WaitForPackets = True
        DisconnectFlag_CheckClientsAlive = True

        While DisconnectFlag_WaitForPackets = True Or DisconnectFlag_CheckClientsAlive = True

        End While

        UDPclient.Close()
    End Sub

    Public Sub WaitForPackets()
        Dim Err As Boolean
        Dim packageDataLength As Integer
        While DisconnectFlag_WaitForPackets = False
            If UDPclient.Available > 0 Then
                Dim data As Byte() = UDPclient.Receive(receivePoint)
                Err = False

                'If currentParsingThreadNumber = parsingThreads.Length Then
                'currentParsingThreadNumber = 0
                'End If
                'parsingThreads(currentParsingThreadNumber) = New Thread(AddressOf ParseData)
                'parsingThreads(currentParsingThreadNumber).Start(data)

                If data.Length < 5 Then ' Package not correct format            
                    WriteLine.Invoke("ERR_PACKAGE: Not correct format")
                    Err = True
                End If

                If Not (CalculateChecksum(data) = data(data.Length - 1)) Then
                    WriteLine.Invoke("ERR_PACKAGE: Checksum - " & CalculateChecksum(data).ToString("X") & " vs " & data(data.Length - 1).ToString("X"))
                    Err = True
                End If

                packageDataLength = (data(2) << 8) Or data(3)
                If Not (packageDataLength = (data.Length - 5)) Then
                    WriteLine.Invoke("ERR_PACKAGE: Length - " & (data.Length - 5) & " vs " & packageDataLength)
                    Err = True
                End If

                If Err = False Then
                    Dim packageData() As Byte = New Byte(1024) {}
                    Array.Copy(data, 4, packageData, 0, packageDataLength)
                    CallBack.Invoke(data(0), data(1), packageDataLength, packageData)
                End If

                GC.SuppressFinalize(data)

                'currentParsingThreadNumber += 1
            End If
        End While
        DisconnectFlag_WaitForPackets = False
    End Sub

    Public Sub SendPackage(ByVal CID As Byte, ByVal Command As Byte, ByVal DataLength As Integer, ByVal PackageData As Byte())
        Dim TransmitPackage(DataLength + 5) As Byte
        TransmitPackage(0) = CID
        TransmitPackage(1) = Command
        TransmitPackage(2) = (DataLength And &HFF00) >> 8
        TransmitPackage(3) = (DataLength And &HFF)
        Array.Copy(PackageData, 0, TransmitPackage, 4, DataLength)

        TransmitPackage(DataLength + 4) = CalculateChecksum(TransmitPackage)

        UDPclient.Send(TransmitPackage, TransmitPackage.Length - 1, receivePoint)
    End Sub

    Private Sub CheckClientsAlive()
        While DisconnectFlag_CheckClientsAlive = False ' Forever loop
            For i = 0 To Clients.Length - 1
                If Clients(i).ClientAssigned = True Then
                    If Clients(i).PingSent = False Then
                        If GetTimestamp() > (Clients(i).LastPackageTimeStamp + _TimeoutPingPeriod) Then
                            WriteLine.Invoke("Pinging client: " & Clients(i).CID)
                            PingClient(i)
                        End If
                    Else
                        If GetTimestamp() > (Clients(i).LastPackageTimeStamp + _TimeoutPingPeriod + _TimeoutPingWait) Then
                            WriteLine.Invoke("Client haven't responded (" & Clients(i).CID & ") - Unassigning...")
                            Clients(i).ReleaseSlot()
                        End If
                    End If
                End If
            Next

            Thread.Sleep(5 * 1000) ' 30 seconds
        End While

        DisconnectFlag_CheckClientsAlive = False
    End Sub

    Private Function CalculateChecksum(ByVal data As Byte()) As Byte
        Dim i As Integer
        Dim temp As Integer = 0

        For i = 0 To data.Length - 2
            temp += data(i)
        Next

        temp = temp And &HFF
        Return (temp Xor &HFF)
    End Function




    Public Function CheckClient(ByVal CID As Byte) As Byte
        Dim i As Integer
        If UBound(Clients) = 0 Then Return False

        For i = 0 To Clients.Length - 1
            If Clients(i).CID = CID And Clients(i).ClientAssigned = True Then
                Return i
            End If
        Next
        Return &HFF
    End Function

    Public Function FreeClientSlot() As Byte
        Dim i As Integer

        For i = 0 To Clients.Length - 1
            If Clients(i).ClientAssigned = False Then
                Return i
            End If
        Next
        Return &HFF
    End Function

    Public Function NewClient(ByVal UniqueID0 As Byte, ByVal UniqueID1 As Byte, ByVal UniqueID2 As Byte, ByVal UniqueID3 As Byte) As Byte
        Dim ClientSlot As Byte = FreeClientSlot()
        If Not ClientSlot = &HFF Then
            Clients(ClientSlot).AssignCID(ClientSlot + 1, UniqueID0, UniqueID1, UniqueID2, UniqueID3)
            UpdateTimestamp(ClientSlot)
            Return ClientSlot + 1 ' Return CID
        Else
            Return &HFF
        End If
    End Function

    Public Sub UpdateTimestamp(ByVal ClientSlot As Byte)
        Clients(ClientSlot).LastPackageTimeStamp = GetTimestamp()
    End Sub

    Public Sub PingClient(ByVal ClientSlot As Byte)
        Dim pingPacket(4) As Byte
        pingPacket(0) = Clients(ClientSlot).CID
        pingPacket(1) = &H40
        pingPacket(2) = &H0
        pingPacket(3) = CalculateChecksum(pingPacket)

        UDPclient.Send(pingPacket, pingPacket.Length - 1, receivePoint)
        Clients(ClientSlot).PingSent = True
    End Sub

End Module


