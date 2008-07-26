From: "Ivan N. Zlatev" <contact@i-nz.net>
Subject: Seagate HDD Frequent Head Unload - hdparm/dmidecode/smartctl output
Date: Sat, 26 Jul 2008 16:34:06 +0300
Message-ID: <488B27CE.5060106@i-nz.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000206010909030407080205"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:31932 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbYGZNe2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jul 2008 09:34:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1821913fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 26 Jul 2008 06:34:26 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: teheo@suse.de

This is a multi-part message in MIME format.
--------------000206010909030407080205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I am having frequent head unloads on a Dell Vostro 1400 laptop with a 
Seagate HDD. As explained on the Wiki[1] I am attaching for you the 
output of:

    * hdparm -I
    * dmidecode
    * smartctl --all (in addition)

I hope this information is useful for you.

I am currently using a workaround to prevent the unloads as described 
here - http://en.opensuse.org/Disk_Power_Management .

[1] 
http://ata.wiki.kernel.org/index.php/Known_issues#Drives_which_perform_frequent_head_unloads_under_Linux

Kind Regards,
Ivan N. Zlatev


--------------000206010909030407080205
Content-Type: application/x-gzip;
 name="dmidecode-output.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmidecode-output.gz"

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
spJHgv8A0HaDifksAAA=
--------------000206010909030407080205
Content-Type: text/plain;
 name="hdparm-output"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdparm-output"


/dev/sda:

ATA device, with non-removable media
	Model Number:       ST9120822AS                             
	Serial Number:      5LZ6PF8E
	Firmware Revision:  3.CDD   
Standards:
	Supported: 7 6 5 4 
	Likely used: 8
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  234441648
	LBA48  user addressable sectors:  234441648
	device size with M = 1024*1024:      114473 MBytes
	device size with M = 1000*1000:      120034 MBytes (120 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 8
	Advanced power management level: 128
	Recommended acoustic management value: 128, current value: 0
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
	   *	Advanced Power Management feature set
	    	SET_MAX security extension
	    	Automatic Acoustic Management feature set
	   *	48-bit Address feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	IDLE_IMMEDIATE with UNLOAD
	   *	SATA-I signaling speed (1.5Gb/s)
	   *	Native Command Queueing (NCQ)
	   *	Phy event counters
	    	Device-initiated interface power management
	   *	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct

--------------000206010909030407080205
Content-Type: text/plain;
 name="smartctl-info-output"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smartctl-info-output"

smartctl 5.39 2008-05-08 21:56 [i686-pc-linux-gnu] (local build)
Copyright (C) 2002-8 by Bruce Allen, http://smartmontools.sourceforge.net

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Momentus 5400.3
Device Model:     ST9120822AS
Serial Number:    5LZ6PF8E
Firmware Version: 3.CDD
User Capacity:    120,034,123,776 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Sat Jul 26 16:27:38 2008 EEST
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
data collection: 		 ( 426) seconds.
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
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 ( 111) minutes.
SCT capabilities: 	       (0x0001)	SCT Status supported.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   106   100   006    Pre-fail  Always       -       11829174
  3 Spin_Up_Time            0x0003   099   099   085    Pre-fail  Always       -       0
  4 Start_Stop_Count        0x0032   100   100   020    Old_age   Always       -       361
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   076   060   030    Pre-fail  Always       -       49086662
  9 Power_On_Hours          0x0032   099   099   000    Old_age   Always       -       1662
 10 Spin_Retry_Count        0x0013   100   100   034    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   020    Old_age   Always       -       374
187 Reported_Uncorrect      0x0032   100   100   000    Old_age   Always       -       0
189 High_Fly_Writes         0x003a   096   096   000    Old_age   Always       -       4
190 Airflow_Temperature_Cel 0x0022   057   046   045    Old_age   Always       -       43 (Lifetime Min/Max 43/45)
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       278
193 Load_Cycle_Count        0x0032   097   097   000    Old_age   Always       -       6611
194 Temperature_Celsius     0x0022   043   054   000    Old_age   Always       -       43 (0 14 0 0)
195 Hardware_ECC_Recovered  0x001a   082   060   000    Old_age   Always       -       216850924
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offline      -       0
202 TA_Increase_Count       0x0032   100   253   000    Old_age   Always       -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%      1478         -
# 2  Short offline       Completed without error       00%         1         -
# 3  Short offline       Completed without error       00%         0         -
# 4  Short offline       Completed without error       00%         0         -

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


--------------000206010909030407080205--
