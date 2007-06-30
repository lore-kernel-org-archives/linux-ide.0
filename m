From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 14/15] ide: remove stale changelog/comments/TODO from ide.c
Date: Sat, 30 Jun 2007 21:12:45 +0200
Message-ID: <200706302112.45276.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:51166 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbXF3TAX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 15:00:23 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1759269mue
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 12:00:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |   78 ------------------------------------------------------
 1 file changed, 78 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -16,10 +16,6 @@
  *   (usually 14 & 15).
  * There can be up to two drives per interface, as per the ATA-2 spec.
  *
- * Primary:    ide0, port 0x1f0; major=3;  hda is minor=0; hdb is minor=64
- * Secondary:  ide1, port 0x170; major=22; hdc is minor=0; hdd is minor=64
- * Tertiary:   ide2, port 0x???; major=33; hde is minor=0; hdf is minor=64
- * Quaternary: ide3, port 0x???; major=34; hdg is minor=0; hdh is minor=64
  * ...
  *
  *  From hd.c:
@@ -47,80 +43,6 @@
  *  This was a rewrite of just about everything from hd.c, though some original
  *  code is still sprinkled about.  Think of it as a major evolution, with
  *  inspiration from lots of linux users, esp.  hamish@zot.apana.org.au
- *
- *  Version 1.0 ALPHA	initial code, primary i/f working okay
- *  Version 1.3 BETA	dual i/f on shared irq tested & working!
- *  Version 1.4 BETA	added auto probing for irq(s)
- *  Version 1.5 BETA	added ALPHA (untested) support for IDE cd-roms,
- *  ...
- * Version 5.50		allow values as small as 20 for idebus=
- * Version 5.51		force non io_32bit in drive_cmd_intr()
- *			change delay_10ms() to delay_50ms() to fix problems
- * Version 5.52		fix incorrect invalidation of removable devices
- *			add "hdx=slow" command line option
- * Version 5.60		start to modularize the driver; the disk and ATAPI
- *			 drivers can be compiled as loadable modules.
- *			move IDE probe code to ide-probe.c
- *			move IDE disk code to ide-disk.c
- *			add support for generic IDE device subdrivers
- *			add m68k code from Geert Uytterhoeven
- *			probe all interfaces by default
- *			add ioctl to (re)probe an interface
- * Version 6.00		use per device request queues
- *			attempt to optimize shared hwgroup performance
- *			add ioctl to manually adjust bandwidth algorithms
- *			add kerneld support for the probe module
- *			fix bug in ide_error()
- *			fix bug in the first ide_get_lock() call for Atari
- *			don't flush leftover data for ATAPI devices
- * Version 6.01		clear hwgroup->active while the hwgroup sleeps
- *			support HDIO_GETGEO for floppies
- * Version 6.02		fix ide_ack_intr() call
- *			check partition table on floppies
- * Version 6.03		handle bad status bit sequencing in ide_wait_stat()
- * Version 6.10		deleted old entries from this list of updates
- *			replaced triton.c with ide-dma.c generic PCI DMA
- *			added support for BIOS-enabled UltraDMA
- *			rename all "promise" things to "pdc4030"
- *			fix EZ-DRIVE handling on small disks
- * Version 6.11		fix probe error in ide_scan_devices()
- *			fix ancient "jiffies" polling bugs
- *			mask all hwgroup interrupts on each irq entry
- * Version 6.12		integrate ioctl and proc interfaces
- *			fix parsing of "idex=" command line parameter
- * Version 6.13		add support for ide4/ide5 courtesy rjones@orchestream.com
- * Version 6.14		fixed IRQ sharing among PCI devices
- * Version 6.15		added SMP awareness to IDE drivers
- * Version 6.16		fixed various bugs; even more SMP friendly
- * Version 6.17		fix for newest EZ-Drive problem
- * Version 6.18		default unpartitioned-disk translation now "BIOS LBA"
- * Version 6.19		Re-design for a UNIFORM driver for all platforms,
- *			  model based on suggestions from Russell King and
- *			  Geert Uytterhoeven
- *			Promise DC4030VL now supported.
- *			add support for ide6/ide7
- *			delay_50ms() changed to ide_delay_50ms() and exported.
- * Version 6.20		Added/Fixed Generic ATA-66 support and hwif detection.
- *			Added hdx=flash to allow for second flash disk
- *			  detection w/o the hang loop.
- *			Added support for ide8/ide9
- *			Added idex=ata66 for the quirky chipsets that are
- *			  ATA-66 compliant, but have yet to determine a method
- *			  of verification of the 80c cable presence.
- *			  Specifically Promise's PDC20262 chipset.
- * Version 6.21		Fixing/Fixed SMP spinlock issue with insight from an old
- *			  hat that clarified original low level driver design.
- * Version 6.30		Added SMP support; fixed multmode issues.  -ml
- * Version 6.31		Debug Share INTR's and request queue streaming
- *			Native ATA-100 support
- *			Prep for Cascades Project
- * Version 7.00alpha	First named revision of ide rearrange
- *
- *  Some additional driver compile-time options are in ./include/linux/ide.h
- *
- *  To do, in likely order of completion:
- *	- modify kernel to obtain BIOS geometry for drives on 2nd/3rd/4th i/f
- *
  */
 
 #define	REVISION	"Revision: 7.00alpha2"
