From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Kernel problem or faulty drive?
Date: Mon, 22 Nov 2010 22:04:10 +1030 (CST)
Message-ID: <201011221134.oAMBYAaO016345@mercury.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:36922 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753434Ab0KVMCP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Nov 2010 07:02:15 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Hi

I recently installed a brand new 1 TB Seagate drive into a machine at home:

  Model Family:     Seagate Barracuda 7200.12 family
  Device Model:     ST31000528AS
  Serial Number:    xxxxxxxx
  Firmware Version: CC38
  User Capacity:    1,000,204,886,016 bytes

This is attached to an Intel SATA controller:

  00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10 Family) SATA
  AHCI Controller

This drive is currently deployed as a backup drive and is not mounted during
routine machine operation.

The system is presently running kernel 2.6.36 with a Slackware 13.1
userspace. The drive is connected via SATA cables which shipped with the
mainboard.  The mainboard is a Gigabyte GA-EX58-UD4P.

At various times the drive seems to get into a state whereby it has repeated
trouble communicating with the kernel.  The drive clicks once, there's some
seek activity by the drive and the following set of messages (along with
variations) are written to the log:

  ata3: exception Emask 0x50 SAct 0x0 SErr 0x4010800 action 0xe frozen
  ata3: irq_stat 0x00400040, connection status changed
  ata3: SError: { HostInt PHYRdyChg DevExch }
  ata3: hard resetting link
  ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  ata3.00: configured for UDMA/33
  ata3: EH complete

A full dmesg dump from the latest occurance of this problem can be found at
the end of this email.  At no time over the duration of this log were any
partitions from this drive mounted.

This can occur a dozen or more times before the drive settles down, or it
may occur only once.  All this is while Linux is not accessing the drive and
none of its partitions are mounted.

Smartctl doesn't seem to be reporting anything out of the ordinary for a
Seagate drive (see below) and the "short" self-test came back with no
errors.  Smartd is NOT running on this system (I triggered the self-test
manually with "smartctl -t short").

What do these messages mean?  Do they indicate that the brand new drive is
bad, is there a kernel issue, do these messages suggest that the SATA cables
are in some way bad, or is it some strange interaction between these drives,
the controller in my system and Linux?  Or something else entirely?

Any advice would be greatly appreciated.

Regards
  jonathan

--------
"smartctl -a" output for drive:
bash-4.1# smartctl -a /dev/sdb
smartctl 5.39.1 2010-01-28 r3054 [i486-slackware-linux-gnu] (local build)
Copyright (C) 2002-10 by Bruce Allen, http://smartmontools.sourceforge.net

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Barracuda 7200.12 family
Device Model:     ST31000528AS
Serial Number:    9VP903BP
Firmware Version: CC38
User Capacity:    1,000,204,886,016 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   8
ATA Standard is:  ATA-8-ACS revision 4
Local Time is:    Mon Nov 22 21:09:13 2010 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                        was completed without error.
                                        Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0) The previous self-test routine completed
                                        without error or no self-test has ever 
                                        been run.
Total time to complete Offline 
data collection:                 ( 609) seconds.
Offline data collection
capabilities:                    (0x7b) SMART execute Offline immediate.
                                        Auto Offline data collection on/off support.
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
recommended polling time:        ( 179) minutes.
Conveyance self-test routine
recommended polling time:        (   2) minutes.
SCT capabilities:              (0x103f) SCT Status supported.
                                        SCT Feature Control supported.
                                        SCT Data Table supported.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   111   100   006    Pre-fail  Always       -       34562688
  3 Spin_Up_Time            0x0003   098   094   000    Pre-fail  Always       -       0
  4 Start_Stop_Count        0x0032   100   100   020    Old_age   Always       -       196
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   100   253   030    Pre-fail  Always       -       274357
  9 Power_On_Hours          0x0032   100   100   000    Old_age   Always       -       49
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   020    Old_age   Always       -       98
183 Runtime_Bad_Block       0x0032   100   100   000    Old_age   Always       -       0
184 End-to-End_Error        0x0032   100   100   099    Old_age   Always       -       0
187 Reported_Uncorrect      0x0032   100   100   000    Old_age   Always       -       0
188 Command_Timeout         0x0032   100   100   000    Old_age   Always       -       0
189 High_Fly_Writes         0x003a   100   100   000    Old_age   Always       -       0
190 Airflow_Temperature_Cel 0x0022   064   060   045    Old_age   Always       -       36 (Lifetime Min/Max 35/36)
194 Temperature_Celsius     0x0022   036   040   000    Old_age   Always       -       36 (0 19 0 0)
195 Hardware_ECC_Recovered  0x001a   026   026   000    Old_age   Always       -       34562688
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
240 Head_Flying_Hours       0x0000   100   253   000    Old_age   Offline      -       231606111437016
241 Total_LBAs_Written      0x0000   100   253   000    Old_age   Offline      -       138001621
242 Total_LBAs_Read         0x0000   100   253   000    Old_age   Offline      -       2629240806

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%        49         -

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

