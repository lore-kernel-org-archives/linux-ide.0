From: Siddhartha Jain <siddhartha@siddharthajain.net>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during
 suspend to RAM
Date: Sat, 28 Aug 2010 13:28:10 -0700
Message-ID: <1283027290.2721.37.camel@myfedorahat>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33716 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab0H1U2O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Aug 2010 16:28:14 -0400
Received: by pzk9 with SMTP id 9so1543631pzk.19
        for <linux-ide@vger.kernel.org>; Sat, 28 Aug 2010 13:28:13 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I have the same symptom as Stephan and came across this thread while
googling for more info.

Hardware: Macbook Pro 5,4 (Firmware version 1.7)

OS: Fedora 13 x64 
Kernel: 2.6.33.8-149.fc13.x86_64 (stock fedora kernel)
Modifications: Video is on Nvidia proprietary driver and Root and swap
are encrypted with luks. Kernel boot parameters are:

kernel /vmlinuz-2.6.33.8-149.fc13.x86_64 ro
root=/dev/mapper/luks-f01b2a77-921b-45c1-8f28-6095ab3a56f1
rd_LUKS_UUID=luks-f01b2a77-921b-45c1-8f28-6095ab3a56f1
rd_LUKS_UUID=luks-91e5037b-267c-4572-
9c99-baaa5ca41600 rd_NO_LVM rd_NO_MD rd_NO_DM LANG=en_US.UTF-8
SYSFONT=latarcyrheb-sun16 KEYTABLE=us rhgb rdblacklist=nouveau vga=792
resume=UUID=91e5037b-267c-4572-9c99-baaa5ca41600 

The system seems to go to suspend alright but on resume, the hdd does
not seem to wake-up. After resume, in X, the login screen background
shows up but the login prompt box does not. If I am logged in before
suspend then after resume, every command I run including reboot/shutdown
etc returns Input/Output error. After resume, if I try to ssh in, I get
the ssh prompt but authentication does not succeed and I get password
failures. 

Bit more HW/SW info:

1. From lspci -vv
00:0b.0 IDE interface: nVidia Corporation MCP79 SATA Controller (rev b1)
(prog-if 85 [Master SecO PriO])
	Subsystem: nVidia Corporation Device cb79
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 27
	Region 0: I/O ports at 21d8 [size=8]
	Region 1: I/O ports at 21ec [size=4]
	Region 2: I/O ports at 21d0 [size=8]
	Region 3: I/O ports at 21e8 [size=4]
	Region 4: I/O ports at 21c0 [size=16]
	Region 5: Memory at d3584000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] SATA HBA v1.0 InCfgSpace
	Capabilities: [b0] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee0200c  Data: 4181
	Kernel driver in use: ahci
	Kernel modules: ata_generic, pata_acpi


2. HDD Info from smartctl
# smartctl -a /dev/sda
smartctl 5.39.1 2010-01-28 r3054 [x86_64-redhat-linux-gnu] (local build)
Copyright (C) 2002-10 by Bruce Allen,
http://smartmontools.sourceforge.net

=== START OF INFORMATION SECTION ===
Device Model:     FUJITSU MJA2250BH FFS G1
Serial Number:    K94DTA22N7C1
Firmware Version: 00810020
User Capacity:    250,059,350,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   8
ATA Standard is:  ATA-8-ACS revision 3f
Local Time is:    Sat Aug 28 13:09:06 2010 PDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled


3. ATA related messages from bootup (dmesg | grep ATA)
ata1: SATA max UDMA/133 irq_stat 0x00400000, PHY RDY changed irq 27
ata2: SATA max UDMA/133 irq_stat 0x00400000, PHY RDY changed irq 27
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-8: FUJITSU MJA2250BH FFS G1, 00810020, max UDMA/100
ata2.00: ATAPI: HL-DT-ST DVDRW  GS23N, SB03, max UDMA/133
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MJA2250B 0081 PQ: 0
ANSI: 5
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)


4. # cat /sys/class/scsi_host/host0/link_power_management_policy 
max_performance


