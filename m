From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [patch 2/9] drive->nice1 fix
Date: Fri, 4 Feb 2005 03:48:55 +0100 (CET)
Message-ID: <Pine.GSO.4.58.0502040348080.4393@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:28340 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261821AbVBDCuH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Feb 2005 21:50:07 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58435 "EHLO
	mion.elka.pw.edu.pl") by higgs.elka.pw.edu.pl with ESMTP
	id S103974AbVBDCs4 (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 1 other); Fri, 4 Feb 2005 03:48:56 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


It is drive's property independent of the driver being used so move
drive->nice1 setup from ide_register_subdriver() to probe_hwif() in
ide-probe.c.  As a result changing a driver which controls the drive
no longer affects this flag.

diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2005-02-04 03:30:55 +01:00
+++ b/drivers/ide/ide-probe.c	2005-02-04 03:30:55 +01:00
@@ -862,6 +862,13 @@
 				drive->autotune == IDE_TUNE_AUTO)
 				/* auto-tune PIO mode */
 				hwif->tuneproc(drive, 255);
+
+			if (drive->autotune != IDE_TUNE_DEFAULT &&
+			    drive->autotune != IDE_TUNE_AUTO)
+				continue;
+
+			drive->nice1 = 1;
+
 			/*
 			 * MAJOR HACK BARF :-/
 			 *
@@ -871,9 +878,7 @@
 			 * Move here to prevent module loading clashing.
 			 */
 	//		drive->autodma = hwif->autodma;
-			if ((hwif->ide_dma_check) &&
-				((drive->autotune == IDE_TUNE_DEFAULT) ||
-				(drive->autotune == IDE_TUNE_AUTO))) {
+			if (hwif->ide_dma_check) {
 				/*
 				 * Force DMAing for the beginning of the check.
 				 * Some chipsets appear to do interesting
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-02-04 03:30:55 +01:00
+++ b/drivers/ide/ide.c	2005-02-04 03:30:55 +01:00
@@ -2033,7 +2033,6 @@
 		(drive->autotune == IDE_TUNE_AUTO)) {
 		/* DMA timings and setup moved to ide-probe.c */
 		drive->dsc_overlap = (drive->next != drive && driver->supports_dsc_overlap);
-		drive->nice1 = 1;
 	}
 #ifdef CONFIG_PROC_FS
 	if (drive->driver != &idedefault_driver)
