From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH 5/5] pata-rb532-cf: drop custom freeze and thaw
Date: Tue, 20 Jan 2009 17:41:00 +0100
Message-ID: <20090120164306.ECA26400E133@mail.nwl.cc>
References: <20081128194607.93677386B1A7@mail.ifyouseekate.net>
 <1232469660-22335-1-git-send-email-n0-1@freewrt.org>
 <1232469660-22335-2-git-send-email-n0-1@freewrt.org>
 <1232469660-22335-3-git-send-email-n0-1@freewrt.org>
 <1232469660-22335-4-git-send-email-n0-1@freewrt.org>
 <1232469660-22335-5-git-send-email-n0-1@freewrt.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:53824 "EHLO mail.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757385AbZATQtl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2009 11:49:41 -0500
In-Reply-To: <1232469660-22335-5-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, bzolnier@gmail.com, florian@openwrt.org

I'm not quite sure what freezing and thawing is used for. Tests showed
that the port is being frozen at initialisation state and thawed right
afterwards, then the functions were not called anymore. Dropping the
complete custom code for handling the frozen state seems to work at
least for a standard use case including mounting a partition, copying
some files in it (in parallel) and finally removing them and unmounting
the partition.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 drivers/ata/pata_rb532_cf.c |   20 +-------------------
 1 files changed, 1 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 9fb91e4..fbfee1b 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -48,26 +48,11 @@
 struct rb532_cf_info {
 	void __iomem	*iobase;
 	unsigned int	gpio_line;
-	int		frozen;
 	unsigned int	irq;
 };
 
 /* ------------------------------------------------------------------------ */
 
-static void rb532_pata_freeze(struct ata_port *ap)
-{
-	struct rb532_cf_info *info = ap->host->private_data;
-
-	info->frozen = 1;
-}
-
-static void rb532_pata_thaw(struct ata_port *ap)
-{
-	struct rb532_cf_info *info = ap->host->private_data;
-
-	info->frozen = 0;
-}
-
 static irqreturn_t rb532_pata_irq_handler(int irq, void *dev_instance)
 {
 	struct ata_host *ah = dev_instance;
@@ -75,8 +60,7 @@ static irqreturn_t rb532_pata_irq_handler(int irq, void *dev_instance)
 
 	if (gpio_get_value(info->gpio_line)) {
 		set_irq_type(info->irq, IRQ_TYPE_LEVEL_LOW);
-		if (!info->frozen)
-			ata_sff_interrupt(info->irq, dev_instance);
+		ata_sff_interrupt(info->irq, dev_instance);
 	} else {
 		set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
 	}
@@ -87,8 +71,6 @@ static irqreturn_t rb532_pata_irq_handler(int irq, void *dev_instance)
 static struct ata_port_operations rb532_pata_port_ops = {
 	.inherits		= &ata_sff_port_ops,
 	.sff_data_xfer		= ata_sff_data_xfer32,
-	.freeze			= rb532_pata_freeze,
-	.thaw			= rb532_pata_thaw,
 };
 
 /* ------------------------------------------------------------------------ */
-- 
1.5.6.4

