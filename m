From: Ansgar Knappheide <ansgar.knappheide@gmx.de>
Subject: Re: libata interface fatal error
Date: Mon, 18 Jun 2007 19:14:56 +0200
Message-ID: <4676BD90.307@gmx.de>
References: <200706180705.l5I75U6r000348@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42436 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753899AbXFRRNL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Jun 2007 13:13:11 -0400
In-Reply-To: <200706180705.l5I75U6r000348@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Mikael Pettersson schrieb:
> On Mon, 18 Jun 2007 15:28:44 +0900, Tejun Heo wrote:
>   
>> Yeah, it seems promise has some problem with 3G link.  Cc'ing Mikael
>> Pettersson and quoting whole body for him.  Mikael, does this look familiar?
>>
>> Tomi Orava wrote:
>>     
>>> Hi Tejun,
>>>
>>> I've been trying to find a solution for a long time for quite a similar
>>> libata errror messages as shown in this thread. Perhaps you might get have
>>> some ideas what the actual originator might be:
>>>
>>> With the latest 2.6.22-rc4-git4 kernel I still get the following error
>>> messages
>>> with high I/O load:
>>>
>>> sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
>>> sd 2:0:0:0: [sdc] Write Protect is off
>>> sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
>>> sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
>>> support DPO or FUA
>>> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
>>> ata3.00: (port_status 0x20080000)
>>> ata3.00: cmd c8/00:08:af:91:49/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
>>>          res 50/00:00:b6:91:49/00:00:11:00:00/e5 Emask 0x2 (HSM violation)
>>> ata3: soft resetting port
>>> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>> ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
>>> ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
>>> ata3.00: configured for UDMA/133
>>> ata3: EH complete
>>>
>>> ... and later in the chain ...
>>>
>>> sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
>>> sd 2:0:0:0: [sdc] Write Protect is off
>>> sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
>>> sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
>>> support DPO or FUA
>>> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
>>> ata3.00: (port_status 0x20080000)
>>> ata3.00: cmd c8/00:08:67:74:65/00:00:00:00:00/ec tag 0 cdb 0x0 data 4096 in
>>>          res 50/00:00:6e:74:65/00:00:1b:00:00/ec Emask 0x2 (HSM violation)
>>> ata3: soft resetting port
>>> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>>> ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
>>> ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
>>> ata3.00: configured for UDMA/100
>>> ata3: EH complete
>>>
>>> --- This goes on until UDMA/33 has been reched
>>>       
> ...
>   
>>> and the problems relate only to Seagate 7200.10 SATA-disks, never with the
>>> older 7200.7 SATA-disks alll connected to Promise Sata 300TX4-controller.
>>>       
> ...
>   
>>> PS. These problems are not special to this single machine as a friend at work
>>>       has the same Promise Sata300TX4 card with exactly the same Seagate
>>> 7200.10
>>>       SATA-disks on an intel-based P4 machine with similar problems under
>>> I/O-load.
>>>       
>
> Yes, this is familiar. Several people have reported problems with
> Seagate's 7200.10 disks in 3Gbps operation on sata_promise.
> Unfortunately the error reports don't really give a clue as to what
> the root cause is.
>
> I used to be able to forcibly trigger similar errors with their
> 7200.9 disks, but I can't seem to do that any more.
>
>   
Hello,

I'm jumping in this thread, because I'm seeing the same probleme on my 
system with Promise SATAII 150 TX4 (PDC40518) and harddrive Maxtor 
6L200M0 (BANC1E00) with following error

