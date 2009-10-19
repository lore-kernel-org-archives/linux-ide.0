From: Jan Christoph Uhde <UhdeJC@gmx.net>
Subject: disk with ata_piix freezes
Date: Mon, 19 Oct 2009 12:12:12 +0200
Message-ID: <4ADC3B7C.2070207@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:57832 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750883AbZJSKMI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Oct 2009 06:12:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,
my net-book suffers serious disk freezes. I am using the ata_piix driver fom 
the latest ubuntu karmic kernel and have tried almost everything i could find 
.. every kernel option from force_pcs to .. acpi=.+ , pci=.+
and i would really like to keep acpi .. :(

Since google will not help this time i will ask here for help:


ata port 1 device 0
action = 0x6			i am to stupid to read the acton from libata.h:(

exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
	cmd ca/00:28:67:b5:7e/00:00:00:00:00/e0 tag 0 dma 20480 out
	res 40/00:00:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
status: { DRDY }

I am willing to give you any information you request. but please keep in mind 
that i am a stupid user and may need some time or might fail without proper 
description on how to acquire the data.


The Problem:
dmesg | grep ata -A1   #A1 for the res line


[ 3143.592481] ata2: port disabled. ignoring.
[ 3143.592645] ata_piix 0000:00:1f.2: PCI INT B disabled
[ 3143.608280] ehci_hcd 0000:00:1d.7: PCI INT A disabled
--
[ 3144.210084] ata_piix 0000:00:1f.2: restoring config space at offset 0xf 
(was 0x200, writing 0x2ff)
[ 3144.210213] ath9k 0000:02:00.0: restoring config space at offset 0xf (was 
0x1ff, writing 0x10b)
--
[ 3144.307572] ata_piix 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[ 3144.307581] ata_piix 0000:00:1f.2: setting latency timer to 64
[ 3144.307624] ath9k 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
--
[ 3145.596412] ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 filtered out
[ 3145.596420] ata1.00: ACPI cmd ef/03:45:00:00:00:a0 filtered out
[ 3145.728444] ata1.00: configured for UDMA/100
[ 3145.856038] usb 1-8: reset high speed USB device using ehci_hcd and address 3
--
[ 3346.989164] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 3346.989463] ata1.00: cmd ca/00:28:67:b5:7e/00:00:00:00:00/e0 tag 0 dma 
20480 out
[ 3346.989470]          res 40/00:00:00:00:00/00:00:00:00:00/40 Emask 0x4 
(timeout)
[ 3346.990072] ata1.00: status: { DRDY }
[ 3352.032100] ata1: link is slow to respond, please be patient (ready=0)
[ 3357.016139] ata1: device not ready (errno=-16), forcing hardreset
[ 3357.016168] ata1: soft resetting link
[ 3357.196609] ata1.00: configured for UDMA/100
[ 3357.196631] ata1.00: device reported invalid CHS sector 0
[ 3357.196664] ata1: EH complete
[ 3719.768899] wlan2: deauthenticated from 00:1f:1f:52:d6:b4 (Reason: 7)
--
[13235.976559] ata_piix 0000:00:1f.2: PCI INT B disabled
[13235.992311] ehci_hcd 0000:00:1d.7: PCI INT A disabled
--
[13236.686088] ata_piix 0000:00:1f.2: restoring config space at offset 0xf 
(was 0x200, writing 0x2ff)
[13236.686216] ath9k 0000:02:00.0: restoring config space at offset 0xf (was 
0x1ff, writing 0x10b)
--
[13236.784226] ata_piix 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[13236.784235] ata_piix 0000:00:1f.2: setting latency timer to 64
[13236.784278] ath9k 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
--
[13237.960411] ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 filtered out
[13237.960419] ata1.00: ACPI cmd ef/03:45:00:00:00:a0 filtered out
[13237.972443] ata1.00: configured for UDMA/100
[13238.228035] usb 1-8: reset high speed USB device using ehci_hcd and address 3
--
[13513.988222] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[13513.988263] ata1.00: cmd ca/00:08:07:93:47/00:00:00:00:00/e0 tag 0 dma 4096 out
[13513.988270]          res 40/00:00:00:00:00/00:00:00:00:00/40 Emask 0x4 
(timeout)
[13513.988285] ata1.00: status: { DRDY }
[13519.028142] ata1: link is slow to respond, please be patient (ready=0)
[13524.012128] ata1: device not ready (errno=-16), forcing hardreset
[13524.012153] ata1: soft resetting link
[13524.192688] ata1.00: configured for UDMA/100
[13524.192710] ata1.00: device reported invalid CHS sector 0
[13524.192743] ata1: EH complete
[13881.114281] wlan2: deauthenticated from 00:1f:1f:52:d6:b4 (Reason: 7)
--
[15405.912548] ata_piix 0000:00:1f.2: PCI INT B disabled
[15405.928318] ehci_hcd 0000:00:1d.7: PCI INT A disabled
--
[15406.626088] ata_piix 0000:00:1f.2: restoring config space at offset 0xf 
(was 0x200, writing 0x2ff)
[15406.626215] ath9k 0000:02:00.0: restoring config space at offset 0xf (was 
0x1ff, writing 0x10b)
--
[15406.723533] ata_piix 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[15406.723542] ata_piix 0000:00:1f.2: setting latency timer to 64
[15406.723587] ath9k 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
--
[15407.900411] ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 filtered out
[15407.900419] ata1.00: ACPI cmd ef/03:45:00:00:00:a0 filtered out
[15407.912454] ata1.00: configured for UDMA/100
[15408.044037] usb 1-8: reset high speed USB device using ehci_hcd and address 3
--
[15696.000177] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[15696.005305] ata1.00: cmd c8/00:08:7f:a9:11/00:00:00:00:00/e0 tag 0 dma 4096 in
[15696.005313]          res 40/00:00:00:00:00/00:00:00:00:00/40 Emask 0x4 
(timeout)
[15696.016463] ata1.00: status: { DRDY }
[15696.412148] ata1: soft resetting link
[15696.592651] ata1.00: configured for UDMA/100
[15696.592674] ata1.00: device reported invalid CHS sector 0
[15696.592708] ata1: EH complete
[15870.282772] wlan2: deauthenticated from 00:1f:1f:52:d6:b4 (Reason: 7)
--
[16719.572551] ata_piix 0000:00:1f.2: PCI INT B disabled
[16719.588308] ehci_hcd 0000:00:1d.7: PCI INT A disabled
--
[16720.286085] ata_piix 0000:00:1f.2: restoring config space at offset 0xf 
(was 0x200, writing 0x2ff)
[16720.286213] ath9k 0000:02:00.0: restoring config space at offset 0xf (was 
0x1ff, writing 0x10b)
--
[16720.383723] ata_piix 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[16720.383731] ata_piix 0000:00:1f.2: setting latency timer to 64
[16720.383774] ath9k 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
--
[16721.560412] ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 filtered out
[16721.560420] ata1.00: ACPI cmd ef/03:45:00:00:00:a0 filtered out
[16721.572444] ata1.00: configured for UDMA/100
[16721.832036] usb 1-8: reset high speed USB device using ehci_hcd and address 3
--
[16996.988325] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[16996.994787] ata1.00: cmd ca/00:08:cf:71:05/00:00:00:00:00/e9 tag 0 dma 4096 out
[16996.994798]          res 40/00:00:00:00:00/00:00:00:00:00/40 Emask 0x4 
(timeout)
[16997.009313] ata1.00: status: { DRDY }
[17002.056161] ata1: link is slow to respond, please be patient (ready=0)
[17007.040288] ata1: device not ready (errno=-16), forcing hardreset
[17007.040313] ata1: soft resetting link
[17007.220787] ata1.00: configured for UDMA/100
[17007.220809] ata1.00: device reported invalid CHS sector 0
[17007.220842] ata1: EH complete
[17430.764604] CPU0 attaching NULL sched-domain.
--
[17433.308547] ata_piix 0000:00:1f.2: PCI INT B disabled
[17433.324312] ehci_hcd 0000:00:1d.7: PCI INT A disabled
--
[17434.018090] ata_piix 0000:00:1f.2: restoring config space at offset 0xf 
(was 0x200, writing 0x2ff)
[17434.018217] ath9k 0000:02:00.0: restoring config space at offset 0xf (was 
0x1ff, writing 0x10b)
--
[17434.115146] ata_piix 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[17434.115155] ata_piix 0000:00:1f.2: setting latency timer to 64
[17434.115199] ath9k 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
--
[17435.348411] ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 filtered out
[17435.348419] ata1.00: ACPI cmd ef/03:45:00:00:00:a0 filtered out
[17435.472448] ata1.00: configured for UDMA/100
[17435.608036] usb 1-8: reset high speed USB device using ehci_hcd and address 3
--
[17711.988348] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[17711.988390] ata1.00: cmd ca/00:08:a7:2c:00/00:00:00:00:00/e0 tag 0 dma 4096 out
[17711.988397]          res 40/00:00:00:00:00/00:00:00:00:00/40 Emask 0x4 
(timeout)
[17711.988411] ata1.00: status: { DRDY }
[17717.028259] ata1: link is slow to respond, please be patient (ready=0)
[17722.016309] ata1: device not ready (errno=-16), forcing hardreset
[17722.016334] ata1: soft resetting link
[17722.196824] ata1.00: configured for UDMA/100
[17722.196846] ata1.00: device reported invalid CHS sector 0
[17722.196880] ata1: EH complete
[19580.466508] CPU0 attaching NULL sched-domain.
--
[19582.924596] ata_piix 0000:00:1f.2: PCI INT B disabled
[19582.940315] ehci_hcd 0000:00:1d.7: PCI INT A disabled
--
[19583.690087] ata_piix 0000:00:1f.2: restoring config space at offset 0xf 
(was 0x200, writing 0x2ff)
[19583.690211] ath9k 0000:02:00.0: restoring config space at offset 0xf (was 
0x1ff, writing 0x10b)
--
[19583.787602] ata_piix 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[19583.787611] ata_piix 0000:00:1f.2: setting latency timer to 64
[19583.787655] ath9k 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
--
[19585.020411] ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 filtered out
[19585.020419] ata1.00: ACPI cmd ef/03:45:00:00:00:a0 filtered out
[19585.144449] ata1.00: configured for UDMA/100
[19585.276036] usb 1-8: reset high speed USB device using ehci_hcd and address 3
--
[19857.989316] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[19857.989357] ata1.00: cmd ca/00:08:f7:32:73/00:00:00:00:00/e0 tag 0 dma 4096 out
[19857.989364]          res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 
(timeout)
[19857.989378] ata1.00: status: { DRDY }
[19863.037122] ata1: link is slow to respond, please be patient (ready=0)
[19868.037107] ata1: device not ready (errno=-16), forcing hardreset
[19868.037138] ata1: soft resetting link
[19868.217826] ata1.00: configured for UDMA/100
[19868.217849] ata1.00: device reported invalid CHS sector 0
[19868.217884] ata1: EH complete
[19977.239338] wlan2: deauthenticated from 00:1f:1f:52:d6:b4 (Reason: 7)

What smart says:
smartctl version 5.38 [i686-pc-linux-gnu] Copyright (C) 2002-8 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     FUJITSU MHZ2160BH G2
Serial Number:    K62TT982MYCW
Firmware Version: 008B000B
User Capacity:    160,041,885,696 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   8
ATA Standard is:  ATA-8-ACS revision 3f
Local Time is:    Mon Oct 19 11:12:26 2009 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00)	Offline data collection activity
					was never started.
					Auto Offline Data Collection: Disabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever
					been run.
