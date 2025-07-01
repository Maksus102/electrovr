using Godot;
using System;
using System.IO.Ports;
using System.Text;
using System.Globalization;
using System.Collections;

public partial class ArduinoConnect : Label3D
{
	SerialPort sport;
	int output;

	string output_name = "HZ";

	public override void _Ready()
	{
		sport = new SerialPort();
		sport.PortName = "COM3";
		sport.BaudRate = 9600;
		sport.Open();
	}

	public override void _Process(double delta)
	{
		try
		{
			if (!sport.IsOpen) return;
			string sermess = sport.ReadExisting();
			output = int.Parse(sermess, CultureInfo.InvariantCulture.NumberFormat);
			base.Text = sermess;
		}
		catch (Exception ex )
		{
			
		}
	}
}
