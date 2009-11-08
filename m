From: Marc Bevand <m.bevand@gmail.com>
Subject: Abysmal SATA throughput with =?utf-8?b?c2F0YV9zdnc=?= and ST31500341AS
Date: Sun, 8 Nov 2009 00:29:47 +0000 (UTC)
Message-ID: <loom.20091108T012429-447@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:43787 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbZKHAfB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Nov 2009 19:35:01 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N6vkG-0000y9-Ao
	for linux-ide@vger.kernel.org; Sun, 08 Nov 2009 01:35:04 +0100
Received: from cpe-76-89-196-254.socal.res.rr.com ([cpe-76-89-196-254.socal.res.rr.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 08 Nov 2009 01:35:04 +0100
Received: from m.bevand by cpe-76-89-196-254.socal.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 08 Nov 2009 01:35:04 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

One of my machines with 4 SATA disks is resyncing a sdb, which is part of a
2-way raid1 MD array with sda, but is doing so _very_ slowly at a speed of
5-10 MByte/s. The machine is idle (no CPU, no fs activity on top of the
array) and dev.raid.speed_limit_max has not been modified (left to the
default value 200000). The output of iostat doesn't make sense to me: why
are there 2-3 seconds periods of sdb being 100% utilized with an avgqu-sz
of 4 but an avgrq-sz of 0 ?! What does this mean, that 0-byte I/O requests
are being issued to the disk?

[output of essentially: iostat -x 1 /dev/sdb | grep ^sdb]
Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s avgrq-sz 
avgqu-sz   await  svctm  %util
sdb               0.00    70.00    0.00   10.00     0.00 10240.00  1024.00     
3.99  448.40 100.00 100.00
sdb               0.00    63.00    0.00    9.00     0.00  9216.00  1024.00     
3.98  454.67 111.11 100.00
sdb               0.00   280.00    0.00   43.00     0.00 41344.00   961.49     
2.06   36.74  15.07  64.80
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     
4.00    0.00   0.00 100.00
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     
4.00    0.00   0.00 100.00
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     
4.00    0.00   0.00 100.00
sdb               0.00    82.00    0.00   14.00     0.00 12288.00   877.71     
3.70  975.43  66.57  93.20
sdb               0.00    32.00    0.00   11.00     0.00  8120.00   738.18     
1.64  426.18  72.36  79.60
sdb               0.00     0.00    0.00    2.00     0.00   136.00    68.00     
0.20  164.00 102.00  20.40
sdb               0.00   117.00    0.00   15.00     0.00 13440.00   896.00     
2.87  107.20  50.13  75.20
sdb               0.00    91.00    0.00   13.00     0.00 13312.00  1024.00     
3.97  344.00  76.92 100.00
sdb               0.00    87.00    0.00   13.00     0.00 13312.00  1024.00     
3.99  352.62  76.92 100.00
sdb               0.00    88.00    0.00   12.00     0.00 12288.00  1024.00     
3.98  290.00  83.33 100.00
sdb               0.00   274.00    0.00   42.00     0.00 40448.00   963.05     
2.33   37.90  17.33  72.80
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     
4.00    0.00   0.00 100.00
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     
4.00    0.00   0.00 100.00
sdb               0.00    83.00    0.00   12.00     0.00 12160.00  1013.33     
3.91 1063.33  83.33 100.00
sdb               0.00    98.00    0.00   14.00     0.00 14336.00  1024.00     
3.96  279.71  71.43 100.00
sdb               0.00   240.00    0.00   40.00     0.00 38400.00   960.00     
2.96   88.90  20.80  83.20
sdb               0.00    75.00    0.00    8.00     0.00  8064.00  1008.00     
3.62    6.00 118.00  94.40
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     
4.00    0.00   0.00 100.00
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     
4.00    0.00   0.00 100.00
sdb               0.00   132.00    0.00   19.00     0.00 19328.00  1017.26     
3.91  797.68  52.63 100.00

I first thought sdb was dying because svctm is often in the 50-100ms range,
when it should be less than the typical 10-20ms latency for a 7200RPM disk
given I/O ops of a max size of 512kB (avgrq-sz 1024). So I replaced it with
a brand new one but it didn't change anything. In addition, the SMART data
on the disks doesn't report anything suspicious. I can essentially
reproduce the same abysmal performance when trying to dd /dev/zero to sdb.

The 4 disks are 1.5TB Seagate 7200.11 7200RPM (ST31500341AS firmware CC1H);
they are connected to a SATA controller Broadcom BCM5785 [HT1000] (module
sata_svw) via the SATA backplane of a Tyan B3992 server; kernel is stock
2.6.31.1; arch is x86_64; motherboard is Tyan S3992; 2 Opteron 2350; 64GB
RAM.

Could the SATA backplane be the culprit? I am going to try to swap sda and
sdb, or connect sdb directly to the SATA controller, bypassing the
backplane.

$ uname -a
Linux host 2.6.31.1 #1 SMP Sat Sep 26 18:52:12 EDT 2009 x86_64 GNU/Linux

$ cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] 
[raid10]
md0 : active raid1 sdc1[2] sdb1[1] sda1[0] sdd1[3]
      104320 blocks [4/4] [UUUU]

md2 : active raid1 sdc5[2](F) sdd5[1]
      1464734272 blocks [2/1] [_U]    <-- not only sdb is slow, but sdc is 
failing on this server

md1 : active raid1 sdb5[2] sda5[0]
      1464734272 blocks [2/1] [U_]
      [========>............]  recovery = 43.5% (637657472/1464734272) 
finish=1631.2min speed=8449K/sec

$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST31500341AS     Rev: CC1H
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST31500341AS     Rev: CC1H
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST31500341AS     Rev: CC1H
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST31500341AS     Rev: CC1H
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi4 Channel: 00 Id: 01 Lun: 00
  Vendor: TEAC     Model: DV-28E-N         Rev: 1.6A
  Type:   CD-ROM                           ANSI  SCSI revision: 05

$ dmesg
[...]
[    4.760503] sata_svw 0000:01:0e.0: version 2.3
[    4.760576] sata_svw 0000:01:0e.0: PCI INT A -> GSI 11 (level, low) -> IRQ 
11
[    4.760685] scsi0 : sata_svw
[    4.760817] scsi1 : sata_svw
[    4.760869] scsi2 : sata_svw
[    4.760916] scsi3 : sata_svw
[    4.760943] ata1: SATA max UDMA/133 mmio m8192@0xff4fe000 port 0xff4fe000 
irq 11
[    4.760947] ata2: SATA max UDMA/133 mmio m8192@0xff4fe000 port 0xff4fe100 
irq 11
[    4.760950] ata3: SATA max UDMA/133 mmio m8192@0xff4fe000 port 0xff4fe200 
irq 11
[    4.760953] ata4: SATA max UDMA/133 mmio m8192@0xff4fe000 port 0xff4fe300 
irq 11
[...]
[    5.081310] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    5.116929] ata1.00: ATA-8: ST31500341AS, CC1H, max UDMA/133
[    5.116934] ata1.00: 2930277168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    5.175693] ata1.00: configured for UDMA/133
[    5.175830] scsi 0:0:0:0: Direct-Access     ATA      ST31500341AS     CC1H 
PQ: 0 ANSI: 5
[    5.492060] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    5.529385] ata2.00: ATA-8: ST31500341AS, CC1H, max UDMA/133
[    5.529388] ata2.00: 2930277168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    5.587637] ata2.00: configured for UDMA/133
[    5.587800] scsi 1:0:0:0: Direct-Access     ATA      ST31500341AS     CC1H 
PQ: 0 ANSI: 5
[    5.904053] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    5.939618] ata3.00: ATA-8: ST31500341AS, CC1H, max UDMA/133
[    5.939621] ata3.00: 2930277168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    5.995636] ata3.00: configured for UDMA/133
[    5.995695] scsi 2:0:0:0: Direct-Access     ATA      ST31500341AS     CC1H 
PQ: 0 ANSI: 5
[    6.312053] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    6.347617] ata4.00: ATA-8: ST31500341AS, CC1H, max UDMA/133
[    6.347630] ata4.00: 2930277168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    6.403640] ata4.00: configured for UDMA/133
[    6.403796] scsi 3:0:0:0: Direct-Access     ATA      ST31500341AS     CC1H 
PQ: 0 ANSI: 5
[...]

