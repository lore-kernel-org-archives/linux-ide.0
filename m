From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH 4/5] pata-rb532-cf: use ata_sff_data_xfer32()
Date: Tue, 27 Jan 2009 14:35:52 +0100
Message-ID: <20090127133601.B96534CD65@mail.nwl.cc>
References: <20090127133329.3A3F04CD65@mail.nwl.cc>
 <1233063353-12770-1-git-send-email-n0-1@freewrt.org>
 <1233063353-12770-2-git-send-email-n0-1@freewrt.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:35218 "EHLO mail.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752741AbZA0NgD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 08:36:03 -0500
In-Reply-To: <1233063353-12770-2-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, florian@openwrt.org

The biggest difference between rb532_pata_data_xfer() and
ata_sff_data_xfer32() is the call to ata_sff_pause() at the end of
rb532_pata_data_xfer() which I suppose to be unnecessary since it works
without. I've also tested using ata_sff_data_xfer() as replacement, but
since we know that the driver supports 32bit IO, using the optimised
version should be safe.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 drivers/ata/pata_rb532_cf.c |   21 +--------------------
 1 files changed, 1 insertions(+), 20 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 9d61ce5..9fb91e4 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -54,25 +54,6 @@ struct rb532_cf_info {
 
 /* ------------------------------------------------------------------------ */
 
-static unsigned int rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
-				unsigned int buflen, int write_data)
-{
-	struct ata_port *ap = adev->link->ap;
-	void __iomem *ioaddr = ap->ioaddr.data_addr;
-	int retlen = buflen;
-
-	if (write_data) {
-		for (; buflen > 0; buflen--, buf++)
-			writeb(*buf, ioaddr);
-	} else {
-		for (; buflen > 0; buflen--, buf++)
-			*buf = readb(ioaddr);
-	}
-
-	ata_sff_pause(ap);
-	return retlen;
-}
-
 static void rb532_pata_freeze(struct ata_port *ap)
 {
 	struct rb532_cf_info *info = ap->host->private_data;
@@ -105,7 +86,7 @@ static irqreturn_t rb532_pata_irq_handler(int irq, void *dev_instance)
 
 static struct ata_port_operations rb532_pata_port_ops = {
 	.inherits		= &ata_sff_port_ops,
-	.sff_data_xfer		= rb532_pata_data_xfer,
+	.sff_data_xfer		= ata_sff_data_xfer32,
 	.freeze			= rb532_pata_freeze,
 	.thaw			= rb532_pata_thaw,
 };
-- 
1.5.6.4

