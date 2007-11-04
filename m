From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 17/18] ide: cleanup ide_set_dma()
Date: Mon, 5 Nov 2007 00:33:58 +0100
Message-ID: <200711050033.58423.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:52438 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336AbXKDX3t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:49 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219945nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:47 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* ->dma_off_quietly is always called before ide_set_dma()
  so the call can be moved inside ide_set_dma().

* ide_dma_check() doesn't touch hardware so ->dma_off_quietly
  call for 'rc == -1' case is redundant, remove it.

* '0' and '-1' are the only values returned by ide_dma_check()
  so remove dead code for other cases.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c   |   25 +++++++++++--------------
 drivers/ide/ide-io.c    |    1 -
 drivers/ide/ide-probe.c |   10 +---------
 drivers/ide/ide.c       |    1 -
 4 files changed, 12 insertions(+), 25 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -862,22 +862,19 @@ int ide_set_dma(ide_drive_t *drive)
 	ide_hwif_t *hwif = drive->hwif;
 	int rc;
 
-	rc = ide_dma_check(drive);
+	/*
+	 * Force DMAing for the beginning of the check.
+	 * Some chipsets appear to do interesting
+	 * things, if not checked and cleared.
+	 *   PARANOIA!!!
+	 */
+	hwif->dma_off_quietly(drive);
 
-	switch(rc) {
-	case -1: /* DMA needs to be disabled */
-		hwif->dma_off_quietly(drive);
-		return -1;
-	case  0: /* DMA needs to be enabled */
-		return hwif->ide_dma_on(drive);
-	case  1: /* DMA setting cannot be changed */
-		break;
-	default:
-		BUG();
-		break;
-	}
+	rc = ide_dma_check(drive);
+	if (rc)
+		return rc;
 
-	return rc;
+	return hwif->ide_dma_on(drive);
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -221,7 +221,6 @@ static ide_startstop_t ide_start_power_s
 		 */
 		if (drive->hwif->ide_dma_on == NULL)
 			break;
-		drive->hwif->dma_off_quietly(drive);
 		/*
 		 * TODO: respect ->using_dma setting
 		 */
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -840,16 +840,8 @@ static void probe_hwif(ide_hwif_t *hwif)
 
 			drive->nice1 = 1;
 
-			if (hwif->ide_dma_on) {
-				/*
-				 * Force DMAing for the beginning of the check.
-				 * Some chipsets appear to do interesting
-				 * things, if not checked and cleared.
-				 *   PARANOIA!!!
-				 */
-				hwif->dma_off_quietly(drive);
+			if (hwif->ide_dma_on)
 				ide_set_dma(drive);
-			}
 		}
 	}
 
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -845,7 +845,6 @@ int set_using_dma(ide_drive_t *drive, in
 	err = 0;
 
 	if (arg) {
-		hwif->dma_off_quietly(drive);
 		if (ide_set_dma(drive))
 			err = -EIO;
 	} else