$ lspci -s 01:0e.0 -vvv
01:0e.0 RAID bus controller: Broadcom BCM5785 [HT1000] SATA (Native SATA Mode) 
(prog-if 05)
        Subsystem: Broadcom BCM5785 [HT1000] SATA (Native SATA Mode)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at bc00 [size=8]
        Region 1: I/O ports at b880 [size=4]
        Region 2: I/O ports at b800 [size=8]
        Region 3: I/O ports at b480 [size=4]
        Region 4: I/O ports at b400 [size=32]
        Region 5: Memory at ff4fe000 (32-bit, non-prefetchable) [size=8K]
        Expansion ROM at ff4c0000 [disabled] [size=128K]
        Capabilities: [60] PCI-X non-bridge device
                Command: DPERE- ERO- RBC=512 OST=8
                Status: Dev=01:0e.0 64bit+ 133MHz+ SCD- USC- DC=simple 
DMMRBC=512 DMOST=8 DMCRS=32 RSCEM- 266MHz- 533MHz-
        Capabilities: [90] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit- 
Queue=0/0 Enable-
                Address: 00000000  Data: 0000

$ iostat -x 1 /dev/sd[ab]
[...]

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          11.06    0.00    5.43    0.63    0.00   82.88

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s avgrq-sz 
avgqu-sz   await  svctm  %util
sdb               0.00    49.43    0.00    7.10     0.02  6860.66   966.90     
1.57  221.51  55.89  39.66
sda              36.93    25.74   30.88    7.64  7842.26   267.14   210.53     
0.60   15.64   2.38   9.17

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.00    0.00    0.00    0.00    0.00  100.00

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s avgrq-sz 
avgqu-sz   await  svctm  %util
sdb               0.00   162.00    0.00   24.00     0.00 22912.00   954.67     
3.74  130.00  41.50  99.60
sda             121.00     0.00   61.00    0.00 23936.00     0.00   392.39     
0.52    9.38   3.15  19.20

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.00    0.00    0.00    0.00    0.00  100.00

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s avgrq-sz 
avgqu-sz   await  svctm  %util
sdb               0.00    21.00    0.00    3.00     0.00  3072.00  1024.00     
3.99  320.00 333.33 100.00
sda              15.00     0.00    9.00    0.00  3072.00     0.00   341.33     
0.02    2.22   1.33   1.20

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.00    0.00    0.00    0.00    0.00  100.00

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s avgrq-sz 
avgqu-sz   await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     
4.00    0.00   0.00 100.00
sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.00    0.00    0.00    0.00    0.00  100.00

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s avgrq-sz 
avgqu-sz   await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     
4.00    0.00   0.00 100.00
sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.00    0.00    0.10    0.00    0.00   99.90

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s avgrq-sz 
avgqu-sz   await  svctm  %util
sdb               0.00   159.00    0.00   25.00     0.00 23552.00   942.08     
3.79  621.12  39.68  99.20
sda             127.00     0.00   57.00    0.00 23552.00     0.00   413.19     
0.33    5.82   2.53  14.40

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.00    0.00    0.20    0.00    0.00   99.80

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s avgrq-sz 
avgqu-sz   await  svctm  %util
sdb               0.00   334.00    0.00   51.00     0.00 50048.00   981.33     
3.85   77.25  19.61 100.00
sda             256.00     0.00  134.00    0.00 49280.00     0.00   367.76     
0.35    2.57   1.52  20.40

