From: Mark Cooke <mpc@jts.homeip.net>
Subject: 2.4.26rc1 / HPT 374 / RAID = data read corruption with disks on
	primary channels.
Date: Tue, 30 Mar 2004 21:04:18 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1080677057.11947.83.camel@sage.kitchen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-i/gTEYUFClbgl7xPClVl"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:24898 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261263AbUC3UE1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Mar 2004 15:04:27 -0500
Received: from 82-36-98-143.cable.ubr01.king.blueyonder.co.uk (localhost.localdomain [127.0.0.1])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by sage.kitchen (Postfix) with ESMTP id 882DDC432F
	for <linux-ide@vger.kernel.org>; Tue, 30 Mar 2004 21:04:18 +0100 (BST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--=-i/gTEYUFClbgl7xPClVl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

I've been having some trouble with an Abit IT7 machine.  It is a
pentium-4 machine, 1GB ram (passes days of all-test memtest86), 80GB
seagate on the ICH4 as the system disk.  4 x 160GB seagates, one on each
channel of the HPT374.

hdc: ICH4            80GB ST380021A  FwRev=3.10
hde: HPT Disk 0     160GB ST3160023A FwRev=3.04
hdg: HPT Disk 1     160GB ST3160023A FwRev=3.06
hdi: HPT Disk 2     160GB ST3160023A FwRev=3.06
hdk: HPT Disk 3     160GB ST3160023A FwRev=3.06

The 160G disks are all split into 4 partitions, and a set of 4-disk
RAID-5 partitions created using one partition from each disk.  All are
running ext3.

Checksumming a large (>RAM sized) file on any of the raid-5 devices
gives a different checksum every time.  Ie 'while true; do md5sum
big_file ; done' produces a list of different checksums. The same file
on the ICH4 works as expected.

Characterising the errors shows random blocks of 4-byte corruption.  I
ran a second test copying file 1 to file 2, and doing a 'cmp -l 1 2',
and on a 1GB file it gave 20 bytes of errors, in 5 groups of 4
contiguous bytes.  The errors do not have an obvious pattern of single
bit errors, nor am I seeing any messages in the system logs relating to
the file copying.  The number of location of the errors varies without
any obvious pattern.

All the disks passed their individual (long offline) SMART self-test's,
a dd if=/dev/hdX of=/dev/null, and are all connected as udma5, with
80wire cables.  Drive temperatures are all showing under 40C after an
extended period of intensive file checksumming / copying.

See below for details of the further work I did to track this, but at
this point, I believe there is some strange issue with the primary
channel on the two highpoint controllers that does not exist for the two
drives on the secondary channels, as arrays built from disks 1+3 work
without errors, whereas any use of disks 0+2 produces random read
errors.

Questions:

Any known issues with what I'm trying to do ?

Any workarounds / suggestions for isolating the problem ?

Any recommendations for PCI ide cards that work right ?


Thanks for any input!

Mark


Futher investigation summary:

After finding the above I moved the data off one of the raid-5
partitions and did some experiments with different disks/raid levels:

1. 4 disk raid-0 stripe.  This gave the 4-byte corruption errors.

2. 2 disk raid-0 stripe, using disk0+2.  This gave the same 4-byte
corruption errors.

3. 2 disk raid-1 mirror, using disk1+3, but with disk-3 failed out of
the array to reduce i/o to a minimal level.  This works without errors.

4. 2 disk raid-1 mirror. using disk1+3.  This works without errors.

5. 2 disk raid-1 mirror, using disk0+2.  This produces errors again.

6. 2 disk raid-1 mirror, using disk0+2, with disk-2 failed out of the
array.  More errors.

7. 2 disk raid-1 mirror, using disk0+2, with disk-0 failed out of the
array.  More errors.


Example cmp -l output from a 1GB file:

294961149   6 204
294961150   0 317
294961151 223 311
294961152 377  40
434229245 173   3
434229246  16   4
434229247 342  23
434229248 141 210
497602557  65 377
497602558  71 377
497602559 220 377
497602560  42 377
625459197  35  36
625459198 263 151
625459199 252 244
625459200 322 102
634101757 377  17
634101758 377 232
634101759 377 302
634101760 377 234

lspci:

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 11)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 11)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01)
00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 01)
01:00.0 VGA compatible controller: nVidia Corporation NV11DDR [GeForce2 MX 100 DDR/200 DDR] (rev b2)
02:00.0 Multimedia video controller: Brooktree Corporation Bt848 Video Capture (rev 12)
02:01.0 SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev 01)
02:02.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
02:03.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset (rev 01)
02:04.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
02:04.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
02:05.0 USB Controller: VIA Technologies, Inc. USB (rev 50)
02:05.1 USB Controller: VIA Technologies, Inc. USB (rev 50)
02:05.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 IEEE-1394a-2000 Controller (PHY/Link)

