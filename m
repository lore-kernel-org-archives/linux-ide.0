From: Nicolas STRANSKY <Nico@stransky.cx>
Subject: Re: libata-tj and SMART
Date: Tue, 16 May 2006 09:44:10 +0200
Message-ID: <e4bvsb$s9m$1@sea.gmane.org>
References: <e4b02t$e9b$1@sea.gmane.org> <44690B0F.90200@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090604070901080703020809"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:39660 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751661AbWEPHow (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 03:44:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FfuEE-0002Me-IU
	for linux-ide@vger.kernel.org; Tue, 16 May 2006 09:44:26 +0200
Received: from fbx.stransky.cx ([82.67.244.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 09:44:26 +0200
Received: from Nico by fbx.stransky.cx with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 09:44:26 +0200
In-Reply-To: <44690B0F.90200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090604070901080703020809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Le 05/16/2006 01:13 AM, Tejun Heo a écrit :

Hi,

>> I've been using libata-tj for a couple of days and for now it's working
>> without problem, my SI-3112 is finally working :) Thanks !
> 
> How does it work w/o libata-tj?

smartctl and smartd used to work fine. But I was using a different
controler (Promise PDC20376).

> Your drive/controller causes HSM violation probably while executing a
> SMART command (maybe during PIO-in during READ DATA?, maybe we need to
> dump feature, too).  Can you try 'smartctl -d ata -a /dev/sdx' and
> report the result and how the kernel acts during that command?

You can find attached the result of the smartctl. It went fine and there
was no kernel message associated. But if I try to reproduce smartd
command, then "smartctl -d ata -a -o on -S on /dev/sda" causes the same
error I showed in the first post, and smartctl fails with this error:
Error SMART Enable Auto-save failed: I/O error
Smartctl: SMART Enable Attribute Autosave Failed.

> Also, you've triggered a bug.  It should try SRST after HSM violation
> not revalidation.  I had that code.  I must have dropped it somewhere.
> Thanks for finding the bug.  :)

Yay !

> Can you post full boot dmesg?

Here it is.

Regards,
-- 
Nico
Femme tentée et femme vaincue, c'est un tout.
	-+- Marivaux -+-

--------------090604070901080703020809
Content-Type: text/plain;
 name="smartctl_sda"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smartctl_sda"

smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Barracuda 7200.7 and 7200.7 Plus family
Device Model:     ST3160827AS
Serial Number:    4MT03YDP
Firmware Version: 3.42
User Capacity:    160 041 885 696 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   6
ATA Standard is:  ATA/ATAPI-6 T13 1410D revision 2
Local Time is:    Tue May 16 09:28:59 2006 CEST
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
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   058   050   006    Pre-fail  Always       -       169809676
  3 Spin_Up_Time            0x0003   097   096   000    Pre-fail  Always       -       0
  4 Start_Stop_Count        0x0032   100   100   020    Old_age   Always       -       49
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   085   060   030    Pre-fail  Always       -       382911082
  9 Power_On_Hours          0x0032   094   094   000    Old_age   Always       -       5262
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   020    Old_age   Always       -       51
194 Temperature_Celsius     0x0022   041   047   000    Old_age   Always       -       41 (Lifetime Min/Max 0/11)
195 Hardware_ECC_Recovered  0x001a   058   050   000    Old_age   Always       -       169809676
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   001   000    Old_age   Always       -       5440
200 Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offline      -       0
202 TA_Increase_Count       0x0032   100   253   000    Old_age   Always       -       0

SMART Error Log Version: 1
ATA Error Count: 5599 (device log contains only the most recent five errors)
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