Total time to complete Offline
data collection: 		 ( 649) seconds.
Offline data collection
capabilities: 			 (0x7b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					General Purpose Logging supported.
Short self-test routine
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 (  92) minutes.
Conveyance self-test routine
recommended polling time: 	 (   2) minutes.
SCT capabilities: 	       (0x003d)	SCT Status supported.
					SCT Feature Control supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED 
WHEN_FAILED RAW_VALUE
   1 Raw_Read_Error_Rate     0x000f   100   100   046    Pre-fail  Always 
   -       43102
   2 Throughput_Performance  0x0005   100   100   030    Pre-fail  Offline 
   -       27721728
   3 Spin_Up_Time            0x0003   100   100   025    Pre-fail  Always 
   -       1
   4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always 
   -       132
   5 Reallocated_Sector_Ct   0x0033   100   100   024    Pre-fail  Always 
   -       8589934592000
   7 Seek_Error_Rate         0x000f   100   100   047    Pre-fail  Always 
   -       552
   8 Seek_Time_Performance   0x0005   100   100   019    Pre-fail  Offline 
   -       0
   9 Power_On_Hours          0x0032   100   100   000    Old_age   Always 
   -       57
  10 Spin_Retry_Count        0x0013   100   100   020    Pre-fail  Always 
   -       0
  12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always 
   -       60
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always 
  -       8
193 Load_Cycle_Count        0x0032   100   100   000    Old_age   Always 
  -       1191
194 Temperature_Celsius     0x0022   100   100   000    Old_age   Always 
  -       28 (Lifetime Min/Max 18/48)
195 Hardware_ECC_Recovered  0x001a   100   100   000    Old_age   Always 
  -       18
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always 
  -       440729600
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always 
  -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline 
  -       0
199 UDMA_CRC_Error_Count    0x003e   200   253   000    Old_age   Always 
  -       20
200 Multi_Zone_Error_Rate   0x000f   100   100   060    Pre-fail  Always 
  -       24862
203 Run_Out_Cancel          0x0002   100   100   000    Old_age   Always 
  -       1529028411460
240 Head_Flying_Hours       0x003e   200   200   000    Old_age   Always 
  -       0

SMART Error Log Version: 1
ATA Error Count: 20 (device log contains only the most recent five errors)
	CR = Command Register [HEX]
	FR = Features Register [HEX]
	SC = Sector Count Register [HEX]
	SN = Sector Number Register [HEX]
	CL = Cylinder Low Register [HEX]
	CH = Cylinder High Register [HEX]
	DH = Device/Head Register [HEX]
	DC = Device Command Register [HEX]
	ER = Error register [HEX]
	ST = Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=days, hh=hours, mm=minutes,
SS=sec, and sss=millisec. It "wraps" after 49.710 days.

Error 20 occurred at disk power-on lifetime: 55 hours (2 days + 7 hours)
   When the command that caused the error occurred, the device was active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   84 51 05 82 a9 11 e0  Error: ICRC, ABRT 5 sectors at LBA = 0x0011a982 = 1157506

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 08 7f a9 11 e0 08      00:04:19.791  READ DMA
   ef 10 03 9e 3e 05 a0 08      00:04:11.675  SET FEATURES [Reserved for 
Serial ATA]
   ea 00 00 9e 3e 05 a0 08      00:04:08.477  FLUSH CACHE EXIT
   ca 00 08 97 3e 05 e9 08      00:04:08.476  WRITE DMA
   ea 00 00 96 3e 05 a0 08      00:04:08.370  FLUSH CACHE EXIT

Error 19 occurred at disk power-on lifetime: 51 hours (2 days + 3 hours)
   When the command that caused the error occurred, the device was active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   84 51 1d 42 d0 2c e0  Error: ICRC, ABRT 29 sectors at LBA = 0x002cd042 = 
2936898

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 20 3f d0 2c e0 08      00:17:38.198  READ DMA
   ef 10 03 e6 22 04 a0 08      00:17:33.495  SET FEATURES [Reserved for 
Serial ATA]
   ea 00 00 e6 22 04 a0 08      00:17:31.033  FLUSH CACHE EXIT
   ca 00 08 df 22 04 e9 08      00:17:31.032  WRITE DMA
   ea 00 00 de 22 04 a0 08      00:17:30.907  FLUSH CACHE EXIT

Error 18 occurred at disk power-on lifetime: 46 hours (1 days + 22 hours)
   When the command that caused the error occurred, the device was active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   84 51 05 7a 54 23 e0  Error: ICRC, ABRT 5 sectors at LBA = 0x0023547a = 2315386

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 08 77 54 23 e0 08      00:23:38.596  READ DMA
   ef 10 03 ce 15 04 a0 08      00:23:21.392  SET FEATURES [Reserved for 
Serial ATA]
   ea 00 00 ce 15 04 a0 08      00:23:19.057  FLUSH CACHE EXIT
   ca 00 08 c7 15 04 e9 08      00:23:19.057  WRITE DMA
   ea 00 00 c6 15 04 a0 08      00:23:18.931  FLUSH CACHE EXIT

Error 17 occurred at disk power-on lifetime: 35 hours (1 days + 11 hours)
   When the command that caused the error occurred, the device was active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   84 51 75 6a 7f 32 e0  Error: ICRC, ABRT 117 sectors at LBA = 0x00327f6a = 
3309418

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 78 67 7f 32 e0 08      00:11:59.470  READ DMA
   ef 10 03 5e 65 32 a0 08      00:11:58.476  SET FEATURES [Reserved for 
Serial ATA]
   c8 00 08 57 65 32 e0 08      00:11:57.847  READ DMA
   c8 00 08 6f 65 32 e0 08      00:11:56.337  READ DMA
   c8 00 20 3f 81 09 e0 08      00:11:56.076  READ DMA

Error 16 occurred at disk power-on lifetime: 34 hours (1 days + 10 hours)
   When the command that caused the error occurred, the device was active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   84 51 bd 42 eb 15 e0  Error: ICRC, ABRT 189 sectors at LBA = 0x0015eb42 = 
1436482

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 c0 3f eb 15 e0 08      00:45:20.835  READ DMA
   ef 10 03 3e 91 20 a0 08      00:45:20.545  SET FEATURES [Reserved for 
Serial ATA]
   c8 00 08 37 91 20 e0 08      00:45:19.443  READ DMA
   c8 00 10 f7 4a 42 e2 08      00:45:19.381  READ DMA
   c8 00 08 cf a8 11 e0 08      00:45:19.351  READ DMA

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]


