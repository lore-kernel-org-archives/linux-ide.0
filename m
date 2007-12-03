From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/6] ide: remove stale changelog from ide-probe.c
Date: Mon, 3 Dec 2007 22:52:14 +0100
Message-ID: <200712032252.14953.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:20822 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbXLCVrQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 16:47:16 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2458801ugc
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2007 13:47:14 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -13,22 +13,8 @@
  *
  * This is the IDE probe module, as evolved from hd.c and ide.c.
  *
- * Version 1.00		move drive probing code from ide.c to ide-probe.c
- * Version 1.01		fix compilation problem for m68k
- * Version 1.02		increase WAIT_PIDENTIFY to avoid CD-ROM locking at boot
- *			 by Andrea Arcangeli
- * Version 1.03		fix for (hwif->chipset == ide_4drives)
- * Version 1.04		fixed buggy treatments of known flash memory cards
- *
- * Version 1.05		fix for (hwif->chipset == ide_pdc4030)
- *			added ide6/7/8/9
- *			allowed for secondary flash card to be detectable
- *			 with new flag : drive->ata_flash : 1;
- * Version 1.06		stream line request queue and prep for cascade project.
- * Version 1.07		max_sect <= 255; slower disks would get behind and
- * 			then fall over when they get to 256.	Paul G.
- * Version 1.10		Update set for new IDE. drive->id is now always
- *			valid after probe time even with noprobe
+ * -- increase WAIT_PIDENTIFY to avoid CD-ROM locking at boot
+ *	 by Andrea Arcangeli
  */
 
 #include <linux/module.h>
