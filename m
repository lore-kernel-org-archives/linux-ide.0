From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] trivial IDE cleanups for 2.6.5-rc2-bk3 (4/4)
Date: Tue, 23 Mar 2004 19:40:39 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403231940.39360.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64430 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262797AbUCWSd0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Mar 2004 13:33:26 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


[IDE] remove not needed ide_hwif_t->pnp_dev

 linux-2.6.5-rc2-bk3-root/drivers/ide/ide-pnp.c |    1 -
 linux-2.6.5-rc2-bk3-root/include/linux/ide.h   |    2 --
 2 files changed, 3 deletions(-)

diff -puN drivers/ide/ide-pnp.c~ide_pnp_dev drivers/ide/ide-pnp.c
--- linux-2.6.5-rc2-bk3/drivers/ide/ide-pnp.c~ide_pnp_dev	2004-03-23 19:26:39.731953616 +0100
+++ linux-2.6.5-rc2-bk3-root/drivers/ide/ide-pnp.c	2004-03-23 19:26:39.738952552 +0100
@@ -64,7 +64,6 @@ static int idepnp_probe(struct pnp_dev *
 	if (index != -1) {
 	    	printk(KERN_INFO "ide%d: generic PnP IDE interface\n", index);
 		pnp_set_drvdata(dev,hwif);
-		hwif->pnp_dev = dev;
 		return 0;
 	}
 
diff -puN include/linux/ide.h~ide_pnp_dev include/linux/ide.h
--- linux-2.6.5-rc2-bk3/include/linux/ide.h~ide_pnp_dev	2004-03-23 19:26:39.735953008 +0100
+++ linux-2.6.5-rc2-bk3-root/include/linux/ide.h	2004-03-23 19:26:39.740952248 +0100
@@ -849,8 +849,6 @@ typedef struct hwif_s {
 
 	struct pci_dev  *pci_dev;	/* for pci chipsets */
 	struct ide_pci_device_s	*cds;	/* chipset device struct */
-	
-	struct pnp_dev  *pnp_dev;	/* for PnP devices */
 
 	ide_startstop_t (*rw_disk)(ide_drive_t *, struct request *, sector_t);
 

_