SMART Selective self-test log data structure revision number 1
  SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
     1        0        0  Not_testing
     2        0        0  Not_testing
     3        0        0  Not_testing
     4        0        0  Not_testing
     5        0        0  Not_testing
Selective self-test flags (0x0):
   After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.


lspci:


00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) SATA IDE 
Controller (rev 02) (prog-if 80 [Master])
	Subsystem: Samsung Electronics Co Ltd Device c062
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx+
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=1]
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374 [size=1]
	Region 4: I/O ports at 1810 [size=16]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ata_piix





00:00.0 Host bridge: Intel Corporation Mobile 945GME Express Memory Controller 
Hub (rev 03)
	Subsystem: Samsung Electronics Co Ltd Device c062
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information <?>
	Kernel driver in use: agpgart-intel
	Kernel modules: intel-agp

00:02.0 VGA compatible controller: Intel Corporation Mobile 945GME Express 
Integrated Graphics Controller (rev 03)
	Subsystem: Samsung Electronics Co Ltd Device c062
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=512K]
	Region 1: I/O ports at 1800 [size=8]
	Region 2: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Region 3: Memory at f0200000 (32-bit, non-prefetchable) [size=256K]
	Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: i915
	Kernel modules: i915

00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/GME, 943/940GML 
Express Integrated Graphics Controller (rev 03)
	Subsystem: Samsung Electronics Co Ltd Device c062
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at f0080000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition 
Audio Controller (rev 02)
	Subsystem: Samsung Electronics Co Ltd Device c062
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at f0440000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 
<1us
			ClockPM- Suprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- 
