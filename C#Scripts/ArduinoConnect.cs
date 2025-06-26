using Godot;
using System;
using System.IO.Ports;
using System.Text;
using System.Globalization;

public partial class ArduinoConnect : Label3D
{
	SerialPort sport;
	Label3D label;
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
		if (!sport.IsOpen) return;
		string sermess = sport.ReadExisting();
		output = int.Parse(sermess, CultureInfo.InvariantCulture.NumberFormat);
		base.Text = sermess;
	}
}
