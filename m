From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2] ide: add support for CFA specified transfer modes
Date: Tue, 3 Mar 2009 21:34:49 +0400
Message-ID: <200903032034.49372.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.79.90.228] ([213.79.90.228]:41213 "EHLO
	buildserver.ru.mvista.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751309AbZCCReR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Mar 2009 12:34:17 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, stf_xl@wp.pl

Add support for the CompactFlash specific PIO modes 5/6 and MWDMA modes 3/4.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the current pata-2.6 series. Since there were no PIO5
capable hard drives produced and you also need 66 MHz input clock to actually
get the difference WRT the setup timing programmed, I decided to simply replace
the old non-standard PIO mode 5 timings with CFA specified ones.
Phew, hopefully I haven't overlooked anything -- quite a lot had to be changed.

Stanislaw, please give it a try -- I don't have any CF hardware now.

 drivers/ide/ide-dma.c       |    8 ++++++++
 drivers/ide/ide-iops.c      |    8 ++++++++
 drivers/ide/ide-timings.c   |   12 ++++++++++--
 drivers/ide/ide-xfer-mode.c |   15 +++++++++------
 4 files changed, 35 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma.c
+++ linux-2.6/drivers/ide/ide-dma.c
@@ -261,6 +261,14 @@ static unsigned int ide_get_mode_mask(id
 		break;
 	case XFER_MW_DMA_0:
 		mask = id[ATA_ID_MWDMA_MODES];
+
+		/* Also look for the CF specific MWDMA modes... */
+		if (ata_id_is_cfa(id) && (id[ATA_ID_CFA_MODES] & 0x38)) {
+			u8 mode = ((id[ATA_ID_CFA_MODES] & 0x38) >> 3) - 1;
+
+			mask |= ((2 << mode) - 1) << 3;
+		}
+
 		if (port_ops && port_ops->mdma_filter)
 			mask &= port_ops->mdma_filter(drive);
 		else
Index: linux-2.6/drivers/ide/ide-iops.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-iops.c
+++ linux-2.6/drivers/ide/ide-iops.c
@@ -389,6 +389,8 @@ int ide_config_drive_speed(ide_drive_t *
 	id[ATA_ID_UDMA_MODES]  &= ~0xFF00;
 	id[ATA_ID_MWDMA_MODES] &= ~0x0F00;
 	id[ATA_ID_SWDMA_MODES] &= ~0x0F00;
+	if (ata_id_is_cfa(id))
+		id[ATA_ID_CFA_MODES] &= ~0x0F30;
 
  skip:
 #ifdef CONFIG_BLK_DEV_IDEDMA
@@ -401,12 +403,18 @@ int ide_config_drive_speed(ide_drive_t *
 	if (speed >= XFER_UDMA_0) {
 		i = 1 << (speed - XFER_UDMA_0);
 		id[ATA_ID_UDMA_MODES] |= (i << 8 | i);
+	} else if (ata_id_is_cfa(id) && speed >= XFER_MW_DMA_3) {
+		i = speed - XFER_MW_DMA_2;
+		id[ATA_ID_CFA_MODES] |= i << 9;
 	} else if (speed >= XFER_MW_DMA_0) {
 		i = 1 << (speed - XFER_MW_DMA_0);
 		id[ATA_ID_MWDMA_MODES] |= (i << 8 | i);
 	} else if (speed >= XFER_SW_DMA_0) {
 		i = 1 << (speed - XFER_SW_DMA_0);
 		id[ATA_ID_SWDMA_MODES] |= (i << 8 | i);
+	} else if (ata_id_is_cfa(id) && speed >= XFER_PIO_5) {
+		i = speed - XFER_PIO_4;
+		id[ATA_ID_CFA_MODES] |= i << 6;
 	}
 
 	if (!drive->init_speed)
Index: linux-2.6/drivers/ide/ide-timings.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-timings.c
+++ linux-2.6/drivers/ide/ide-timings.c
@@ -43,6 +43,8 @@ static struct ide_timing ide_timing[] = 
 	{ XFER_UDMA_1,     0,   0,   0,   0,   0,   0,   0,  80 },
 	{ XFER_UDMA_0,     0,   0,   0,   0,   0,   0,   0, 120 },
 
+	{ XFER_MW_DMA_4,  25,   0,   0,   0,  55,  20,  80,   0 },
+	{ XFER_MW_DMA_3,  25,   0,   0,   0,  65,  25, 100,   0 },
 	{ XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 120,   0 },
 	{ XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 150,   0 },
 	{ XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 480,   0 },
@@ -51,7 +53,8 @@ static struct ide_timing ide_timing[] = 
 	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 480,   0 },
 	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 960,   0 },
 
-	{ XFER_PIO_5,     20,  50,  30, 100,  50,  30, 100,   0 },
+	{ XFER_PIO_6,     10,  55,  20,  80,  55,  20,  80,   0 },
+	{ XFER_PIO_5,     15,  65,  25, 100,  65,  25, 100,   0 },
 	{ XFER_PIO_4,     25,  70,  25, 120,  70,  25, 120,   0 },
 	{ XFER_PIO_3,     30,  80,  70, 180,  80,  70, 180,   0 },
 
@@ -90,6 +93,10 @@ u16 ide_pio_cycle_time(ide_drive_t *driv
 		/* conservative "downgrade" for all pre-ATA2 drives */
 		if (pio < 3 && cycle < t->cycle)
 			cycle = 0; /* use standard timing */
+
+		/* IORDY must be ignored for CF specific PIO modes */
+		if (pio > 4 && ata_id_is_cfa(id))
+			cycle = 0; /* use standard timing */
 	}
 
 	return cycle ? cycle : t->cycle;
@@ -161,7 +168,8 @@ int ide_timing_compute(ide_drive_t *driv
 
 		if (speed <= XFER_PIO_2)
 			p.cycle = p.cyc8b = id[ATA_ID_EIDE_PIO];
-		else if (speed <= XFER_PIO_5)
+		else if ((speed <= XFER_PIO_4) ||
+			 (speed == XFER_PIO_5 && !ata_id_is_cfa(id)))
 			p.cycle = p.cyc8b = id[ATA_ID_EIDE_PIO_IORDY];
 		else if (speed >= XFER_MW_DMA_0 && speed <= XFER_MW_DMA_2)
 			p.cycle = id[ATA_ID_EIDE_DMA_MIN];
Index: linux-2.6/drivers/ide/ide-xfer-mode.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-xfer-mode.c
+++ linux-2.6/drivers/ide/ide-xfer-mode.c
@@ -9,11 +9,11 @@ static const char *udma_str[] =
 	 { "UDMA/16", "UDMA/25",  "UDMA/33",  "UDMA/44",
 	   "UDMA/66", "UDMA/100", "UDMA/133", "UDMA7" };
 static const char *mwdma_str[] =
-	{ "MWDMA0", "MWDMA1", "MWDMA2" };
+	{ "MWDMA0", "MWDMA1", "MWDMA2", "MWDMA3", "MWDMA4" };
 static const char *swdma_str[] =
 	{ "SWDMA0", "SWDMA1", "SWDMA2" };
 static const char *pio_str[] =
-	{ "PIO0", "PIO1", "PIO2", "PIO3", "PIO4", "PIO5" };
+	{ "PIO0", "PIO1", "PIO2", "PIO3", "PIO4", "PIO5", "PIO6" };
 
 /**
  *	ide_xfer_verbose	-	return IDE mode names
@@ -30,11 +30,11 @@ const char *ide_xfer_verbose(u8 mode)
 
 	if (mode >= XFER_UDMA_0 && mode <= XFER_UDMA_7)
 		s = udma_str[i];
-	else if (mode >= XFER_MW_DMA_0 && mode <= XFER_MW_DMA_2)
+	else if (mode >= XFER_MW_DMA_0 && mode <= XFER_MW_DMA_4)
 		s = mwdma_str[i];
 	else if (mode >= XFER_SW_DMA_0 && mode <= XFER_SW_DMA_2)
 		s = swdma_str[i];
-	else if (mode >= XFER_PIO_0 && mode <= XFER_PIO_5)
+	else if (mode >= XFER_PIO_0 && mode <= XFER_PIO_6)
 		s = pio_str[i & 0x7];
 	else if (mode == XFER_PIO_SLOW)
 		s = "PIO SLOW";
@@ -79,7 +79,10 @@ u8 ide_get_best_pio_mode(ide_drive_t *dr
 		}
 
 		if (id[ATA_ID_FIELD_VALID] & 2) {	      /* ATA2? */
-			if (ata_id_has_iordy(id)) {
+			if (ata_id_is_cfa(id) && (id[ATA_ID_CFA_MODES] & 7))
+				pio_mode = 4 + min_t(int, 2,
+						     id[ATA_ID_CFA_MODES] & 7);
+			else if (ata_id_has_iordy(id)) {
 				if (id[ATA_ID_PIO_MODES] & 7) {
 					overridden = 0;
 					if (id[ATA_ID_PIO_MODES] & 4)
@@ -239,7 +242,7 @@ int ide_set_xfer_rate(ide_drive_t *drive
 
 	BUG_ON(rate < XFER_PIO_0);
 
-	if (rate >= XFER_PIO_0 && rate <= XFER_PIO_5)
+	if (rate >= XFER_PIO_0 && rate <= XFER_PIO_6)
 		return ide_set_pio_mode(drive, rate);
 
 	return ide_set_dma_mode(drive, rate);

