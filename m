From: beolach@juno.com
Subject: Re: Promise IDE controller crashes 2.4.22
Date: Sat, 29 Nov 2003 22:07:32 GMT
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031129.140802.28395.1074931@webmail05.lax.untd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound29-sr.lax.untd.com ([64.136.29.170]:27299 "HELO
	outbound29-sr.lax.untd.com") by vger.kernel.org with SMTP
	id S263983AbTK2WIt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Nov 2003 17:08:49 -0500
List-Id: linux-ide@vger.kernel.org
To: jgoerzen@complete.org
Cc: linux-ide@vger.kernel.org


I recently had a very similar problem to this on my computer with a
Promise Ultra133TX2 (PDC20269) addon card.  In my case I had a Western
Digital drive attached to the PDC20269 that would have major filesystem
corruption when DMA was enabled during the boot process.  Interestingly,
if I disabled DMA during boot, and then enabled it after boot with
hdparm, the drive worked OK.  Also, if I moved the drive to my
mainboard's IDE controller, it would work.  It seemed to be a
combination of my drive & IDE controller, because the IDE controller
works fine with other drives, and the WD hard drive worked fine with
another IDE controller.  I replaced the drive (20 GB) with a 120 GB
Maxtor drive, and haven't had any problem since.

Just something similar that happened to me,
Conway S. Smith


-- John Goerzen <jgoerzen@complete.org> wrote:
On Fri, Nov 28, 2003 at 12:16:48AM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> Can you first try booting with "ide2=autodma" kernel parameter
> instead of downgrading to UDMA100?

This caused the system to boot up with DMA disabled for the relevant
drive.  (Note: that may also be how it was working before.)  Here is a
diff from the previous dmesg to this one:

--- dmesg       2003-11-27 17:51:54.000000000 -0500
+++ dmesg2      2003-11-27 21:04:14.000000000 -0500
@@ -9,9 +9,10 @@
 zone(0): 4096 pages.
 zone(1): 94208 pages.
 zone(2): 0 pages.
-Kernel command line: root=/dev/hdc1 ro rootfstype=ext3
+Kernel command line: root=/dev/hdc1 ro rootfstype=ext3 ide2=autodma
+ide_setup: ide2=autodma -- BAD OPTION
 Initializing CPU#0
-Detected 400.919 MHz processor.
+Detected 400.923 MHz processor.
 Console: colour VGA+ 80x25
 Calibrating delay loop... 799.53 BogoMIPS
 Memory: 386700k/393216k available (1137k kernel code, 6132k reserved,
465k data, 76k init, 0k highmem)
@@ -55,7 +56,6 @@
 VP_IDE: IDE controller at PCI slot 00:07.1
 VP_IDE: chipset revision 6
 VP_IDE: not 100% native mode: will probe irqs later
-ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
 VP_IDE: VIA vt82c596b (rev 12) IDE UDMA66 controller on pci00:07.1
     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
@@ -113,7 +113,3 @@
 EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,1), internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
-blk: queue c02cc320, I/O limit 4095Mb (mask 0xffffffff)
-blk: queue c02cc774, I/O limit 4095Mb (mask 0xffffffff)
-blk: queue c02ccbc8, I/O limit 4095Mb (mask 0xffffffff)
-hde: DMA disabled

Also, here's some hdparm info:

# hdparm -i /dev/hde

/dev/hde:

 Model=Maxtor 6Y160P0, FwRev=YAR41VW0, SerialNo=xxxxxxxx
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):  1 2 3 4 5 6 7




________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!