Jun 18 01:16:03 buffy kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x2
Jun 18 01:16:03 buffy kernel: ata1.00: (port_status 0x20080000)
Jun 18 01:16:03 buffy kernel: ata1.00: cmd 
c8/00:15:e1:e3:16/00:00:00:00:00/e6 tag 0 cdb 0x0 data 10752 in
Jun 18 01:16:03 buffy kernel:          res 
50/00:00:f5:e3:16/00:00:00:00:00/e6 Emask 0x2 (HSM violation)
Jun 18 01:16:03 buffy kernel: ata1: soft resetting port
Jun 18 01:16:03 buffy kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 
SControl 300)
Jun 18 01:16:03 buffy kernel: ata1.00: ata_hpa_resize 1: sectors = 
398297088, hpa_sectors = 398297088
Jun 18 01:16:03 buffy kernel: ata1.00: ata_hpa_resize 1: sectors = 
398297088, hpa_sectors = 398297088
Jun 18 01:16:03 buffy kernel: ata1.00: configured for UDMA/133
Jun 18 01:16:03 buffy kernel: sd 0:0:0:0: [sda] Result: hostbyte=0x00 
driverbyte=0x08
Jun 18 01:16:03 buffy kernel: sd 0:0:0:0: [sda] Sense Key : 0xb 
[current] [descriptor]
Jun 18 01:16:03 buffy kernel: Descriptor sense data with sense 
descriptors (in hex):
Jun 18 01:16:03 buffy kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 
00 00 00 00 00
Jun 18 01:16:03 buffy kernel:         06 16 e3 f5
Jun 18 01:16:03 buffy kernel: sd 0:0:0:0: [sda] ASC=0x0 ASCQ=0x0
Jun 18 01:16:03 buffy kernel: end_request: I/O error, dev sda, sector 
102163425
Jun 18 01:16:03 buffy kernel: ata1: EH complete
Jun 18 01:16:03 buffy kernel: sd 0:0:0:0: [sda] 398297088 512-byte 
hardware sectors (203928 MB)
Jun 18 01:16:03 buffy kernel: sd 0:0:0:0: [sda] Write Protect is off
Jun 18 01:16:03 buffy kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Jun 18 01:16:03 buffy kernel: sd 0:0:0:0: [sda] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA

On normal use this error shows up only once a week, but when transfering 
lot of data (> 100MB) to USB-Stick that error shows every few seconds 
with only different values for data. When transfering data from 
USB-Stick to harddrive no error shows.

Other information on my system:

smartctl -d sat -a /dev/sda
smartctl version 5.38 [i686-suse-linux] Copyright (C) 2002-7 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Maxtor DiamondMax 10 family (ATA/133 and SATA/150)
Device Model:     Maxtor 6L200M0
Serial Number:    L40A4PDH
Firmware Version: BANC1E00
User Capacity:    203.928.109.056 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 0
Local Time is:    Mon Jun 18 19:11:50 2007 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

Warning! SMART Attribute Thresholds Structure error: invalid SMART checksum.
=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x02) Offline data collection activity
                                        was completed without error.
                                        Auto Offline Data Collection: 
Disabled.
Self-test execution status:      (   0) The previous self-test routine 
completed
                                        without error or no self-test 
has ever
                                        been run.
Total time to complete Offline
data collection:                 (1562) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                        Auto Offline data collection 
on/off support.
                                        Suspend Offline collection upon new
                                        command.
                                        Offline surface scan supported.
                                        Self-test supported.
                                        No Conveyance Self-test supported.
                                        Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        (  81) minutes.
SCT capabilities:              (0x0021) SCT Status supported.
                                        SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      
UPDATED  WHEN_FAILED RAW_VALUE
  3 Spin_Up_Time            0x0027   206   204   063    Pre-fail  
Always       -       10179
  4 Start_Stop_Count        0x0032   253   253   000    Old_age   
Always       -       1502
  5 Reallocated_Sector_Ct   0x0033   253   253   063    Pre-fail  
Always       -       0
  6 Read_Channel_Margin     0x0001   253   253   100    Pre-fail  
Offline      -       0
  7 Seek_Error_Rate         0x000a   253   252   000    Old_age   