$ smartctl -a /dev/sdb
smartctl version 5.38 [x86_64-unknown-linux-gnu] Copyright (C) 2002-8 Bruce 
Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     ST31500341AS
Serial Number:    (ed: removed)
Firmware Version: CC1H
User Capacity:    1,500,301,910,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   8
ATA Standard is:  ATA-8-ACS revision 4
Local Time is:    Sat Nov  7 19:25:41 2009 EST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                        was completed without error.
                                        Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0) The previous self-test routine 
completed
                                        without error or no self-test has ever
                                        been run.
Total time to complete Offline
data collection:                 ( 617) seconds.
Offline data collection
capabilities:                    (0x7b) SMART execute Offline immediate.
                                        Auto Offline data collection on/off 
support.
                                        Suspend Offline collection upon new
                                        command.
                                        Offline surface scan supported.
                                        Self-test supported.
                                        Conveyance Self-test supported.
                                        Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   1) minutes.
Extended self-test routine
recommended polling time:        ( 255) minutes.
Conveyance self-test routine
recommended polling time:        (   2) minutes.
SCT capabilities:              (0x103f) SCT Status supported.
                                        SCT Feature Control supported.
                                        SCT Data Table supported.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  
WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   102   100   006    Pre-fail  
Always       -       5131185
  3 Spin_Up_Time            0x0003   100   100   000    Pre-fail  
Always       -       0
  4 Start_Stop_Count        0x0032   100   100   020    Old_age   
Always       -       3
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  
Always       -       0
  7 Seek_Error_Rate         0x000f   100   253   030    Pre-fail  
Always       -       244369
  9 Power_On_Hours          0x0032   100   100   000    Old_age   
Always       -       95
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  
Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   020    Old_age   
Always       -       3
184 Unknown_Attribute       0x0032   100   100   099    Old_age   
Always       -       0
187 Reported_Uncorrect      0x0032   100   100   000    Old_age   
Always       -       0
188 Unknown_Attribute       0x0032   100   100   000    Old_age   
Always       -       0
189 High_Fly_Writes         0x003a   097   097   000    Old_age   
Always       -       3
190 Airflow_Temperature_Cel 0x0022   072   070   045    Old_age   
Always       -       28 (Lifetime Min/Max 23/29)
194 Temperature_Celsius     0x0022   028   040   000    Old_age   
Always       -       28 (0 23 0 0)
195 Hardware_ECC_Recovered  0x001a   021   021   000    Old_age   
Always       -       5131185
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   
Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   
Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   
Always       -       0
240 Head_Flying_Hours       0x0000   100   253   000    Old_age   
Offline      -       35081292873823
241 Unknown_Attribute       0x0000   100   253   000    Old_age   
Offline      -       2374965013
242 Unknown_Attribute       0x0000   100   253   000    Old_age   
Offline      -       5226517

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

-mrb


