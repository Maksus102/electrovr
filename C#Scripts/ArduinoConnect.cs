using Godot;
using System;
using System.IO.Ports;
using System.Text;
using System.Globalization;
using System.Collections;
using System.Collections.Generic;

public partial class ArduinoConnect : Label3D
{
	SerialPort sport;
	int output;

	string output_name = "HZ";

	public override void _Ready()
	{
		sport = new SerialPort();
		sport.PortName = "COM4";
		sport.BaudRate = 9600;
		sport.Open();

	}

	public override void _Process(double delta)
	{
		try
		{
			if (!sport.IsOpen) return;
			byte[] mess = { 0x1 };
            sport.Write(mess,0,1);
            string sermess = sport.ReadLine();
            output = int.Parse(sermess, CultureInfo.InvariantCulture.NumberFormat);
			base.Text = sermess;
		}
		catch (Exception ex )
		{
			
		}
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