Always       -       0
  8 Seek_Time_Performance   0x0027   246   240   187    Pre-fail  
Always       -       37304
  9 Power_On_Minutes        0x0032   239   239   000    Old_age   
Always       -       539h+13m
 10 Spin_Retry_Count        0x002b   253   252   157    Pre-fail  
Always       -       0
 11 Calibration_Retry_Count 0x002b   253   252   223    Pre-fail  
Always       -       0
 12 Power_Cycle_Count       0x0032   250   250   000    Old_age   
Always       -       1570
192 Power-Off_Retract_Count 0x0032   253   253   000    Old_age   
Always       -       0
193 Load_Cycle_Count        0x0032   253   253   000    Old_age   
Always       -       0
194 Temperature_Celsius     0x0032   031   253   000    Old_age   
Always       -       33
195 Hardware_ECC_Recovered  0x000a   253   252   000    Old_age   
Always       -       9263
196 Reallocated_Event_Count 0x0008   253   253   000    Old_age   
Offline      -       0
197 Current_Pending_Sector  0x0008   253   253   000    Old_age   
Offline      -       0
198 Offline_Uncorrectable   0x0008   253   253   000    Old_age   
Offline      -       0
199 UDMA_CRC_Error_Count    0x0008   199   199   000    Old_age   
Offline      -       0
200 Multi_Zone_Error_Rate   0x000a   253   252   000    Old_age   
Always       -       0
201 Soft_Read_Error_Rate    0x000a   253   252   000    Old_age   
Always       -       0
202 TA_Increase_Count       0x000a   253   252   000    Old_age   
Always       -       0
203 Run_Out_Cancel          0x000b   253   252   180    Pre-fail  
Always       -       0
204 Shock_Count_Write_Opern 0x000a   253   252   000    Old_age   
Always       -       0
205 Shock_Rate_Write_Opern  0x000a   253   252   000    Old_age   
Always       -       0
207 Spin_High_Current       0x002a   253   252   000    Old_age   
Always       -       0
208 Spin_Buzz               0x002a   253   252   000    Old_age   
Always       -       0
209 Offline_Seek_Performnce 0x0024   239   239   000    Old_age   
Offline      -       179
210 Unknown_Attribute       0x0032   253   252   000    Old_age   
Always       -       0
211 Unknown_Attribute       0x0032   253   252   000    Old_age   
Always       -       0
212 Unknown_Attribute       0x0032   253   252   000    Old_age   
Always       -       0

Warning! SMART ATA Error Log Structure error: invalid SMART checksum.
SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  
LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%      
1163         -
# 2  Short offline       Completed without error       00%      
1163         -
# 3  Offline             Aborted by host               70%         
0         -

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

hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
        Model Number:       Maxtor 6L200M0
        Serial Number:      L40A4PDH
        Firmware Revision:  BANC1E00
Standards:
        Used: ATA/ATAPI-7 T13 1532D revision 0
        Supported: 7 6 5 4
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  398297088
        device size with M = 1024*1024:      194481 MBytes
        device size with M = 1000*1000:      203928 MBytes (203 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 0
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_VERIFY command
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    DOWNLOAD_MICROCODE
                Advanced Power Management feature set
                SET_MAX security extension
           *    Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    WRITE_{DMA|MULTIPLE}_FUA_EXT
           *    SATA-I signaling speed (1.5Gb/s)
           *    Native Command Queueing (NCQ)
                Software settings preservation
           *    SMART Command Transport (SCT) feature set
           *    SCT Data Tables (AC5)
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
Checksum: correct

lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] 
Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
00:06.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)
00:07.0 Mass storage controller: Promise Technology, Inc. 
PDC20518/PDC40518 (SATAII 150 TX4) (rev 02)
00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
00:0b.1 Input device controller: Creative Labs SB Live! Game Port (rev 08)
00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 
4200] (rev a3)


Perhaps this will help to resolve the problem

Ansgar

