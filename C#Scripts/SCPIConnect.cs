using Godot;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO.Ports;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;


public partial class SCPIConnect : Label3D
{
    string output;
    string output_name = "HZ";


    public override void _Ready()
    {

    }

    public override void _Process(double delta)
    {
        try
        {

        }
        catch (Exception ex)
        {

        }
    }

    public static void Main()
    {
        SerialPort sport;
        sport = new SerialPort();
        sport.PortName = "COM4";
        sport.BaudRate = 9600;
        sport.Parity = Parity.None;
        sport.Open();

        if (!sport.IsOpen) return;
        string sermess = sport.ReadExisting();
        sport.WriteLine("MEASure:VOLTage:DC?");
        Console.WriteLine(sermess);
    }
}