--------
Complete messages output from system:

Nov 22 20:49:21 marble syslogd 1.4.1: restart.
Nov 22 20:49:21 marble kernel: klogd 1.4.1, log source = /proc/kmsg started.
Nov 22 20:49:21 marble kernel: 00-0xfd2fffff]
Nov 22 20:49:21 marble kernel: pci 0000:00:05.0:   bridge window [mem 0xfcf00000-0xfcffffff 64bit pref]
Nov 22 20:49:21 marble kernel: pci 0000:00:07.0: PCI bridge to [bus 04-04]
Nov 22 20:49:21 marble kernel: pci 0000:00:07.0:   bridge window [io  0x6000-0x6fff]
Nov 22 20:49:21 marble kernel: pci 0000:00:07.0:   bridge window [mem 0xfce00000-0xfcefffff]
Nov 22 20:49:21 marble kernel: pci 0000:00:07.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
Nov 22 20:49:21 marble kernel: pci 0000:00:09.0: PCI bridge to [bus 05-05]
Nov 22 20:49:21 marble kernel: pci 0000:00:09.0:   bridge window [io  0xe000-0xefff]
Nov 22 20:49:21 marble kernel: pci 0000:00:09.0:   bridge window [mem 0xfdd00000-0xfddfffff]
Nov 22 20:49:21 marble kernel: pci 0000:00:09.0:   bridge window [mem 0xfdc00000-0xfdcfffff 64bit pref]
Nov 22 20:49:21 marble kernel: pci 0000:00:1c.0: PCI bridge to [bus 06-06]
Nov 22 20:49:21 marble kernel: pci 0000:00:1c.0:   bridge window [io  0x9000-0x9fff]
Nov 22 20:49:21 marble kernel: pci 0000:00:1c.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Nov 22 20:49:21 marble kernel: pci 0000:00:1c.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Nov 22 20:49:21 marble kernel: pci 0000:00:1c.1: PCI bridge to [bus 07-07]
Nov 22 20:49:21 marble kernel: pci 0000:00:1c.1:   bridge window [io  0x8000-0x8fff]
Nov 22 20:49:21 marble kernel: pci 0000:00:1c.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Nov 22 20:49:21 marble kernel: pci 0000:00:1c.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Nov 22 20:49:21 marble kernel: pci 0000:08:00.0: BAR 6: assigned [mem 0xfd300000-0xfd31ffff pref]
Nov 22 20:49:21 marble kernel: pci 0000:00:1c.4: PCI bridge to [bus 08-08]
Nov 22 20:49:21 marble kernel: pci 0000:00:1c.4:   bridge window [io  0x7000-0x7fff]
Nov 22 20:49:21 marble kernel: pci 0000:00:1c.4:   bridge window [mem 0xfd400000-0xfd4fffff]
Nov 22 20:49:21 marble kernel: pci 0000:00:1c.4:   bridge window [mem 0xfd300000-0xfd3fffff 64bit pref]
Nov 22 20:49:21 marble kernel: pci 0000:09:00.0: BAR 6: assigned [mem 0xfd000000-0xfd00ffff pref]
Nov 22 20:49:21 marble kernel: pci 0000:00:1e.0: PCI bridge to [bus 09-09]
Nov 22 20:49:21 marble kernel: pci 0000:00:1e.0:   bridge window [io  0xc000-0xcfff]
Nov 22 20:49:21 marble kernel: pci 0000:00:1e.0:   bridge window [mem 0xfd100000-0xfd1fffff]
Nov 22 20:49:21 marble kernel: pci 0000:00:1e.0:   bridge window [mem 0xfd000000-0xfd0fffff 64bit pref]
Nov 22 20:49:21 marble kernel: pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Nov 22 20:49:21 marble kernel: pci 0000:00:03.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Nov 22 20:49:21 marble kernel: pci 0000:00:05.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Nov 22 20:49:21 marble kernel: pci 0000:00:07.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Nov 22 20:49:21 marble kernel: pci 0000:00:09.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Nov 22 20:49:21 marble kernel: pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Nov 22 20:49:21 marble kernel: pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Nov 22 20:49:21 marble kernel: pci 0000:00:1c.4: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Nov 22 20:49:21 marble kernel: NET: Registered protocol family 2
Nov 22 20:49:21 marble kernel: IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Nov 22 20:49:21 marble kernel: TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
Nov 22 20:49:21 marble kernel: TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
Nov 22 20:49:21 marble kernel: TCP: Hash tables configured (established 131072 bind 65536)
Nov 22 20:49:21 marble kernel: TCP reno registered
Nov 22 20:49:21 marble kernel: UDP hash table entries: 512 (order: 2, 16384 bytes)
Nov 22 20:49:21 marble kernel: UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
Nov 22 20:49:21 marble kernel: NET: Registered protocol family 1
Nov 22 20:49:21 marble kernel: RPC: Registered udp transport module.
Nov 22 20:49:21 marble kernel: RPC: Registered tcp transport module.
Nov 22 20:49:21 marble kernel: RPC: Registered tcp NFSv4.1 backchannel transport module.
Nov 22 20:49:21 marble kernel: SGI XFS with security attributes, large block/inode numbers, no debug enabled
Nov 22 20:49:21 marble kernel: msgmni has been set to 1663
Nov 22 20:49:21 marble kernel: io scheduler noop registered
Nov 22 20:49:21 marble kernel: io scheduler deadline registered
Nov 22 20:49:21 marble kernel: io scheduler cfq registered (default)
Nov 22 20:49:21 marble kernel: input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
Nov 22 20:49:21 marble kernel: ACPI: Power Button [PWRB]
Nov 22 20:49:21 marble kernel: input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
Nov 22 20:49:21 marble kernel: ACPI: Power Button [PWRF]
Nov 22 20:49:21 marble kernel: isapnp: Scanning for PnP cards...
Nov 22 20:49:21 marble kernel: isapnp: No Plug & Play device found
Nov 22 20:49:21 marble kernel: Real Time Clock Driver v1.12b
Nov 22 20:49:21 marble kernel: Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
Nov 22 20:49:21 marble kernel: Floppy drive(s): fd0 is 1.44M
Nov 22 20:49:21 marble kernel: FDC 0 is a post-1991 82077
Nov 22 20:49:21 marble kernel: ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
Nov 22 20:49:21 marble kernel: ahci: SSS flag set, parallel bus scan disabled
Nov 22 20:49:21 marble kernel: ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
Nov 22 20:49:21 marble kernel: ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ccc ems 
Nov 22 20:49:21 marble kernel: scsi0 : ahci
Nov 22 20:49:21 marble kernel: scsi1 : ahci
Nov 22 20:49:21 marble kernel: scsi2 : ahci
Nov 22 20:49:21 marble kernel: scsi3 : ahci
Nov 22 20:49:21 marble kernel: scsi4 : ahci
Nov 22 20:49:21 marble kernel: scsi5 : ahci
Nov 22 20:49:21 marble kernel: ata1: SATA max UDMA/133 abar m2048@0xfdffc000 port 0xfdffc100 irq 40
Nov 22 20:49:21 marble kernel: ata2: SATA max UDMA/133 abar m2048@0xfdffc000 port 0xfdffc180 irq 40
Nov 22 20:49:21 marble kernel: ata3: SATA max UDMA/133 abar m2048@0xfdffc000 port 0xfdffc200 irq 40
Nov 22 20:49:21 marble kernel: ata4: SATA max UDMA/133 abar m2048@0xfdffc000 port 0xfdffc280 irq 40
Nov 22 20:49:21 marble kernel: ata5: SATA max UDMA/133 abar m2048@0xfdffc000 port 0xfdffc300 irq 40
Nov 22 20:49:21 marble kernel: ata6: SATA max UDMA/133 abar m2048@0xfdffc000 port 0xfdffc380 irq 40
Nov 22 20:49:21 marble kernel: ahci 0000:07:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Nov 22 20:49:21 marble kernel: ahci 0000:07:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
Nov 22 20:49:21 marble kernel: ahci 0000:07:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
Nov 22 20:49:21 marble kernel: scsi6 : ahci
Nov 22 20:49:21 marble kernel: scsi7 : ahci
Nov 22 20:49:21 marble kernel: ata7: SATA max UDMA/133 abar m8192@0xfd6fe000 port 0xfd6fe100 irq 17
Nov 22 20:49:21 marble kernel: ata8: SATA max UDMA/133 abar m8192@0xfd6fe000 port 0xfd6fe180 irq 17
Nov 22 20:49:21 marble kernel: pata_jmicron 0000:07:00.1: PCI INT B -> GSI 18 (level, low) -> IRQ 18
Nov 22 20:49:21 marble kernel: scsi8 : pata_jmicron
Nov 22 20:49:21 marble kernel: scsi9 : pata_jmicron
Nov 22 20:49:21 marble kernel: ata9: PATA max UDMA/100 cmd 0x8f00 ctl 0x8e00 bmdma 0x8b00 irq 18
Nov 22 20:49:21 marble kernel: ata10: PATA max UDMA/100 cmd 0x8d00 ctl 0x8c00 bmdma 0x8b08 irq 18
Nov 22 20:49:21 marble kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
Nov 22 20:49:21 marble kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Nov 22 20:49:21 marble kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Nov 22 20:49:21 marble kernel: mice: PS/2 mouse device common for all mice
Nov 22 20:49:21 marble kernel: I2O subsystem v1.325
Nov 22 20:49:21 marble kernel: i2o: max drivers = 8
Nov 22 20:49:21 marble kernel: i2c /dev entries driver
Nov 22 20:49:21 marble kernel: i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Nov 22 20:49:21 marble kernel: coretemp coretemp.0: TjMax is 100 C.
Nov 22 20:49:21 marble kernel: coretemp coretemp.1: TjMax is 100 C.
Nov 22 20:49:21 marble kernel: coretemp coretemp.2: TjMax is 100 C.
Nov 22 20:49:21 marble kernel: coretemp coretemp.3: TjMax is 100 C.
Nov 22 20:49:21 marble kernel: it87: Found IT8720F chip at 0x290, revision 5
Nov 22 20:49:21 marble kernel: it87: VID is disabled (pins used for GPIO)
Nov 22 20:49:21 marble kernel: it87: Routing internal VCCH to in7
Nov 22 20:49:21 marble kernel: it87: Beeping is supported
Nov 22 20:49:21 marble kernel: device-mapper: ioctl: 4.18.0-ioctl (2010-06-29) initialised: dm-devel@redhat.com
Nov 22 20:49:21 marble kernel: cpuidle: using governor ladder
Nov 22 20:49:21 marble kernel: cpuidle: using governor menu
Nov 22 20:49:21 marble kernel: TCP cubic registered
Nov 22 20:49:21 marble kernel: NET: Registered protocol family 17
Nov 22 20:49:21 marble kernel: Using IPI No-Shortcut mode
Nov 22 20:49:21 marble kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
Nov 22 20:49:21 marble kernel: ata7: SATA link down (SStatus 0 SControl 300)
Nov 22 20:49:21 marble kernel: ata8: SATA link down (SStatus 0 SControl 300)
Nov 22 20:49:21 marble kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 20:49:21 marble kernel: ata1.00: HPA detected: current 1250261615, native 1250263728
Nov 22 20:49:21 marble kernel: ata1.00: ATA-8: WDC WD6400AACS-00G8B1, 05.04C05, max UDMA/133
Nov 22 20:49:21 marble kernel: ata1.00: 1250261615 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
Nov 22 20:49:21 marble kernel: ata1.00: configured for UDMA/133
Nov 22 20:49:21 marble kernel: scsi 0:0:0:0: Direct-Access     ATA      WDC WD6400AACS-0 05.0 PQ: 0 ANSI: 5
Nov 22 20:49:21 marble kernel: sd 0:0:0:0: [sda] 1250261615 512-byte logical blocks: (640 GB/596 GiB)
Nov 22 20:49:21 marble kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Nov 22 20:49:21 marble kernel: sd 0:0:0:0: [sda] Write Protect is off
Nov 22 20:49:21 marble kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 20:49:21 marble kernel:  sda: sda1 sda2 < sda5 sda6 sda7 sda8 >
Nov 22 20:49:21 marble kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Nov 22 20:49:21 marble kernel: input: ImExPS/2 Logitech Wheel Mouse as /devices/platform/i8042/serio1/input/input3
Nov 22 20:49:21 marble kernel: ata2: SATA link down (SStatus 0 SControl 300)
Nov 22 20:49:21 marble kernel: ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 20:49:21 marble kernel: ata3.00: ATA-8: ST31000528AS, CC38, max UDMA/133
Nov 22 20:49:21 marble kernel: ata3.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
Nov 22 20:49:21 marble kernel: ata3.00: configured for UDMA/133
Nov 22 20:49:21 marble kernel: scsi 2:0:0:0: Direct-Access     ATA      ST31000528AS     CC38 PQ: 0 ANSI: 5
Nov 22 20:49:21 marble kernel: sd 2:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
Nov 22 20:49:21 marble kernel: sd 2:0:0:0: [sdb] Write Protect is off
Nov 22 20:49:21 marble kernel: sd 2:0:0:0: Attached scsi generic sg1 type 0
Nov 22 20:49:21 marble kernel: sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 20:49:21 marble kernel:  sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 >
Nov 22 20:49:21 marble kernel: sd 2:0:0:0: [sdb] Attached SCSI disk
Nov 22 20:49:21 marble kernel: ata4: SATA link down (SStatus 0 SControl 300)
Nov 22 20:49:21 marble kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Nov 22 20:49:21 marble kernel: ata5.00: ATAPI: HL-DT-ST BD-RE  GGW-H20L, YL03, max UDMA/133
Nov 22 20:49:21 marble kernel: ata5.00: configured for UDMA/133
Nov 22 20:49:21 marble kernel: scsi 4:0:0:0: CD-ROM            HL-DT-ST BD-RE  GGW-H20L  YL03 PQ: 0 ANSI: 5
Nov 22 20:49:21 marble kernel: cdrom: Uniform CD-ROM driver Revision: 3.20
Nov 22 20:49:21 marble kernel: sr 4:0:0:0: Attached scsi generic sg2 type 5
Nov 22 20:49:21 marble kernel: ata6: SATA link down (SStatus 0 SControl 300)
Nov 22 20:49:21 marble kernel: XFS mounting filesystem sda1
Nov 22 20:49:21 marble kernel: Freeing unused kernel memory: 328k freed
Nov 22 20:49:21 marble kernel: nosy 0000:09:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Nov 22 20:49:21 marble kernel: nosy 0000:09:00.0: Initialized PCILynx IEEE1394 card, irq=16
Nov 22 20:49:21 marble kernel: r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
Nov 22 20:49:21 marble kernel: r8169 0000:08:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Nov 22 20:49:21 marble kernel: r8169 0000:08:00.0: eth0: RTL8168d/8111d at 0xf8474000, 00:24:1d:15:5d:a9, XID 081000c0 IRQ 41
Nov 22 20:49:21 marble kernel: usbcore: registered new interface driver usbfs
Nov 22 20:49:21 marble kernel: usbcore: registered new interface driver hub
Nov 22 20:49:21 marble kernel: usbcore: registered new device driver usb
Nov 22 20:49:21 marble kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Nov 22 20:49:21 marble kernel: ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Nov 22 20:49:21 marble kernel: ehci_hcd 0000:00:1a.7: EHCI Host Controller
Nov 22 20:49:21 marble kernel: ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
Nov 22 20:49:21 marble kernel: ehci_hcd 0000:00:1a.7: debug port 1
Nov 22 20:49:21 marble kernel: ehci_hcd 0000:00:1a.7: irq 18, io mem 0xfdffe000
Nov 22 20:49:21 marble kernel: ohci1394 0000:09:06.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Nov 22 20:49:21 marble kernel: ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
Nov 22 20:49:21 marble kernel: hub 1-0:1.0: USB hub found
Nov 22 20:49:21 marble kernel: hub 1-0:1.0: 6 ports detected
Nov 22 20:49:21 marble kernel: ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
Nov 22 20:49:21 marble kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Nov 22 20:49:21 marble kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
Nov 22 20:49:21 marble kernel: ehci_hcd 0000:00:1d.7: debug port 1
Nov 22 20:49:21 marble kernel: ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfdffd000
Nov 22 20:49:21 marble kernel: uhci_hcd: USB Universal Host Controller Interface driver
Nov 22 20:49:21 marble kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
Nov 22 20:49:21 marble kernel: hub 2-0:1.0: USB hub found
Nov 22 20:49:21 marble kernel: hub 2-0:1.0: 6 ports detected
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1a.0: UHCI Host Controller
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000ff00
Nov 22 20:49:21 marble kernel: hub 3-0:1.0: USB hub found
Nov 22 20:49:21 marble kernel: hub 3-0:1.0: 2 ports detected
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1a.1: UHCI Host Controller
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000fe00
Nov 22 20:49:21 marble kernel: hub 4-0:1.0: USB hub found
Nov 22 20:49:21 marble kernel: hub 4-0:1.0: 2 ports detected
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1a.2: UHCI Host Controller
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000fd00
Nov 22 20:49:21 marble kernel: hub 5-0:1.0: USB hub found
Nov 22 20:49:21 marble kernel: hub 5-0:1.0: 2 ports detected
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000fc00
Nov 22 20:49:21 marble kernel: hub 6-0:1.0: USB hub found
Nov 22 20:49:21 marble kernel: hub 6-0:1.0: 2 ports detected
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000fb00
Nov 22 20:49:21 marble kernel: hub 7-0:1.0: USB hub found
Nov 22 20:49:21 marble kernel: hub 7-0:1.0: 2 ports detected
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
Nov 22 20:49:21 marble kernel: uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000fa00
Nov 22 20:49:21 marble kernel: hub 8-0:1.0: USB hub found
Nov 22 20:49:21 marble kernel: hub 8-0:1.0: 2 ports detected
Nov 22 20:49:21 marble kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[18]  MMIO=[fd1fe000-fd1fe7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
Nov 22 20:49:21 marble kernel: ENS1371 0000:09:01.0: BAR 0: set to [io  0xcf00-0xcf3f] (PCI address [0xcf00-0xcf3f]
Nov 22 20:49:21 marble kernel: ENS1371 0000:09:01.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Nov 22 20:49:21 marble kernel: Adding 12594924k swap on /dev/sda5.  Priority:-1 extents:1 across:12594924k 
Nov 22 20:49:21 marble kernel: XFS mounting filesystem sda6
Nov 22 20:49:21 marble kernel: XFS mounting filesystem sda7
Nov 22 20:49:21 marble kernel: XFS mounting filesystem sda8
Nov 22 20:49:21 marble logger: /etc/rc.d/rc.inet1:  /sbin/ifconfig lo 127.0.0.1
Nov 22 20:49:21 marble logger: /etc/rc.d/rc.inet1:  /sbin/route add -net 127.0.0.0 netmask 255.0.0.0 lo
Nov 22 20:49:22 marble logger: /etc/rc.d/rc.inet1:  /sbin/ifconfig eth0 192.168.1.1 broadcast 192.168.1.255 netmask 255.255.255.0
Nov 22 20:49:22 marble kernel: r8169 0000:08:00.0: eth0: link up
Nov 22 20:49:22 marble kernel: r8169 0000:08:00.0: eth0: link up
Nov 22 20:49:22 marble logger: /etc/rc.d/rc.inet1:  /sbin/route add default gw 192.168.1.254 metric 1
Nov 22 20:49:22 marble rpc.statd[1250]: Version 1.2.2 starting
Nov 22 20:49:22 marble sm-notify[1251]: Version 1.2.2 starting
Nov 22 20:49:23 marble sshd[1262]: Server listening on 0.0.0.0 port 22.
Nov 22 20:49:23 marble acpid: starting up with proc fs 
Nov 22 20:49:23 marble acpid: skipping conf file /etc/acpi/events/. 
Nov 22 20:49:23 marble acpid: skipping conf file /etc/acpi/events/.. 
Nov 22 20:49:23 marble acpid: 1 rule loaded 
Nov 22 20:49:23 marble acpid: waiting for events: event logging is off 
Nov 22 20:49:29 marble /usr/sbin/gpm[1343]: *** info [startup.c(95)]: 
Nov 22 20:49:29 marble /usr/sbin/gpm[1343]: Started gpm successfully. Entered daemon mode.
Nov 22 20:49:29 marble kernel: ieee1394: raw1394: /dev/raw1394 device initialized
Nov 22 20:49:29 marble /usr/sbin/gpm[1343]: *** info [mice.c(1766)]: 
Nov 22 20:49:29 marble /usr/sbin/gpm[1343]: imps2: Auto-detected intellimouse PS/2
Nov 22 20:50:39 marble acpid: client connected from 1402[0:100] 
Nov 22 20:50:39 marble acpid: 1 client rule loaded 
Nov 22 20:50:39 marble kernel: pci 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Nov 22 20:50:40 marble kernel: Linux agpgart interface v0.103
Nov 22 20:50:40 marble kernel: [drm] Initialized drm 1.1.0 20060810
Nov 22 20:50:40 marble kernel: [drm] radeon defaulting to userspace modesetting.
Nov 22 20:50:40 marble kernel: [drm] Initialized radeon 1.33.0 20080528 for 0000:02:00.0 on minor 0
Nov 22 20:50:40 marble kernel: [drm] Setting GART location based on new memory map
Nov 22 20:50:40 marble kernel: [drm] Loading RV710 CP Microcode
Nov 22 20:50:40 marble kernel: [drm] Resetting GPU
Nov 22 20:50:40 marble kernel: [drm] writeback test succeeded in 1 usecs
Nov 22 20:55:18 marble kernel: ata3: hard resetting link
Nov 22 20:55:23 marble kernel: ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 20:55:23 marble kernel: ata3.00: configured for UDMA/133
Nov 22 20:55:23 marble kernel: ata3: EH complete
Nov 22 20:55:23 marble kernel: sdb: detected capacity change from 0 to 1000204886016
Nov 22 20:55:32 marble kernel: ata3: hard resetting link
Nov 22 20:55:37 marble kernel: ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 20:55:37 marble kernel: ata3.00: configured for UDMA/133
Nov 22 20:55:37 marble kernel: ata3: EH complete
Nov 22 20:55:37 marble kernel: sdb: detected capacity change from 0 to 1000204886016
Nov 22 20:57:04 marble kernel: ata3: hard resetting link
Nov 22 20:57:09 marble kernel: ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 20:57:09 marble kernel: ata3.00: configured for UDMA/133
Nov 22 20:57:09 marble kernel: ata3: EH complete
Nov 22 20:57:34 marble kernel: ata3: hard resetting link
Nov 22 20:57:39 marble kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 20:57:39 marble kernel: ata3.00: configured for UDMA/133
Nov 22 20:57:39 marble kernel: ata3: EH complete
Nov 22 20:57:41 marble kernel: ata3: hard resetting link
Nov 22 20:57:46 marble kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 20:57:46 marble kernel: ata3.00: configured for UDMA/133
Nov 22 20:57:46 marble kernel: ata3: EH complete
Nov 22 21:03:29 marble kernel: ata3: hard resetting link
Nov 22 21:03:34 marble kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 21:03:34 marble kernel: ata3.00: configured for UDMA/133
Nov 22 21:03:34 marble kernel: ata3: EH complete
Nov 22 21:03:36 marble kernel: ata3: hard resetting link
Nov 22 21:03:41 marble kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 21:03:41 marble kernel: ata3.00: configured for UDMA/133
Nov 22 21:03:41 marble kernel: ata3: EH complete
Nov 22 21:03:44 marble kernel: ata3: hard resetting link
Nov 22 21:03:49 marble kernel: ata3: SATA link down (SStatus 0 SControl 310)
Nov 22 21:03:54 marble kernel: ata3: hard resetting link
Nov 22 21:03:58 marble kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 21:03:58 marble kernel: ata3.00: configured for UDMA/100
Nov 22 21:03:58 marble kernel: ata3: EH complete
Nov 22 21:04:08 marble kernel: ata3: hard resetting link
Nov 22 21:04:13 marble kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 21:04:13 marble kernel: ata3.00: configured for UDMA/100
Nov 22 21:04:13 marble kernel: ata3: EH complete
Nov 22 21:04:18 marble kernel: ata3: hard resetting link
Nov 22 21:04:23 marble kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 21:04:23 marble kernel: ata3.00: configured for UDMA/33
Nov 22 21:04:23 marble kernel: ata3: EH complete
Nov 22 21:04:23 marble kernel: ata3: hard resetting link
Nov 22 21:04:28 marble kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 21:04:28 marble kernel: ata3.00: configured for UDMA/33
Nov 22 21:04:28 marble kernel: ata3: EH complete
Nov 22 21:04:39 marble kernel: ata3: hard resetting link
Nov 22 21:04:44 marble kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 21:04:44 marble kernel: ata3.00: configured for UDMA/33
Nov 22 21:04:44 marble kernel: ata3: EH complete
Nov 22 21:04:56 marble kernel: ata3: hard resetting link
Nov 22 21:05:01 marble kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 21:05:01 marble kernel: ata3.00: configured for UDMA/33
Nov 22 21:05:01 marble kernel: ata3: EH complete
Nov 22 21:05:37 marble kernel: ata3: hard resetting link
Nov 22 21:05:42 marble kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 21:05:42 marble kernel: ata3.00: configured for UDMA/33
Nov 22 21:05:42 marble kernel: ata3: EH complete
Nov 22 21:06:24 marble kernel: ata3: hard resetting link
Nov 22 21:06:29 marble kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 21:06:29 marble kernel: ata3.00: configured for UDMA/33
Nov 22 21:06:29 marble kernel: ata3: EH complete
Nov 22 21:06:38 marble kernel: ata3: hard resetting link
Nov 22 21:06:43 marble kernel: ata3: SATA link down (SStatus 0 SControl 310)
Nov 22 21:06:48 marble kernel: ata3: hard resetting link
Nov 22 21:06:48 marble kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 21:06:48 marble kernel: ata3.00: configured for UDMA/33
Nov 22 21:06:48 marble kernel: ata3: EH complete
Nov 22 21:07:03 marble kernel: ata3: hard resetting link
Nov 22 21:07:13 marble kernel: ata3: hard resetting link
Nov 22 21:07:14 marble kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 21:07:14 marble kernel: ata3.00: configured for UDMA/33
Nov 22 21:07:14 marble kernel: ata3: EH complete
Nov 22 21:29:21 marble -- MARK --
Nov 22 21:49:21 marble -- MARK --
