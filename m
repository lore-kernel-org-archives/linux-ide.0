From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH ide-2.6 1/3] pdc202xx_new: PLL initialization support
Date: Fri, 04 Mar 2005 16:14:57 +0800
Message-ID: <42281901.8000803@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:10214 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262631AbVCDIPO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Mar 2005 03:15:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>


Hi Bart,

   These are the patches for pdc202xx_new PLL initialization support. It is to fix
the problem when there are more than two pdc202xx adapters, the on board firmware does
not initialize the PLL for the 3rd/4th... adapters. As in:
http://marc.theaimsgroup.com/?l=linux-ide&m=110902518625384&w=2

   Attached please find the patch 1/3 against the ide-2.6 tree for your review. Thanks.

Changes:
1/3: Remove spaces in function declaration and add new lines.
2/3: Replace the index register macros with functions
3/3: Add PLL initialization code

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
-----------------------------------------------------------------------------------------------------------
diff -Nru libata-dev-2.6-1/drivers/ide/pci/pdc202xx_new.c libata-dev-2.6-2/drivers/ide/pci/pdc202xx_new.c
--- libata-dev-2.6-1/drivers/ide/pci/pdc202xx_new.c	2005-03-03 14:53:07.000000000 +0800
+++ libata-dev-2.6-2/drivers/ide/pci/pdc202xx_new.c	2005-03-03 17:54:56.000000000 +0800
@@ -77,7 +77,7 @@
  		set_2regs(0x13,(c));			\
  	} while(0)

-static u8 pdcnew_ratemask (ide_drive_t *drive)
+static u8 pdcnew_ratemask(ide_drive_t *drive)
  {
  	u8 mode;

@@ -96,12 +96,14 @@
  		default:
  			return 0;
  	}
+
  	if (!eighty_ninty_three(drive))
  		mode = min(mode, (u8)1);
+
  	return mode;
  }

-static int check_in_drive_lists (ide_drive_t *drive, const char **list)
+static int check_in_drive_lists(ide_drive_t *drive, const char **list)
  {
  	struct hd_driveid *id = drive->id;

@@ -121,7 +123,7 @@
  	return 0;
  }

-static int pdcnew_new_tune_chipset (ide_drive_t *drive, u8 xferspeed)
+static int pdcnew_new_tune_chipset(ide_drive_t *drive, u8 xferspeed)
  {
  	ide_hwif_t *hwif	= HWIF(drive);
  	unsigned long indexreg	= hwif->dma_vendor1;
@@ -177,12 +179,12 @@
  	(void)pdcnew_new_tune_chipset(drive, speed);
  }

-static u8 pdcnew_new_cable_detect (ide_hwif_t *hwif)
+static u8 pdcnew_new_cable_detect(ide_hwif_t *hwif)
  {
  	hwif->OUTB(0x0b, hwif->dma_vendor1);
  	return ((u8)((hwif->INB(hwif->dma_vendor3) & 0x04)));
  }
-static int config_chipset_for_dma (ide_drive_t *drive)
+static int config_chipset_for_dma(ide_drive_t *drive)
  {
  	struct hd_driveid *id	= drive->id;
  	ide_hwif_t *hwif	= HWIF(drive);
@@ -201,6 +203,7 @@

  	if (drive->media != ide_disk)
  		return 0;
+
  	if (id->capability & 4) {	/* IORDY_EN & PREFETCH_EN */
  		hwif->OUTB((0x13 + ((drive->dn%2) ? 0x08 : 0x00)), hwif->dma_vendor1);
  		hwif->OUTB((hwif->INB(hwif->dma_vendor3)|0x03), hwif->dma_vendor3);
@@ -217,7 +220,7 @@
  	return ide_dma_enable(drive);
  }

-static int pdcnew_config_drive_xfer_rate (ide_drive_t *drive)
+static int pdcnew_config_drive_xfer_rate(ide_drive_t *drive)
  {
  	ide_hwif_t *hwif	= HWIF(drive);
  	struct hd_driveid *id	= drive->id;
@@ -242,7 +245,7 @@
  	return 0;
  }

-static int pdcnew_quirkproc (ide_drive_t *drive)
+static int pdcnew_quirkproc(ide_drive_t *drive)
  {
  	return ((int) check_in_drive_lists(drive, pdc_quirk_drives));
  }
@@ -261,7 +264,7 @@
  	return __ide_dma_timeout(drive);
  }

-static void pdcnew_new_reset (ide_drive_t *drive)
+static void pdcnew_new_reset(ide_drive_t *drive)
  {
  	/*
  	 * Deleted this because it is redundant from the caller.
@@ -341,10 +344,13 @@
  	hwif->ide_dma_check = &pdcnew_config_drive_xfer_rate;
  	hwif->ide_dma_lostirq = &pdcnew_ide_dma_lostirq;
  	hwif->ide_dma_timeout = &pdcnew_ide_dma_timeout;
+
  	if (!(hwif->udma_four))
  		hwif->udma_four = (pdcnew_new_cable_detect(hwif)) ? 0 : 1;
+
  	if (!noautodma)
  		hwif->autodma = 1;
+
  	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
  #if PDC202_DEBUG_CABLE
  	printk(KERN_DEBUG "%s: %s-pin cable\n",



