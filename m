From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] drivers/ide/Kconfig: make PDC4030 VLB IDE support dependent on X86
Date: Tue, 20 Apr 2004 23:14:47 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404202313.52512.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:19358 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264539AbUDTVPg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Apr 2004 17:15:36 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Also add FIXME about improper ide_init_hwif_ports() usage to pdc4030.c.

 linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/Kconfig          |    2 +-
 linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/legacy/pdc4030.c |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/ide/Kconfig~pdc4030_x86 drivers/ide/Kconfig
--- linux-2.6.6-rc1-bk5/drivers/ide/Kconfig~pdc4030_x86	2004-04-20 22:05:39.977020112 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/Kconfig	2004-04-20 22:06:45.065125216 +0200
@@ -1062,7 +1062,7 @@ config BLK_DEV_HT6560B
 
 config BLK_DEV_PDC4030
 	tristate "PROMISE DC4030 support (EXPERIMENTAL)"
-	depends on BLK_DEV_IDEDISK && EXPERIMENTAL
+	depends on X86 && BLK_DEV_IDEDISK && EXPERIMENTAL
 	help
 	  This driver provides support for the secondary IDE interface and
 	  cache of the original Promise IDE chipsets, e.g. DC4030 and DC5030.
diff -puN drivers/ide/legacy/pdc4030.c~pdc4030_x86 drivers/ide/legacy/pdc4030.c
--- linux-2.6.6-rc1-bk5/drivers/ide/legacy/pdc4030.c~pdc4030_x86	2004-04-20 22:05:44.844280176 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/legacy/pdc4030.c	2004-04-20 22:08:09.484291552 +0200
@@ -242,6 +242,7 @@ int __init setup_pdc4030(ide_hwif_t *hwi
 #ifdef DEBUG
 		printk(KERN_DEBUG "pdc4030: Shifting i/f %d values to i/f %d\n",i-1,i);
 #endif /* DEBUG */
+		/* FIXME: this screws already used hwifs */
 		ide_init_hwif_ports(&h->hw, (h-1)->io_ports[IDE_DATA_OFFSET], 0, NULL);
 		memcpy(h->io_ports, h->hw.io_ports, sizeof(h->io_ports));
 		h->noprobe = (h-1)->noprobe;

_

