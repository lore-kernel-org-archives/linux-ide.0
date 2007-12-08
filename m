From: "Matheus Izvekov" <mizvekov@gmail.com>
Subject: Re: AHCI + ST3160023AS + NCQ problems
Date: Fri, 7 Dec 2007 22:39:55 -0200
Message-ID: <305c16960712071639x50a78699pbfc0b9d9c7501b96@mail.gmail.com>
References: <305c16960710291713v22875d26v8ccfc76daab102bd@mail.gmail.com>
	 <47270CE9.4060501@msgid.tls.msk.ru>
	 <311601c90710300615j33bf0959l51b1b2505e9b2048@mail.gmail.com>
	 <472788F4.60300@msgid.tls.msk.ru>
	 <305c16960710301728j557689a5rbec52a11ec606963@mail.gmail.com>
	 <305c16960711062221u69e8eb37p1367b18343d0e2a5@mail.gmail.com>
	 <4737C2C0.10905@gmail.com>
	 <305c16960712071254n5d78b293if8d5ba2879a66b4a@mail.gmail.com>
	 <4759DC85.8000100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:36000 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbXLHAj4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Dec 2007 19:39:56 -0500
Received: by rv-out-0910.google.com with SMTP id k20so882334rvb
        for <linux-ide@vger.kernel.org>; Fri, 07 Dec 2007 16:39:55 -0800 (PST)
In-Reply-To: <4759DC85.8000100@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, "Eric D. Mudama" <edmudama@gmail.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com

On Dec 7, 2007 9:51 PM, Tejun Heo <htejun@gmail.com> wrote:
> Matheus Izvekov wrote:
> >> * unstable power supply (this is quite common)
> >> * faulty cable or poorly seated connectors
> >> * faulty drive or controller (seems rare)
> >
> > Tried everything, short of trying the hd on another controller, but
> > the problem persists.
>
> Weird, ICH7 + 7200.7 combination is very widely tested.  Can you please
> post the result of "hdparm -I /dev/sdX" and "smartctl -a /dev/sdX" where
> sdX is the offending drive?  So, if you connect the drive to a different
> port of the controller using a different cable, the problem follows the
> drive, right?
>
> Thanks.
>
> --
> tejun
>

Yes it follows the drive. I have another drive which is quite similiar
to the offending one, but has no NCQ so the problem doesnt apply. i
have another that is sata2 (has ncq) and shows no problem.

/dev/sdb:

ATA device, with non-removable media
	Model Number:       ST3160023AS
	Serial Number:      5MT02XNY
	Firmware Revision:  3.42
Standards:
	Used: ATA/ATAPI-6 T13 1410D revision 2
	Supported: 6 5 4
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  312581808
	device size with M = 1024*1024:      152627 MBytes
	device size with M = 1000*1000:      160041 MBytes (160 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Recommended acoustic management value: 254, current value: 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4
	     Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	SMART feature set
	    	Security Mode feature set
	   *	Power Management feature set
	   *	Write cache
	   *	Look-ahead
	   *	Host Protected Area feature set
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	DOWNLOAD_MICROCODE
	    	SET_MAX security extension
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	SATA-I signaling speed (1.5Gb/s)
	   *	Native Command Queueing (NCQ)
Security:
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct

smartctl version 5.37 [x86_64-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Barracuda 7200.7 and 7200.7 Plus family
Device Model:     ST3160023AS
Serial Number:    5MT02XNY
Firmware Version: 3.42
User Capacity:    160,041,885,696 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   6
ATA Standard is:  ATA/ATAPI-6 T13 1410D revision 2
Local Time is:    Fri Dec  7 22:36:15 2007 BRST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82)	Offline data collection activity
					was completed without error.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever
					been run.
Total time to complete Offline
data collection: 		 ( 430) seconds.
Offline data collection
capabilities: 			 (0x5b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					No Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					No General Purpose Logging support.
Short self-test routine
recommended polling time: 	 (   1) minutes.
Extended self-test routine
recommended polling time: 	 (  94) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   053   049   006    Pre-fail
Always       -       9124071
  3 Spin_Up_Time            0x0003   097   096   000    Pre-fail
Always       -       0
  4 Start_Stop_Count        0x0032   100   100   020    Old_age
Always       -       253
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail
Always       -       1
  7 Seek_Error_Rate         0x000f   087   060   030    Pre-fail
Always       -       576926517
  9 Power_On_Hours          0x0032   081   081   000    Old_age
Always       -       17263
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail
Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   020    Old_age
Always       -       329
194 Temperature_Celsius     0x0022   047   058   000    Old_age
Always       -       47 (Lifetime Min/Max 0/18)
195 Hardware_ECC_Recovered  0x001a   053   049   000    Old_age
Always       -       9124071
197 Current_Pending_Sector  0x0012   100   100   000    Old_age
Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age
Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age
Always       -       0
200 Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age
Offline      -       0
202 TA_Increase_Count       0x0032   100   253   000    Old_age
Always       -       0

SMART Error Log Version: 1
No Errors Logged

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
