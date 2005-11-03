From: Bruno Harbulot <bruno_harbulot@yahoo.co.uk>
Subject: ATIIXP and libata
Date: Thu, 03 Nov 2005 23:53:14 +0000
Message-ID: <436AA2EA.2040508@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sp0152.sc1.cp.net ([64.97.136.152]:17499 "EHLO n064.sc1.cp.net")
	by vger.kernel.org with ESMTP id S1030552AbVKCXxS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Nov 2005 18:53:18 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Velu Erwan <erwan@seanodes.com>

Hello,


I am trying to make a SATA drive work (fast) on an Asus Pundit-R (P4R8L 
motherboard).
I have tried the patch posted on linux-ide by Erwan Velu on 10/10/05. It
works and hdparm indicates about 55MB/s (thanks Erwan).

However, Erwan's patch relies on testing the name of the pci device, in
drivers/ide/pci/atiixp.c:
if (strncmp(drive->name,"hdc",strlen("hdc")) == 0)

This solution is obviously not very generic. (Perhaps I should say that,
at least in my case, hda is a DVD drive on the IDE connector and hdc is
the SATA drive). As Bartlomiej Zolnierkiewicz replied to Erwan's
message, using libata's ata_id_is_sata would probably be a better route.

I have tried to have a look at this (in kernel 2.6.14), but I think
there is a major problem: atiixp is under ide/pci and doesn't seem to 
have anything to do with libata and the sata modules under the scsi 
directory. (Please feel free to correct me, linux-ide something very new 
to me.)
I have added some "printk"s in libata-core.c, in "ata_dev_config", where
it seems that the "ata_dev_knobble" test is made, but it is never called
(even when I make sure that ata_xiip and libata are loaded first in my
initrd image). Would this mean that this IDE/SATA(/PATA?) controller is
not handled my libata at all? Should it be?
(I don't know much about the subject, but I presume that workarounds to
get ata_id_is_sata "to work somehow" from atiixp.c would not be the
right thing to do, even if feasible.)



I have also got another similar problem with this controller, which may 
or may not be related. This problem is more or less point number 3 of:
<http://www.debian.org/devel/debian-installer/errata>
("SATA driver can block access to CD drive in installations from CD").
When installing this machine, the hard drive and the DVD drive were
"conflicting", so I had to load a much as I could from the install CD
before loading the modules for the disk and subsequently proceeding with 
a network installation.
Moreover, once the system installed and running, I have not managed to 
mount a CD after booting from the hard drive. Even after using "hdparm 
-d 0 /dev/hda", I get errors such as this:
hda: DMA disabled
hda: DMA timeout retry
hda: timeout waiting for DMA
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: drive not ready for command



Regards,

Bruno.




In case it may help, here are the relevant lines from dmesg:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ATIIXP: IDE controller at PCI slot 0000:00:14.1
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 177
ATIIXP: chipset revision 0
ATIIXP: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HL-DT-ST DVDRAM GSA-4167B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Maxtor 6L200S0, ATA DISK drive
ATIIXP: SATA drive detected (hdc) on a IXP200 IDE controller, 
         skipping cable detection, using ATA-100 transfert rate
ATIIXP: SATA drive detected (hdc) on a IXP200 IDE controller, 
         skipping cable detection, using ATA-100 transfert rate
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hdc: max request size: 1024KiB
hdc: 398297088 sectors (203928 MB) w/16384KiB Cache, CHS=24792/255/63
hdc: cache flushes supported
  /dev/ide/host0/bus1/target0/lun0: p1 p2 p3 p4 < p5 >
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1951888k swap on /dev/hdc2.  Priority:-1 extents:1
EXT3 FS on hdc3, internal journal
hda: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20

