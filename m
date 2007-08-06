From: Michael Sedkowski <sedmich@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Tue, 07 Aug 2007 00:18:18 +0200
Message-ID: <1186438698.4402.6.camel@nx6310>
References: <838f88840708051428p3d65ff42w627af4bc38f57de3@mail.gmail.com>
	 <1186411815.4355.7.camel@nx6310>
	 <20070806150159.GC31615@khazad-dum.debian.net>
	 <200708061732.03425.rjw@sisk.pl>  <46B75459.9020204@gmail.com>
	 <1186424492.4355.1.camel@nx6310>  <46B76BBC.9010107@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-t2eGx1q4Z+KfnHIAkv8x"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <46B76BBC.9010107@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


--=-t2eGx1q4Z+KfnHIAkv8x
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Dnia 07-08-2007, Wt o godzinie 03:43 +0900, Tejun Heo napisał(a):
> Does emergency unload count increase
> after each power down? 

I think I got it.
Using smartctl I've done a test and shut down, then repeted the test.
The only values that where diffrent are temperatures and
Hardware_ECC_Recovered which rised by 6 points.
However I have no idea which of those is the "emergency count"...
Full results in attachment.

Regards,
Michael

--=-t2eGx1q4Z+KfnHIAkv8x
Content-Disposition: attachment; filename=test
Content-Type: text/plain; name=test; charset=utf-8
Content-Transfer-Encoding: 7bit

ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   117   100   006    Pre-fail  Always       -       126411939
  3 Spin_Up_Time            0x0002   095   094   000    Old_age   Always       -       0
  4 Start_Stop_Count        0x0033   098   098   020    Pre-fail  Always       -       2340
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   081   060   030    Pre-fail  Always       -       135278157
  9 Power_On_Hours          0x0032   096   096   000    Old_age   Always       -       3940
 10 Spin_Retry_Count        0x0013   100   100   034    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0033   099   099   020    Pre-fail  Always       -       1643
187 Unknown_Attribute       0x0032   100   100   000    Old_age   Always       -       0
189 Unknown_Attribute       0x003a   100   100   000    Old_age   Always       -       0
190 Temperature_Celsius     0x0022   056   049   045    Old_age   Always       -       757727276
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       388
193 Load_Cycle_Count        0x0032   075   075   000    Old_age   Always       -       51636
194 Temperature_Celsius     0x0022   044   051   000    Old_age   Always       -       44 (Lifetime Min/Max 0/8)
195 Hardware_ECC_Recovered  0x001a   063   050   000    Old_age   Always       -       68925016
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offline      -       0
202 TA_Increase_Count       0x0032   100   253   000    Old_age   Always       -	0

After shut down:

ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   117   100   006    Pre-fail  Always       -       126411939
  3 Spin_Up_Time            0x0002   095   094   000    Old_age   Always       -       0
  4 Start_Stop_Count        0x0033   098   098   020    Pre-fail  Always       -       2342
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   081   060   030    Pre-fail  Always       -       135286288
  9 Power_On_Hours          0x0032   096   096   000    Old_age   Always       -       3940
 10 Spin_Retry_Count        0x0013   100   100   034    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0033   099   099   020    Pre-fail  Always       -       1644
187 Unknown_Attribute       0x0032   100   100   000    Old_age   Always       -       0
189 Unknown_Attribute       0x003a   100   100   000    Old_age   Always       -       0
190 Temperature_Celsius     0x0022   057   049   045    Old_age   Always       -       724172843
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       388
193 Load_Cycle_Count        0x0032   075   075   000    Old_age   Always       -       51638
194 Temperature_Celsius     0x0022   043   051   000    Old_age   Always       -       43 (Lifetime Min/Max 0/8)
195 Hardware_ECC_Recovered  0x001a   069   050   000    Old_age   Always       -       71918457
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offline      -       0
202 TA_Increase_Count       0x0032   100   253   000    Old_age   Always       -       0


--=-t2eGx1q4Z+KfnHIAkv8x--

