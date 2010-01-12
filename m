From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] ide/ide-cs: fix order of releasing resources
Date: Tue, 12 Jan 2010 20:34:54 +0100
Message-ID: <1263324894-28117-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59985 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503Ab0ALTeT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jan 2010 14:34:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-pcmcia@lists.infradead.org, Wolfram Sang <w.sang@pengutronix.de>, Dominik Brodowski <linux@dominikbrodowski.net>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "David S. Miller" <davem@davemloft.net>

ide_detach() called first ide_release() and then release_region(). This
produced the following warnings:

  Trying to free nonexistent resource <000000000000c10e-000000000000c10e>
  Trying to free nonexistent resource <000000000000c100-000000000000c107>

This is true, because the callchain inside ide_release() is:

  ide_release -> pcmcia_disable_device -> pcmcia_release_io

So, the whole io-block is already gone for release_region(). To fix
this, just swap the order of releasing (and remove the now obsolete
shadowing).

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 drivers/ide/ide-cs.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/ide/ide-cs.c b/drivers/ide/ide-cs.c
index dd63963..43ed330 100644
--- a/drivers/ide/ide-cs.c
+++ b/drivers/ide/ide-cs.c
@@ -122,18 +122,14 @@ static void ide_detach(struct pcmcia_device *link)
 {
     ide_info_t *info = link->priv;
     ide_hwif_t *hwif = info->host->ports[0];
-    unsigned long data_addr, ctl_addr;
 
     dev_dbg(&link->dev, "ide_detach(0x%p)\n", link);
 
-    data_addr = hwif->io_ports.data_addr;
-    ctl_addr  = hwif->io_ports.ctl_addr;
+    release_region(hwif->io_ports.ctl_addr, 1);
+    release_region(hwif->io_ports.data_addr, 8);
 
     ide_release(link);
 
-    release_region(ctl_addr, 1);
-    release_region(data_addr, 8);
-
     kfree(info);
 } /* ide_detach */
 
-- 
1.6.3.3