Error 5599 occurred at disk power-on lifetime: 5077 hours (211 days + 13 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 cf 02 ae 86 e0  Error: ICRC, ABRT 207 sectors at LBA = 0x0086ae02 = 8826370

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  25 00 00 d1 ad 86 e0 00      00:33:30.108  READ DMA EXT
  25 00 00 d1 ac 86 e0 00      00:33:30.107  READ DMA EXT
  25 00 00 d1 ab 86 e0 00      00:33:29.130  READ DMA EXT
  25 00 a8 29 ab 86 e0 00      00:33:28.210  READ DMA EXT
  25 00 58 b9 aa 86 e0 00      00:33:28.208  READ DMA EXT

Error 5598 occurred at disk power-on lifetime: 5077 hours (211 days + 13 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 3f da 43 86 e0  Error: ICRC, ABRT 63 sectors at LBA = 0x008643da = 8799194

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  25 00 00 19 43 86 e0 00      00:31:21.906  READ DMA EXT
  25 00 00 19 42 86 e0 00      00:31:20.351  READ DMA EXT
  25 00 00 19 41 86 e0 00      00:31:19.440  READ DMA EXT
  25 00 00 19 40 86 e0 00      00:31:18.419  READ DMA EXT
  25 00 00 19 3f 86 e0 00      00:31:17.340  READ DMA EXT

Error 5597 occurred at disk power-on lifetime: 5077 hours (211 days + 13 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 00 90 cd 85 e0  Error: ICRC, ABRT at LBA = 0x0085cd90 = 8768912

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  25 00 00 91 cc 85 e0 00      00:29:24.155  READ DMA EXT
  25 00 00 91 cb 85 e0 00      00:29:22.856  READ DMA EXT
  25 00 00 91 ca 85 e0 00      00:29:21.664  READ DMA EXT
  25 00 00 91 c9 85 e0 00      00:29:19.316  READ DMA EXT
  25 00 00 91 c8 85 e0 00      00:29:17.567  READ DMA EXT

Error 5596 occurred at disk power-on lifetime: 5077 hours (211 days + 13 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 af da 1b 85 e0  Error: ICRC, ABRT 175 sectors at LBA = 0x00851bda = 8723418

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  25 00 00 89 1b 85 e0 00      00:25:45.560  READ DMA EXT
  25 00 00 89 1a 85 e0 00      00:25:44.266  READ DMA EXT
  25 00 00 89 19 85 e0 00      00:25:42.713  READ DMA EXT
  25 00 00 89 18 85 e0 00      00:25:42.711  READ DMA EXT
  25 00 00 89 17 85 e0 00      00:25:41.589  READ DMA EXT

Error 5595 occurred at disk power-on lifetime: 5077 hours (211 days + 13 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 ef 4a ea 83 e0  Error: ICRC, ABRT 239 sectors at LBA = 0x0083ea4a = 8645194

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  25 00 00 39 ea 83 e0 00      00:19:59.134  READ DMA EXT
  b0 d1 01 01 4f c2 00 00      00:20:03.728  SMART READ ATTRIBUTE THRESHOLDS [OBS-4]
  b0 d0 01 00 4f c2 00 00      00:20:03.078  SMART READ DATA
  b0 da 00 00 4f c2 00 00      00:20:03.006  SMART RETURN STATUS
  b0 da 00 00 4f c2 00 00      00:20:02.913  SMART RETURN STATUS

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%      5088         -
# 2  Short offline       Completed without error       00%      5072         -
# 3  Short offline       Completed without error       00%      5043         -
# 4  Short offline       Completed without error       00%      5019         -
# 5  Short offline       Completed without error       00%      4995         -
# 6  Extended offline    Completed without error       00%      4974         -
# 7  Short offline       Completed without error       00%      4972         -
# 8  Short offline       Completed without error       00%      4948         -
# 9  Short offline       Completed without error       00%      4925         -
#10  Short offline       Completed without error       00%      4901         -
#11  Short offline       Completed without error       00%      4877         -

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


--------------090604070901080703020809
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.16.16-mh2-r4-atadev (nico@aneto) (gcc version 4.0.4 20060507 (prerelease) (Debian 4.0.3-3)) #1 PREEMPT Mon May 15 01:24:41 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000005ffec000 (usable)
 BIOS-e820: 000000005ffec000 - 000000005ffef000 (ACPI data)
 BIOS-e820: 000000005ffef000 - 000000005ffff000 (reserved)
 BIOS-e820: 000000005ffff000 - 0000000060000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
639MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 393196
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 163820 pages, LIFO batch:31
DMI 2.3 present.
Allocating PCI resources starting at 70000000 (gap: 60000000:9ec00000)
Built 1 zonelists
Kernel command line: root=/dev/hda3 ro video=vesafb:mtrr,vesa=1280x1024 vga=795 
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2565.449 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1554996k/1572784k available (2392k kernel code, 16684k reserved, 760k data, 144k init, 655280k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5137.50 BogoMIPS (lpj=10275006)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.53GHz stepping 07
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1e50, last bus=2
PCI: Using configuration type 1
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Enabled i801 SMBus device
PCI quirk: region e400-e47f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region ec00-ec3f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24c0] at 0000:00:1f.0
PCI: Found IRQ 11 for device 0000:00:1d.7
PCI: Sharing IRQ 11 with 0000:02:04.0
PCI: Found IRQ 6 for device 0000:02:03.0
PCI: Sharing IRQ 6 with 0000:02:0a.0
PCI: Found IRQ 10 for device 0000:02:05.0
PCI: Sharing IRQ 10 with 0000:02:0c.0
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: d7000000-d7dfffff
  PREFETCH window: d7f00000-dfffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 7000-afff
  MEM window: d3800000-d67fffff
  PREFETCH window: d7e00000-d7efffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
highmem bounce pool size: 64 pages
Loading Reiser4. See www.namesys.com for a description of Reiser4.
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
vesafb: framebuffer at 0xd8000000, mapped to 0xf8800000, using 7680k, total 65536k
vesafb: mode is 1280x1024x24, linelength=3840, pages=16
vesafb: protected mode interface info at c000:56fe
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
hw_random: RNG not detected
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 845G Chipset.
agpgart: AGP aperture is 256M @ 0xe0000000
[drm] Initialized drm 1.0.1 20051102
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Found IRQ 7 for device 0000:00:1f.1
PCI: Sharing IRQ 7 with 0000:00:1d.2
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST3120026A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST CD-RW GCE-8240B, ATAPI CD/DVD-ROM drive
hdd: PIONEER DVD-RW DVR-106D, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(33)

PCI: IRQ 6 for device 0000:02:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
<6>PCI: Found IRQ 6 for device 0000:02:0a.0
PCI: Sharing IRQ 6 with 0000:02:03.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:6: Beginning Domain Validation
 target0:0:6: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target0:0:6: Domain Validation skipping write tests
 target0:0:6: Ending Domain Validation
libata version 1.30 loaded.
sata_promise 0000:02:04.0: version 1.04
PCI: Found IRQ 11 for device 0000:02:04.0
PCI: Sharing IRQ 11 with 0000:00:1d.7
ata1: SATA max UDMA/133 cmd 0xF8F88200 ctl 0xF8F88238 bmdma 0x0 irq 11
ata2: SATA max UDMA/133 cmd 0xF8F88280 ctl 0xF8F882B8 bmdma 0x0 irq 11
scsi1 : sata_promise
ata1: SATA link down (SStatus 0 SControl 300)
scsi2 : sata_promise
ata2: SATA link down (SStatus 0 SControl 300)
sr0: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
sr 0:0:6:0: Attached scsi CD-ROM sr0
sr 0:0:6:0: Attached scsi generic sg0 type 5
PCI: Enabling device 0000:00:1d.7 (0004 -> 0006)
PCI: Found IRQ 11 for device 0000:00:1d.7
PCI: Sharing IRQ 11 with 0000:02:04.0
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xd6800000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.3
PCI: Found IRQ 4 for device 0000:00:1d.0
PCI: Sharing IRQ 4 with 0000:01:00.0
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 4, io base 0x0000b800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Found IRQ 5 for device 0000:00:1d.1
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 5, io base 0x0000b400
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Found IRQ 7 for device 0000:00:1d.2
PCI: Sharing IRQ 7 with 0000:00:1f.1
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 7, io base 0x0000b000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
mice: PS/2 mouse device common for all mice
usb 2-2: new full speed USB device using uhci_hcd and address 2
usb 2-2: configuration #1 chosen from 1 choice
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 3 ports detected
input: PC Speaker as /class/input/input0
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
TCP htcp registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 144k freed
kjournald starting.  Commit interval 5 seconds
usb 3-2: new low speed USB device using uhci_hcd and address 2
usb 3-2: configuration #1 chosen from 1 choice
usb 2-2.1: new full speed USB device using uhci_hcd and address 3
usb 2-2.1: configuration #1 chosen from 1 choice
usb 2-2.2: new full speed USB device using uhci_hcd and address 4
ieee1394: Initialized config rom entry `ip1394'
PCI: Enabling device 0000:00:1f.5 (0004 -> 0007)
PCI: setting IRQ 9 as level-triggered
PCI: Assigned IRQ 9 for device 0000:00:1f.5
PCI: Sharing IRQ 9 with 0000:00:1f.3
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 0 analog subsections not ready
intel8x0_measure_ac97_clock: measured 55034 usecs
intel8x0: clocking to 48000
sata_sil 0000:02:0c.0: version 1.0
PCI: Found IRQ 10 for device 0000:02:0c.0
PCI: Sharing IRQ 10 with 0000:02:05.0
ata3: SATA max UDMA/100 cmd 0xF8F96080 ctl 0xF8F9608A bmdma 0xF8F96000 irq 10
ata4: SATA max UDMA/100 cmd 0xF8F960C0 ctl 0xF8F960CA bmdma 0xF8F96008 irq 10
scsi3 : sata_sil
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3.00: cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata3.00: ATA-6, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 0/32)
Bluetooth: HCI USB driver ver 2.9
ata3.00: configured for UDMA/100
scsi4 : sata_sil
ata4: SATA link down (SStatus 0 SControl 310)
  Vendor: ATA       Model: ST3160827AS       Rev: 3.42
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 3:0:0:0: Attached scsi disk sda
sd 3:0:0:0: Attached scsi generic sg1 type 0
PCI: Enabling device 0000:02:03.0 (0094 -> 0097)

PCI: IRQ 6 for device 0000:02:03.0 doesn't match PIRQ mask - try pci=usepirqmask
<6>PCI: Found IRQ 6 for device 0000:02:03.0
PCI: Sharing IRQ 6 with 0000:02:0a.0
PCI: Via IRQ fixup for 0000:02:03.0, from 255 to 6
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[6]  MMIO=[d6000000-d60007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000011c2af]
usb 2-2.2: device descriptor read/all, error -110
usb 2-2.2: new full speed USB device using uhci_hcd and address 5
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
usb 2-2.2: device descriptor read/all, error -110
usb 2-2.2: new full speed USB device using uhci_hcd and address 6
usb 2-2.2: configuration #1 chosen from 1 choice
usb 2-2.3: new full speed USB device using uhci_hcd and address 7
usb 2-2.3: device descriptor read/all, error -110
usb 2-2.3: new full speed USB device using uhci_hcd and address 8
usb 2-2.3: configuration #1 chosen from 1 choice
usbcore: registered new driver hiddev
tg3.c:v3.49 (Feb 2, 2006)
PCI: Enabling device 0000:02:05.0 (0014 -> 0016)
usbcore: registered new driver hci_usb
PCI: Found IRQ 10 for device 0000:02:05.0
PCI: Sharing IRQ 10 with 0000:02:0c.0
eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:e0:18:fa:82:11
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[763f0000] dma_mask[64-bit]
input: Logitech HID compliant keyboard as /class/input/input1
input: USB HID v1.10 Keyboard [Logitech HID compliant keyboard] on usb-0000:00:1d.1-2
input: Logitech HID compliant keyboard as /class/input/input2
input: USB HID v1.10 Device [Logitech HID compliant keyboard] on usb-0000:00:1d.1-2
input: HID 045e:00bf as /class/input/input3
input: USB HID v1.11 Keyboard [HID 045e:00bf] on usb-0000:00:1d.0-2.2
input: HID 045e:00be as /class/input/input4
input: USB HID v1.11 Mouse [HID 045e:00be] on usb-0000:00:1d.0-2.3
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
EXT3 FS on hda3, internal journal
Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Bluetooth: Virtual HCI driver ver 1.2
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1-mh1
fuse init (API version 7.6)
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver

--------------090604070901080703020809--

