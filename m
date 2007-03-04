From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [BUG] pata_legacy reserves too many io/irq resources
Date: Sun, 4 Mar 2007 01:56:18 +0100 (MET)
Message-ID: <200703040056.l240uIvu006511@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:50777 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbXCDA40 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Mar 2007 19:56:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@redhat.com
Cc: linux-ide@vger.kernel.org

pata_legacy probes 6 io/ctr/irq combinations for devices.
Or rather, it loops, claims an io/ctr/irq combination, does
an ata_device_add(), and libata then does the probing.

However, the io/ctr/irq resource combinations aren't released
after failed probes (as in: no devices found). The result is
that other devices that need those resources fail to initialise.

On my ISA/VLB 486, pata_legacy leaves /proc/interrupts as follows:

           CPU0       
  0:      19918    XT-PIC-XT        timer
  1:        363    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  6:          5    XT-PIC-XT        floppy
  8:          1    XT-PIC-XT        rtc
 10:          3    XT-PIC-XT        libata
 11:          0    XT-PIC-XT        libata
 12:          0    XT-PIC-XT        libata
 14:       4865    XT-PIC-XT        libata
 15:          0    XT-PIC-XT        libata
NMI:          0 
ERR:          0

and /proc/ioports as follows:

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
c1bc6c40-0000 : <BAD>
0168-016f : pata_legacy
0170-0177 : pata_legacy
01e0-01e7 : pata_legacy
01e8-01ef : pata_legacy
01f0-01f7 : pata_legacy
0366-0366 : pata_legacy
036e-036e : pata_legacy
0376-0376 : pata_legacy
03c0-03df : vga+
03e6-03e6 : pata_legacy
03ee-03ee : pata_legacy
03f2-03f5 : floppy
03f6-03f6 : pata_legacy
03f7-03f7 : floppy DIR

This later prevents the ne driver from finding the machine's
NE2000 network card (at io=0x300 irq=10):

ata1: PATA max PIO4 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x00000000 irq 14
scsi0 : pata_legacy
ata1.00: ATA-0: WDC AC32500H, 10.07H11, max MWDMA2
ata1.00: 4999680 sectors, multi 8: LBA 
ata1.00: configured for PIO
scsi 0:0:0:0: Direct-Access     ATA      WDC AC32500H     10.0 PQ: 0 ANSI: 5
SCSI device sda: 4999680 512-byte hdwr sectors (2560 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 4999680 512-byte hdwr sectors (2560 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 >
sd 0:0:0:0: Attached scsi disk sda
ata2: PATA max PIO4 cmd 0x00010170 ctl 0x00010376 bmdma 0x00000000 irq 15
scsi1 : pata_legacy
ata3: PATA max PIO4 cmd 0x000101e8 ctl 0x000103ee bmdma 0x00000000 irq 11
scsi2 : pata_legacy
ata4: PATA max PIO4 cmd 0x00010168 ctl 0x0001036e bmdma 0x00000000 irq 10
scsi3 : pata_legacy
ata5: PATA max PIO4 cmd 0x000101e0 ctl 0x000103e6 bmdma 0x00000000 irq 8
platform pata_legacy.4: irq 8 request failed: -16
ata6: PATA max PIO4 cmd 0x00010160 ctl 0x00010366 bmdma 0x00000000 irq 12
scsi5 : pata_legacy
...
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x300: failed to detect IRQ line.
ne.c: No NE*000 card found at i/o = 0x300

I think that pata_legacy.c:legacy_init_one() should have a test
after its ata_device_add(), so that if no devices were discovered
there is a 'goto fail;' to free the resources.

Apart from this issue, pata_legacy is working very well on this machine.

/Mikael