ABWMgmt-
	Capabilities: [100] Virtual Channel <?>
	Capabilities: [130] Root Complex Link <?>
	Kernel driver in use: HDA Intel
	Kernel modules: snd-hda-intel

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 
(rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Memory behind bridge: f0100000-f01fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 
<4us
			ClockPM- Suprise- LLActRep+ BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- 
ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
			Slot #  2, PowerLimit 6.500000; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
		Address: fee0100c  Data: 4159
	Capabilities: [90] Subsystem: Samsung Electronics Co Ltd Device c062
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel <?>
	Capabilities: [180] Root Complex Link <?>
	Kernel driver in use: pcieport-driver
	Kernel modules: shpchp

00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 
(rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: 80000000-800fffff
	Prefetchable memory behind bridge: 00000000f0500000-00000000f05fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 
<4us
			ClockPM- Suprise- LLActRep+ BwNot-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- 
ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
			Slot #  4, PowerLimit 6.500000; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
		Address: fee0100c  Data: 4161
	Capabilities: [90] Subsystem: Samsung Electronics Co Ltd Device c062
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel <?>
	Capabilities: [180] Root Complex Link <?>
	Kernel driver in use: pcieport-driver
	Kernel modules: shpchp

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
Controller #1 (rev 02)
	Subsystem: Samsung Electronics Co Ltd Device c062
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 4: I/O ports at 1820 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
Controller #2 (rev 02)
	Subsystem: Samsung Electronics Co Ltd Device c062
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at 1840 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
Controller #3 (rev 02)
	Subsystem: Samsung Electronics Co Ltd Device c062
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 20
	Region 4: I/O ports at 1860 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
Controller #4 (rev 02)
	Subsystem: Samsung Electronics Co Ltd Device c062
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin D routed to IRQ 16
	Region 4: I/O ports at 1880 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI 
Controller (rev 02) (prog-if 20)
	Subsystem: Samsung Electronics Co Ltd Device c062
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at f0444000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Kernel driver in use: ehci_hcd

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2) 
(prog-if 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Subsystem: Samsung Electronics Co Ltd Device c062

00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge 
(rev 02)
	Subsystem: Samsung Electronics Co Ltd Device c062
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information <?>
	Kernel modules: iTCO_wdt, intel-rng


00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)
	Subsystem: Samsung Electronics Co Ltd Device c062
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 18a0 [size=32]
	Kernel modules: i2c-i801

02:00.0 Network controller: Atheros Communications Inc. AR9285 Wireless 
Network Adapter (PCI-Express) (rev 01)
	Subsystem: Askey Computer Corp. Device 7167
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f0100000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [60] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 
<64us
			ClockPM- Suprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- 
ABWMgmt-
	Capabilities: [100] Advanced Error Reporting <?>
	Capabilities: [140] Virtual Channel <?>
	Capabilities: [160] Device Serial Number 12-14-24-ff-ff-17-15-00
	Capabilities: [170] Power Budgeting <?>
	Kernel driver in use: ath9k
	Kernel modules: ath9k

03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8101E/RTL8102E 
PCI Express Fast Ethernet controller (rev 02)
	Subsystem: Samsung Electronics Co Ltd Device c062
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 26
	Region 0: I/O ports at 2000 [size=256]
	Region 2: Memory at f0510000 (64-bit, prefetchable) [size=4K]
	Region 4: Memory at f0500000 (64-bit, prefetchable) [size=64K]
	[virtual] Expansion ROM at f0520000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable+
		Address: 00000000fee0100c  Data: 4189
	Capabilities: [70] Express (v2) Endpoint, MSI 01
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 
<64us
			ClockPM+ Suprise- LLActRep- BwNot-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- 
ABWMgmt-
	Capabilities: [ac] MSI-X: Enable- Mask- TabSize=2
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00000800
	Capabilities: [cc] Vital Product Data <?>
	Capabilities: [100] Advanced Error Reporting <?>
	Capabilities: [140] Virtual Channel <?>
	Capabilities: [160] Device Serial Number 00-00-00-00-00-00-00-01
	Kernel driver in use: r8169
	Kernel modules: r8169


