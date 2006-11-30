From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] (2.6.19-rc6-mm2) pdc202xx_new cleanup
Date: Thu, 30 Nov 2006 21:51:33 +0300
Message-ID: <200611302151.33319.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:63426 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1031201AbWK3SuH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Nov 2006 13:50:07 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Clean up the driver in preparation of the coming major fixes:

- replace the stupid pdcnew_new_ prefixes with mere pdcnew_;

- get rid of useless parens and type casts, clean up some printk's;

- incorporte Albert Lee's former style cleanup patch from removing spaces
  from the function definitions and adding some new lines here and there
  (http://marc.theaimsgroup.com/?l=linux-ide&m=110992442032300&w=2);

- use a better criterion for determining higher UltraDMA modes, and add
  a comment concerning the doubtful value of the IORDY/prefetch enabling
  in config_chipset_for_dma().

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/pci/pdc202xx_new.c |   60 +++++++++++++++++++++++------------------
 1 files changed, 35 insertions(+), 25 deletions(-)

Index: linux-2.6/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/pdc202xx_new.c
+++ linux-2.6/drivers/ide/pci/pdc202xx_new.c
@@ -77,7 +77,7 @@ static const char *pdc_quirk_drives[] = 
 		set_2regs(0x13,(c));			\
 	} while(0)
 
-static u8 pdcnew_ratemask (ide_drive_t *drive)
+static u8 pdcnew_ratemask(ide_drive_t *drive)
 {
 	u8 mode;
 
@@ -96,12 +96,14 @@ static u8 pdcnew_ratemask (ide_drive_t *
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
 
@@ -121,7 +123,7 @@ static int check_in_drive_lists (ide_dri
 	return 0;
 }
 
-static int pdcnew_new_tune_chipset (ide_drive_t *drive, u8 xferspeed)
+static int pdcnew_tune_chipset(ide_drive_t *drive, u8 xferspeed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	unsigned long indexreg	= hwif->dma_vendor1;
@@ -157,7 +159,7 @@ static int pdcnew_new_tune_chipset (ide_
 			;
 	}
 
-	return (ide_config_drive_speed(drive, speed));
+	return ide_config_drive_speed(drive, speed);
 }
 
 /*   0    1    2    3    4    5    6   7   8
@@ -170,34 +172,39 @@ static int pdcnew_new_tune_chipset (ide_
 static void pdcnew_tune_drive(ide_drive_t *drive, u8 pio)
 {
 	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
-	(void)pdcnew_new_tune_chipset(drive, XFER_PIO_0 + pio);
+	(void)pdcnew_tune_chipset(drive, XFER_PIO_0 + pio);
 }
 
-static u8 pdcnew_new_cable_detect (ide_hwif_t *hwif)
+static u8 pdcnew_cable_detect(ide_hwif_t *hwif)
 {
 	hwif->OUTB(0x0b, hwif->dma_vendor1);
-	return ((u8)((hwif->INB(hwif->dma_vendor3) & 0x04)));
+	return hwif->INB(hwif->dma_vendor3) & 0x04;
 }
-static int config_chipset_for_dma (ide_drive_t *drive)
+
+static int config_chipset_for_dma(ide_drive_t *drive)
 {
 	struct hd_driveid *id	= drive->id;
 	ide_hwif_t *hwif	= HWIF(drive);
-	u8 speed		= -1;
-	u8 cable;
-
-	u8 ultra_66		= ((id->dma_ultra & 0x0010) ||
-				   (id->dma_ultra & 0x0008)) ? 1 : 0;
-
-	cable = pdcnew_new_cable_detect(hwif);
+	u8 ultra_66		= (id->dma_ultra & 0x0078) ? 1 : 0;
+	u8 cable		= pdcnew_cable_detect(hwif);
+	u8 speed;
 
 	if (ultra_66 && cable) {
-		printk(KERN_WARNING "Warning: %s channel requires an 80-pin cable for operation.\n", hwif->channel ? "Secondary":"Primary");
+		printk(KERN_WARNING "Warning: %s channel "
+			"requires an 80-pin cable for operation.\n",
+		       hwif->channel ? "Secondary" : "Primary");
 		printk(KERN_WARNING "%s reduced to Ultra33 mode.\n", drive->name);
 	}
 
 	if (drive->media != ide_disk)
 		return 0;
-	if (id->capability & 4) {	/* IORDY_EN & PREFETCH_EN */
+
+	if (id->capability & 4) {
+		/*
+		 * Set IORDY_EN & PREFETCH_EN (this seems to have
+		 * NO real effect since this register is reloaded
+		 * by hardware when the transfer mode is selected)
+		 */
 		hwif->OUTB((0x13 + ((drive->dn%2) ? 0x08 : 0x00)), hwif->dma_vendor1);
 		hwif->OUTB((hwif->INB(hwif->dma_vendor3)|0x03), hwif->dma_vendor3);
 	}
@@ -211,7 +218,7 @@ static int config_chipset_for_dma (ide_d
 	return ide_dma_enable(drive);
 }
 
-static int pdcnew_config_drive_xfer_rate (ide_drive_t *drive)
+static int pdcnew_config_drive_xfer_rate(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct hd_driveid *id	= drive->id;
@@ -236,7 +243,7 @@ fast_ata_pio:
 	return 0;
 }
 
-static int pdcnew_quirkproc (ide_drive_t *drive)
+static int pdcnew_quirkproc(ide_drive_t *drive)
 {
 	return ((int) check_in_drive_lists(drive, pdc_quirk_drives));
 }
@@ -255,12 +262,12 @@ static int pdcnew_ide_dma_timeout(ide_dr
 	return __ide_dma_timeout(drive);
 }
 
-static void pdcnew_new_reset (ide_drive_t *drive)
+static void pdcnew_reset(ide_drive_t *drive)
 {
 	/*
 	 * Deleted this because it is redundant from the caller.
 	 */
-	printk(KERN_WARNING "PDC202XX: %s channel reset.\n",
+	printk(KERN_WARNING "pdc202xx_new: %s channel reset.\n",
 		HWIF(drive)->channel ? "Secondary" : "Primary");
 }
 
@@ -324,8 +331,8 @@ static void __devinit init_hwif_pdc202ne
 
 	hwif->tuneproc  = &pdcnew_tune_drive;
 	hwif->quirkproc = &pdcnew_quirkproc;
-	hwif->speedproc = &pdcnew_new_tune_chipset;
-	hwif->resetproc = &pdcnew_new_reset;
+	hwif->speedproc = &pdcnew_tune_chipset;
+	hwif->resetproc = &pdcnew_reset;
 
 	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
 
@@ -337,11 +344,14 @@ static void __devinit init_hwif_pdc202ne
 	hwif->ide_dma_check = &pdcnew_config_drive_xfer_rate;
 	hwif->ide_dma_lostirq = &pdcnew_ide_dma_lostirq;
 	hwif->ide_dma_timeout = &pdcnew_ide_dma_timeout;
-	if (!(hwif->udma_four))
-		hwif->udma_four = (pdcnew_new_cable_detect(hwif)) ? 0 : 1;
+
+	if (!hwif->udma_four)
+		hwif->udma_four = pdcnew_cable_detect(hwif) ? 0 : 1;
+
 	if (!noautodma)
 		hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
+
 #if PDC202_DEBUG_CABLE
 	printk(KERN_DEBUG "%s: %s-pin cable\n",
 		hwif->name, hwif->udma_four ? "80" : "40");

