using Godot;
using System;
using System.IO.Ports;
using System.Text;
using System.Collections;
using System.Collections.Generic;

public partial class ArduinoConnect : Node3D
{
	[Export]
	public Light3D light;
	[Export]
	public Label3D label;
	SerialPort sport;
	int output;

	string output_name = "Lumen";

	public override void _Ready()
	{
		sport = new SerialPort();
	}

	public override void _Process(double delta)
	{
		if (sport.IsOpen == true)
		{
			DataExchange();
		}
		else return;
	}

	public void DataExchange()
	{
		try
		{
			byte[] mess = { 0x1 };
			sport.Write(mess, 0, 1);
			string sermess = sport.ReadLine();
			output = int.Parse(sermess);
			label.Text = sermess;
			light.LightEnergy = (((float.Parse(sermess) - 15) / (800 - 15)) * (16 - 0.5f)) + 0.5f;
		}
		catch (Exception ex)
		{

		}
	}

	public void OpenCOM(string name)
	{
		sport.PortName = name;
		sport.BaudRate = 9600;
		sport.Open();
	}

	public void CloseCOM()
	{
		output = 0;
		light.LightEnergy = 0;
		label.Text = "null";
		sport.Close();
	}

	public override void _PhysicsProcess(double delta)
	{

	}
}

public class Protocol
{
	public byte PacketAdress { get; private set; }
	public byte PacketType { get; private set; }
	public byte PacketVar1 { get; private set; }
	public byte PacketVar2 { get; private set; }

	public static Protocol Create (byte adress, byte type, byte var1, byte var2)
	{
		return new Protocol
		{
			PacketAdress = adress,
			PacketType = type,
			PacketVar1 = var1,
			PacketVar2 = var2
		};
	}

	/*public static Protocol Parse(byte[] packet)
	{
		if (packet.Length < 4)
		{
			return null;
		}
	}
	*/
}
