From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Mon, 22 Jun 2009 19:38:26 +0200
Message-ID: <200906221938.27574.bzolnier@gmail.com>
References: <200906211446.38598.elendil@planet.nl> <200906221639.52205.bzolnier@gmail.com> <200906221716.05983.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756689AbZFVRet@vger.kernel.org>
In-Reply-To: <200906221716.05983.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday 22 June 2009 17:16:04 Frans Pop wrote:
> On Monday 22 June 2009, Bartlomiej Zolnierkiewicz wrote:
> > I promised to look into it but I still need a identify block content to
> > tell more (you can add #define DEBUG to the ide-probe.c so we will get
> > id before and after changing of transfer mode settings):
> 
> probing for hdd: present=0, media=32, probetype=ATA
> probing for hdd: present=0, media=32, probetype=ATAPI
> hdd: dumping identify data
> c085 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 2020 2020 2020 2020 2020 2020
> 2020 2020 2020 2020 0000 0000 0000 3841
> 2045 2020 2020 4443 522d 4d4f 3520 5836
> 412f 484b 2020 2020 2020 2020 2020 2020
> 2020 2020 2020 2020 2020 2020 2020 0000
> 0000 000f 0000 0003 0002 0200 0000 0000
> 0000 0000 0000 0000 0000 0000 0701 0701

Thanks.  Please notice 0701 0701 words above -- it means that this
device reports both SWDMA0 and MWDMA0 enabled at once (which results
in IDE layer failing DMA tuning).

The patch below should fix it and it would be quite interesting to try
it on vanilla kernel to see if it helps with unexpected IRQ problem.

However this still doesn't explain the regression fully -- we had
ide_id_dma_bug() checks since Dec 2007 (and equivalent ide_dma_verbose()
ones since almost forever) while 2.6.26 (which works fine) is much
younger than that.  I suspect that there are some other kernel changes
coming into the picture (Power Management?).  Would it be possible
to try 2.6.2[78] and/or bisect this problem further?

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: relax DMA info validity checking

There are some broken devices that report multiple DMA xfer modes
enabled at once (ATA spec doesn't allow it) but otherwise work fine
with DMA so just delete ide_id_dma_bug().

Cc: David Miller <davem@davemloft.net>
Reported-by: Frans Pop <elendil@planet.nl>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c  |   21 ---------------------
 drivers/ide/ide-iops.c |    3 ---
 include/linux/ide.h    |    2 --
 3 files changed, 26 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -361,9 +361,6 @@ static int ide_tune_dma(ide_drive_t *dri
 	if (__ide_dma_bad_drive(drive))
 		return 0;
 
-	if (ide_id_dma_bug(drive))
-		return 0;
-
 	if (hwif->host_flags & IDE_HFLAG_TRUST_BIOS_FOR_DMA)
 		return config_drive_for_dma(drive);
 
@@ -394,24 +391,6 @@ static int ide_dma_check(ide_drive_t *dr
 	return -1;
 }
 
-int ide_id_dma_bug(ide_drive_t *drive)
-{
-	u16 *id = drive->id;
-
-	if (id[ATA_ID_FIELD_VALID] & 4) {
-		if ((id[ATA_ID_UDMA_MODES] >> 8) &&
-		    (id[ATA_ID_MWDMA_MODES] >> 8))
-			goto err_out;
-	} else if ((id[ATA_ID_MWDMA_MODES] >> 8) &&
-		   (id[ATA_ID_SWDMA_MODES] >> 8))
-		goto err_out;
-
-	return 0;
-err_out:
-	printk(KERN_ERR "%s: bad DMA info in identify block\n", drive->name);
-	return 1;
-}
-
 int ide_set_dma(ide_drive_t *drive)
 {
 	int rc;
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -329,9 +329,6 @@ int ide_driveid_update(ide_drive_t *driv
 
 	kfree(id);
 
-	if ((drive->dev_flags & IDE_DFLAG_USING_DMA) && ide_id_dma_bug(drive))
-		ide_dma_off(drive);
-
 	return 1;
 out_err:
 	if (rc == 2)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1361,7 +1361,6 @@ int ide_in_drive_list(u16 *, const struc
 #ifdef CONFIG_BLK_DEV_IDEDMA
 int ide_dma_good_drive(ide_drive_t *);
 int __ide_dma_bad_drive(ide_drive_t *);
-int ide_id_dma_bug(ide_drive_t *);
 
 u8 ide_find_dma_mode(ide_drive_t *, u8);
 
@@ -1402,7 +1401,6 @@ void ide_dma_lost_irq(ide_drive_t *);
 ide_startstop_t ide_dma_timeout_retry(ide_drive_t *, int);
 
 #else
-static inline int ide_id_dma_bug(ide_drive_t *drive) { return 0; }
 static inline u8 ide_find_dma_mode(ide_drive_t *drive, u8 speed) { return 0; }
 static inline u8 ide_max_dma_mode(ide_drive_t *drive) { return 0; }
 static inline void ide_dma_off_quietly(ide_drive_t *drive) { ; }
