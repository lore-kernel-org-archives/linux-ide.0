From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] ide-io.c: remove unused unplugged iops
Date: Tue, 3 Feb 2004 16:53:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200402031653.58112.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Introduced in 2.4.21 and never used.

 linux-2.6.2-rc3-bk3-root/drivers/ide/ide-iops.c |   69 ------------------------
 1 files changed, 69 deletions(-)

diff -puN drivers/ide/ide-iops.c~ide_unplugged_iops_cleanup drivers/ide/ide-iops.c
--- linux-2.6.2-rc3-bk3/drivers/ide/ide-iops.c~ide_unplugged_iops_cleanup	2004-02-03 15:55:30.125381112 +0100
+++ linux-2.6.2-rc3-bk3-root/drivers/ide/ide-iops.c	2004-02-03 15:55:30.137379288 +0100
@@ -31,75 +31,6 @@
 #include <asm/bitops.h>
 
 /*
- *	IDE operator we assign to an unplugged device so that
- *	we don't trash new hardware assigned the same resources
- */
- 
-static u8 ide_unplugged_inb (unsigned long port)
-{
-	return 0xFF;
-}
-
-static u16 ide_unplugged_inw (unsigned long port)
-{
-	return 0xFFFF;
-}
-
-static void ide_unplugged_insw (unsigned long port, void *addr, u32 count)
-{
-}
-
-static u32 ide_unplugged_inl (unsigned long port)
-{
-	return 0xFFFFFFFF;
-}
-
-static void ide_unplugged_insl (unsigned long port, void *addr, u32 count)
-{
-}
-
-static void ide_unplugged_outb (u8 val, unsigned long port)
-{
-}
-
-static void ide_unplugged_outbsync (ide_drive_t *drive, u8 addr, unsigned long port)
-{
-}
-
-static void ide_unplugged_outw (u16 val, unsigned long port)
-{
-}
-
-static void ide_unplugged_outsw (unsigned long port, void *addr, u32 count)
-{
-}
-
-static void ide_unplugged_outl (u32 val, unsigned long port)
-{
-}
-
-static void ide_unplugged_outsl (unsigned long port, void *addr, u32 count)
-{
-}
-
-void unplugged_hwif_iops (ide_hwif_t *hwif)
-{
-	hwif->OUTB	= ide_unplugged_outb;
-	hwif->OUTBSYNC	= ide_unplugged_outbsync;
-	hwif->OUTW	= ide_unplugged_outw;
-	hwif->OUTL	= ide_unplugged_outl;
-	hwif->OUTSW	= ide_unplugged_outsw;
-	hwif->OUTSL	= ide_unplugged_outsl;
-	hwif->INB	= ide_unplugged_inb;
-	hwif->INW	= ide_unplugged_inw;
-	hwif->INL	= ide_unplugged_inl;
-	hwif->INSW	= ide_unplugged_insw;
-	hwif->INSL	= ide_unplugged_insl;
-}
-
-EXPORT_SYMBOL(unplugged_hwif_iops);
-
-/*
  *	Conventional PIO operations for ATA devices
  */
 

_
