using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using Microsoft.Phone.Controls;
using System.Data;
using System.Xml.Linq;
using System.IO;

namespace Home
{
    public partial class MainPage : PhoneApplicationPage
    {
        public string ServerIPAddress = "10.0.0.55";
        // Constructor
        public MainPage()
        {
            InitializeComponent();          
        }

        private void LoadIPAddress()
       
        private void ButtonLoadDataClick(object sender, RoutedEventArgs e)
        {
            WebClient client = new WebClient();
	                    client.OpenReadCompleted += new OpenReadCompletedEventHandler(client_OpenReadCompleted);
	                    Uri url = new Uri("http://" + ServerIPAddress + "/index.php?nocache=" + Environment.TickCount, UriKind.Absolute);
                client.OpenReadAsync(url);

        }

        public void client_OpenReadCompleted(object sender, OpenReadCompletedEventArgs e)
        {
            try
            {
                var xml = XDocument.Load(e.Result);

                foreach (XElement xe in xml.Descendants("Data"))
                {
                    //MessageBox.Show(xe.Element("DataRow").Attribute("watertop").Value);
                    //decimal tmpdec = Convert.ToDecimal(xe.Attribute("watertop").Value);
                    TextBoxWaterTop.Text = (String)xe.Element("DataRow").Attribute("watertop").Value + "°";
                    TextBoxWaterBase.Text = (String)xe.Element("DataRow").Attribute("waterbase").Value + "°";
                    TextBoxWaterPanel.Text = (String)xe.Element("DataRow").Attribute("waterpanel").Value + "°";
                    TextBoxHomeTemp.Text = (String)xe.Element("DataRow").Attribute("hometemp").Value + "°";
                    TextBox1PVC.Text = (String)xe.Element("DataRow").Attribute("solarc").Value + "A";
                    TextBoxBatteryVolts.Text = (String)xe.Element("DataRow").Attribute("batteryv").Value + "V";
                    TextBoxGeneralC.Text = (String)xe.Element("DataRow").Attribute("generalc").Value + "A";
                    
                    TextBoxInverterC.Text = (String)xe.Element("DataRow").Attribute("inverterc").Value + "A";
                    TextBoxMainsC.Text = (String)xe.Element("DataRow").Attribute("mainsc").Value + "A";

                    if (xe.Element("DataRow").Attribute("pumprunning").Value.Equals("1"))
                    {
                        TextBoxPumpRunning.Text = "Yes";
                    }
                    else
                    {
                        TextBoxPumpRunning.Text = "No";
                    }

                    if (xe.Element("DataRow").Attribute("cHotWater").Value.Equals("1"))
                    {
                        radioHWOn.IsChecked = true;
                        radioHWOff.IsChecked = false;
                    }
                    else
                    {
                        radioHWOn.IsChecked = false;
                        radioHWOff.IsChecked = true;
                    }

                    if (xe.Element("DataRow").Attribute("cHeating").Value.Equals("1"))
                    {
                        radioCHOn.IsChecked = true;
                        radioCHOff.IsChecked = false;
                    }
                    else
                    {
                        radioCHOn.IsChecked = false;
                        radioCHOff.IsChecked = true;
                    }
                }
            }
            catch (Exception c)
            {
                MessageBox.Show(c.Message);
            }

        }
       
        // radio button code

        private void radioHWOnChecked(object sender, RoutedEventArgs e)
        {
            WebClient client = new WebClient();
            client.OpenReadCompleted += new OpenReadCompletedEventHandler(client_SendHeatingUpdate);
            Uri url = new Uri("http://" + ServerIPAddress + "/hwon.php?nocache=" + Environment.TickCount, UriKind.Absolute);
            client.OpenReadAsync(url);

        }
        private void radioHWOffChecked(object sender, RoutedEventArgs e)
        {
            WebClient client = new WebClient();
            client.OpenReadCompleted += new OpenReadCompletedEventHandler(client_SendHeatingUpdate);
            Uri url = new Uri("http://" + ServerIPAddress + "/hwoff.php?nocache=" + Environment.TickCount, UriKind.Absolute);
            client.OpenReadAsync(url);
        }
        private void radioCHOnChecked(object sender, RoutedEventArgs e)
        {
            WebClient client = new WebClient();
            client.OpenReadCompleted += new OpenReadCompletedEventHandler(client_SendHeatingUpdate);
            Uri url = new Uri("http://" + ServerIPAddress + "/chon.php?nocache=" + Environment.TickCount, UriKind.Absolute);
            client.OpenReadAsync(url);
        }
        private void radioCHOffChecked(object sender, RoutedEventArgs e)
        {
            WebClient client = new WebClient();
            client.OpenReadCompleted += new OpenReadCompletedEventHandler(client_SendHeatingUpdate);
            Uri url = new Uri("http://" + ServerIPAddress + "/choff.php?nocache=" + Environment.TickCount, UriKind.Absolute);
            client.OpenReadAsync(url);
        }


        public void client_SendHeatingUpdate(object sender, OpenReadCompletedEventArgs e)
        {


            Stream reply = null;
            StreamReader s = null;

            try
            {
                reply = (Stream)e.Result;
                s = new StreamReader(reply);
                txtoutput.Text = s.ReadToEnd();
              //  MessageBox.Show();
            }
            finally
            {
                if (s != null)
                {
                    s.Close();
                }

                if (reply != null)
                {
                    reply.Close();
                }
            }


        }

    }


}