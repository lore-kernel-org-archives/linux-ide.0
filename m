From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [patch 4/9] destroy_proc_ide_device() cleanup
Date: Fri, 4 Feb 2005 03:50:04 +0100 (CET)
Message-ID: <Pine.GSO.4.58.0502040349370.4393@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:28340 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S263226AbVBDCxe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Feb 2005 21:53:34 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58435 "EHLO
	mion.elka.pw.edu.pl") by higgs.elka.pw.edu.pl with ESMTP
	id S103922AbVBDCuF (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 1 other); Fri, 4 Feb 2005 03:50:05 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


When this function is called device is already unbinded from a
driver so there are no driver /proc entries to remove.

diff -Nru a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
--- a/drivers/ide/ide-proc.c	2005-02-04 03:31:24 +01:00
+++ b/drivers/ide/ide-proc.c	2005-02-04 03:31:24 +01:00
@@ -421,10 +421,7 @@

 static void destroy_proc_ide_device(ide_hwif_t *hwif, ide_drive_t *drive)
 {
-	ide_driver_t *driver = drive->driver;
-
 	if (drive->proc) {
-		ide_remove_proc_entries(drive->proc, driver->proc);
 		ide_remove_proc_entries(drive->proc, generic_drive_entries);
 		remove_proc_entry(drive->name, proc_ide_root);
 		remove_proc_entry(drive->name, hwif->proc);
