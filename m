From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH 4/5] pata-rb532-cf: use ata_sff_data_xfer32()
Date: Tue, 20 Jan 2009 17:40:59 +0100
Message-ID: <20090120164309.CC920400E135@mail.nwl.cc>
References: <20081128194607.93677386B1A7@mail.ifyouseekate.net>
 <1232469660-22335-1-git-send-email-n0-1@freewrt.org>
 <1232469660-22335-2-git-send-email-n0-1@freewrt.org>
 <1232469660-22335-3-git-send-email-n0-1@freewrt.org>
 <1232469660-22335-4-git-send-email-n0-1@freewrt.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:53826 "EHLO mail.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757750AbZATQtl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2009 11:49:41 -0500
In-Reply-To: <1232469660-22335-4-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, bzolnier@gmail.com, florian@openwrt.org

The biggest difference between rb532_pata_data_xfer() and
ata_sff_data_xfer32() is the call to ata_sff_pause() at the end of
rb532_pata_data_xfer() which I suppose to be unnecessary since it works
without. I've also tested using ata_sff_data_xfer() as replacement, but
since we know that the driver supports 32bit IO, using the optimised
version should be safe.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 drivers/ata/pata_rb532_cf.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 11a4411..9fb91e4 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -54,21 +54,6 @@ struct rb532_cf_info {
 
 /* ------------------------------------------------------------------------ */
 
-static unsigned int rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
-				unsigned int buflen, int write_data)
-{
-	struct ata_port *ap = adev->link->ap;
-	void __iomem *ioaddr = ap->ioaddr.data_addr;
-
-	if (write_data)
-		writesl(ioaddr, buf, buflen / sizeof(u32));
-	else
-		readsl(ioaddr, buf, buflen / sizeof(u32));
-
-	ata_sff_pause(ap);
-	return buflen - buflen % sizeof(u32);
-}
-
 static void rb532_pata_freeze(struct ata_port *ap)
 {
 	struct rb532_cf_info *info = ap->host->private_data;
@@ -101,7 +86,7 @@ static irqreturn_t rb532_pata_irq_handler(int irq, void *dev_instance)
 
 static struct ata_port_operations rb532_pata_port_ops = {
 	.inherits		= &ata_sff_port_ops,
-	.sff_data_xfer		= rb532_pata_data_xfer,
+	.sff_data_xfer		= ata_sff_data_xfer32,
 	.freeze			= rb532_pata_freeze,
 	.thaw			= rb532_pata_thaw,
 };
-- 
1.5.6.4