proc/interrupts:

           CPU0
  0:     299882    IO-APIC-edge  timer
  1:          5    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  7:          0          XT-PIC  parport0
  8:          1    IO-APIC-edge  rtc
14:      71251    IO-APIC-edge  ide0
15:     505029    IO-APIC-edge  ide1
16:     222120   IO-APIC-level  usb-uhci, bttv0, nvidia
17:         21   IO-APIC-level  DC395x_TRM, Intel 82801DB-ICH4, ohci1394
18:      76625   IO-APIC-level  usb-uhci, usb-uhci, eth0
19:      24273   IO-APIC-level  usb-uhci, usb-uhci, wifi0
20:    2913200   IO-APIC-level  ide2, ide3, ide4, ide5
21:          0   IO-APIC-level  ehci_hcd
22:       4338   IO-APIC-level  eth1
23:          0   IO-APIC-level  ehci_hcd
NMI:          0
LOC:     299838
ERR:          0
MIS:          0
raidtab:

raiddev /dev/md1
        raid-level              5
        nr-raid-disks           4
        nr-spare-disks          0
        persistent-superblock   1
        chunk-size              32

        device          /dev/hde1
        raid-disk       0

        device          /dev/hdg1
        raid-disk       1

        device          /dev/hdi1
        raid-disk       2

        device          /dev/hdk1
        raid-disk       3

raiddev /dev/md2
        raid-level              5
        nr-raid-disks           4
        nr-spare-disks          0
        persistent-superblock   1
        chunk-size              32

        device          /dev/hde2
        raid-disk       0

        device          /dev/hdg2
        raid-disk       1

        device          /dev/hdi2
        raid-disk       2

        device          /dev/hdk2
        raid-disk       3

raiddev /dev/md3
        raid-level              5
        nr-raid-disks           4
        nr-spare-disks          0
        persistent-superblock   1
        chunk-size              32

        device          /dev/hde3
        raid-disk       0

        device          /dev/hdg3
        raid-disk       1

        device          /dev/hdi3
        raid-disk       2

        device          /dev/hdk3
        raid-disk       3

raiddev /dev/md4
        raid-level              0
        nr-raid-disks           4
        nr-spare-disks          0
        persistent-superblock   1
        chunk-size              64

        device          /dev/hde4
        raid-disk       0

        device          /dev/hdg4
        raid-disk       1

        device          /dev/hdi4
        raid-disk       2

        device          /dev/hdk4
        raid-disk       3

dmesg extract:

hda: JLMS XJ-HD165H, ATAPI CD/DVD-ROM drive
hdb: CD-RW CDR-6S52, ATAPI CD/DVD-ROM drive
hdc: ST380021A, ATA DISK drive
hde: ST3160023A, ATA DISK drive
hdg: ST3160023A, ATA DISK drive
hdi: ST3160023A, ATA DISK drive
hdk: ST3160023A, ATA DISK drive
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 312581808 sectors (160042 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
hdg: attached ide-disk driver.
hdg: host protected area => 1
hdg: 312581808 sectors (160042 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
hdi: attached ide-disk driver.
hdi: host protected area => 1
hdi: 312581808 sectors (160042 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
hdk: attached ide-disk driver.
hdk: host protected area => 1
hdk: 312581808 sectors (160042 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
hdc: hdc1 hdc2 hdc3 hdc4
hde: hde1 hde2 hde3 hde4
hdg: hdg1 hdg2 hdg3 hdg4
hdi: hdi1 hdi2 hdi3 hdi4
hdk: hdk1 hdk2 hdk3 hdk4

/proc/ide/hpt366
 
                             HighPoint HPT366/368/370/372/374
 
Controller: 0
Chipset: HPT374
--------------- Primary Channel --------------- Secondary Channel --------------Enabled:        yes                             yes
Cable:          ATA-66                          ATA-66
 
--------------- drive0 --------- drive1 ------- drive0 ---------- drive1 -------DMA capable:    yes              no             yes               no
Mode:           UDMA             off            UDMA              off
 
Controller: 1
Chipset: HPT374
--------------- Primary Channel --------------- Secondary Channel --------------Enabled:        yes                             yes
Cable:          ATA-66                          ATA-66
 
--------------- drive0 --------- drive1 ------- drive0 ---------- drive1 -------DMA capable:    yes              no             yes               no
Mode:           UDMA             off            UDMA              off
 

/proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.00GHz
stepping        : 4
cpu MHz         : 2009.991
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4010.80

kernel config and drive smart logs attached.

--=-i/gTEYUFClbgl7xPClVl
Content-Disposition: attachment; filename=config.gz
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64

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
CWX9fwo6lb9ZpAAA

--=-i/gTEYUFClbgl7xPClVl
Content-Disposition: attachment; filename=smart.gz
Content-Type: application/x-gzip; name=smart.gz
Content-Transfer-Encoding: base64

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
lgj3lwiNdyTC/wGrOJsGDkcAAA==

--=-i/gTEYUFClbgl7xPClVl--