5. Some odd errors at boot-up related to 'ata' (captured by directing
*.* to a log file in rsyslog)
Aug 28 11:49:39 myfedorahat kernel: ACPI: SSDT 00000000bfee4000 000A5
(v01 SataRe  SataPri 00001000 INTL 20061109)
Aug 28 11:49:39 myfedorahat kernel: ACPI: SSDT 00000000bfee3000 0009F
(v01 SataRe  SataSec 00001000 INTL 20061109)
Aug 28 11:49:39 myfedorahat kernel:  #0 [0000000000 - 0000001000]   BIOS
data page ==> [0000000000 - 0000001000]
Aug 28 11:49:39 myfedorahat kernel: Kernel command line: ro
root=/dev/mapper/luks-f01b2a77-921b-45c1-8f28-6095ab3a56f1
rd_LUKS_UUID=luks-f01b2a77-921b-45c1-8f28-6095ab3a56f1
rd_LUKS_UUID=luks-91e5037b-26
7c-4572-9c99-baaa5ca41600 rd_NO_LVM rd_NO_MD rd_NO_DM LANG=en_US.UTF-8
SYSFONT=latarcyrheb-sun16 KEYTABLE=us rhgb rdblacklist=nouveau vga=792
resume=UUID=91e5037b-267c-4572-9c99-baaa5ca41600 
Aug 28 11:49:39 myfedorahat kernel: Memory: 3758324k/5242880k available
(4289k kernel code, 1336536k absent, 148020k reserved, 7539k data, 756k
init)
Aug 28 11:49:39 myfedorahat kernel: ACPI: EC: GPE = 0x3f, I/O:
command/status = 0x66, data = 0x62
Aug 28 11:49:39 myfedorahat kernel: libata version 3.00 loaded.
Aug 28 11:49:39 myfedorahat kernel: ata1: SATA max UDMA/133 irq_stat
0x00400000, PHY RDY changed irq 27
Aug 28 11:49:39 myfedorahat kernel: ata2: SATA max UDMA/133 irq_stat
0x00400000, PHY RDY changed irq 27
Aug 28 11:49:39 myfedorahat kernel: ata3: DUMMY
Aug 28 11:49:39 myfedorahat kernel: ata4: DUMMY
Aug 28 11:49:39 myfedorahat kernel: ata5: DUMMY
Aug 28 11:49:39 myfedorahat kernel: ata6: DUMMY
Aug 28 11:49:39 myfedorahat kernel: ata1: SATA link up 1.5 Gbps (SStatus
113 SControl 300)
Aug 28 11:49:39 myfedorahat kernel: ata2: SATA link up 1.5 Gbps (SStatus
113 SControl 300)
Aug 28 11:49:39 myfedorahat kernel: ata1.00: ATA-8: FUJITSU MJA2250BH
FFS G1, 00810020, max UDMA/100
Aug 28 11:49:39 myfedorahat kernel: ata1.00: 488397168 sectors, multi
16: LBA48 NCQ (depth 31/32)
Aug 28 11:49:39 myfedorahat kernel: ata1.00: configured for UDMA/100
Aug 28 11:49:39 myfedorahat kernel: ata1: exception Emask 0x10 SAct 0x0
SErr 0x5850000 action 0xe frozen
Aug 28 11:49:39 myfedorahat kernel: ata1: irq_stat 0x00000040,
connection status changed
Aug 28 11:49:39 myfedorahat kernel: ata1: SError: { PHYRdyChg CommWake
LinkSeq TrStaTrns DevExch }
Aug 28 11:49:39 myfedorahat kernel: ata2.00: ATAPI: HL-DT-ST DVDRW
GS23N, SB03, max UDMA/133
Aug 28 11:49:39 myfedorahat kernel: ata1: hard resetting link
Aug 28 11:49:39 myfedorahat kernel: ata2.00: configured for UDMA/133
Aug 28 11:49:39 myfedorahat kernel: ata2: exception Emask 0x10 SAct 0x0
SErr 0x5950000 action 0xe frozen
Aug 28 11:49:39 myfedorahat kernel: ata2: irq_stat 0x00400040,
connection status changed
Aug 28 11:49:39 myfedorahat kernel: ata2: SError: { PHYRdyChg CommWake
Dispar LinkSeq TrStaTrns DevExch }
Aug 28 11:49:39 myfedorahat kernel: ata2: hard resetting link
Aug 28 11:49:39 myfedorahat kernel: ata1: SATA link up 1.5 Gbps (SStatus
113 SControl 300)
Aug 28 11:49:39 myfedorahat kernel: ata1.00: configured for UDMA/100
Aug 28 11:49:39 myfedorahat kernel: ata1: EH complete
Aug 28 11:49:39 myfedorahat kernel: ata2: SATA link up 1.5 Gbps (SStatus
113 SControl 300)
Aug 28 11:49:39 myfedorahat kernel: ata2.00: configured for UDMA/133
Aug 28 11:49:39 myfedorahat kernel: ata2: EH complete
Aug 28 11:49:39 myfedorahat kernel: Write protecting the kernel
read-only data: 10240k
Aug 28 11:49:39 myfedorahat kernel: EXT4-fs (dm-0): mounted filesystem
with ordered data mode
Aug 28 11:49:39 myfedorahat kernel: EXT4-fs (sda1): mounted filesystem
with ordered data mode


I am going to try pointing rsyslog at a remote syslog server to see if I
can capture what happens at resume-time but any other pointers to
debug/troubleshoot this issue will be helpful. I tried booting with
"pci=nomsi" but that makes the box hang at boot-up. Tried disabling acpi
and switched to APM but that seems risky because after suspend, APM does
not seem to have control over CPU and fans. With APM enabled, I did a
suspend and put the macbook in my bag. Four hours later when I pulled it
out of the bag, the fan was spinning at highest RPM and the macbook was
running really hot. With ACPI, at least, all the damage is only to
filesystem when I have to force reboot on resume :)

Thanks,

- Siddhartha

